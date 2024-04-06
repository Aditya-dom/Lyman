// To create both an Auth and Sign API, you can use the Web3App
// If you just need one of the other, replace Web3App with SignClient or AuthClient
// SignClient wcClient = await SignClient.createInstance(
// AuthClient wcClient = await AuthClient.createInstance(
Web3App wcClient = await Web3App.createInstance(
  relayUrl: 'wss://relay.walletconnect.com', // The relay websocket URL, leave blank to use the default
  projectId: '123',
  metadata: PairingMetadata(
    name: 'dApp (Requester)',
    description: 'A dapp that can request that transactions be signed',
    url: 'https://walletconnect.com',
    icons: ['https://avatars.githubusercontent.com/u/37784886'],
  ),
);

// For a dApp, you would connect with specific parameters, then display
// the returned URI.
ConnectResponse resp = await wcClient.connect(
  requiredNamespaces: {
    'eip155': RequiredNamespace(
      chains: ['eip155:1'], // Ethereum chain
      methods: ['personal_sign'], // Requestable Methods, see MethodsConstants for reference
      events: ['chainChanged'], // Requestable Events, see EventsConstants for reference
    ),
  },
  optionalNamespaces: {
    'eip155': RequiredNamespace(
      chains: ['eip155:1', 'eip155:5'], // Any other optional Ethereum chain
      methods: ['eth_signTransaction'], // Optional requestable Methods, see MethodsConstants for reference
      events: ['accountsChanged'], // Optional requestable events, see EventsConstants for reference
    ),
  },
);
Uri? uri = resp.uri;

// Once you've display the URI, you can wait for the future, and hide the QR code once you've received session data
final SessionData session = await resp.session.future;

// Now that you have a session, you can request signatures
final dynamic signResponse = await wcClient.request(
  topic: session.topic,
  chainId: 'eip155:1',
  request: SessionRequestParams(
    method: 'eth_signTransaction',
    params: '{json serializable parameters}',
  ),
);
// Unpack, or use the signResponse.
// Structure is dependant upon the JSON RPC call you made.


// You can also request authentication
final AuthRequestResponse authReq = await wcClient.requestAuth(
  params: AuthRequestParams(
    aud: 'http://localhost:3000/login',
    domain: 'localhost:3000',
    chainId: 'eip155:1',
    statement: 'Sign in with your wallet!',
  ),
  pairingTopic: resp.pairingTopic,
);

// Await the auth response using the provided completer
final AuthResponse authResponse = await authResponse.completer.future;
if (authResponse.result != null) {
  // Having a result means you have the signature and it is verified.

  // Retrieve the wallet address from a successful response
  final walletAddress = AddressUtils.getDidAddress(authResponse.result!.p.iss);
}
else {
  // Otherwise, you might have gotten a WalletConnectError if there was un issue verifying the signature.
  final WalletConnectError? error = authResponse.error;
  // Of a JsonRpcError if something went wrong when signing with the wallet.
  final JsonRpcError? error = authResponse.jsonRpcError;
}


// You can also respond to events from the wallet, like session events
wcClient.registerEventHandler(
  chainId: 'eip155:1',
  event: 'accountsChanged',
);
wcClient.onSessionEvent.subscribe((SessionEvent? session) {
  // Do something with the event
});
