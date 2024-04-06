Web3Wallet wcClient = await Web3Wallet.createInstance(
  relayUrl: 'wss://relay.walletconnect.com', // The relay websocket URL, leave blank to use the default
  projectId: '123',
  metadata: PairingMetadata(
    name: 'Wallet (Responder)',
    description: 'A wallet that can be requested to sign transactions',
    url: 'https://walletconnect.com',
    icons: ['https://avatars.githubusercontent.com/u/37784886'],
  ),
);

// For a wallet, setup the proposal handler that will display the proposal to the user after the URI has been scanned.
late int id;
wcClient.onSessionProposal.subscribe((SessionProposal? args) async {
  // Handle UI updates using the args.params
  // Keep track of the args.id for the approval response
  if (args != null) {
    id = args!.id;
    // To check VerifyAPI validation in regards of the dApp is trying to connnect you can check verifyContext
    // More info about VerifyAPI https://docs.walletconnect.com/web3wallet/verify
    final isScamApp = args.verifyContext?.validation.scam;
    final isInvalidApp = args.verifyContext?.validation.invalid;
    final isValidApp = args.verifyContext?.validation.valid;
    final unknown = args.verifyContext?.validation.unknown;
  }
});

// Also setup the methods and chains that your wallet supports
final signRequestHandler = (String topic, dynamic parameters) async {
  // Handling Steps
  // 1. Parse the request, if there are any errors thrown while trying to parse
  // the client will automatically respond to the requester with a 
  // JsonRpcError.invalidParams error
  final parsedResponse = parameters;

  // 1. If you want to fail silently, you can throw a WalletConnectErrorSilent
  if (failSilently) {
    throw WalletConnectErrorSilent();
  }

  // 2. Show a modal to the user with the signature info: Allow approval/rejection
  bool userApproved = await showDialog( // This is an example, you will have to make your own changes to make it work.
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Sign Transaction'),
        content: SizedBox(
          width: 300,
          height: 350,
          child: Text(parsedResponse.toString()),
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text('Accept'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text('Reject'),
          ),
        ],
      );
    },
  );

  // 3. Respond to the dApp based on user response
  if (userApproved) {
    // Returned value must be a primitive, or a JSON serializable object: Map, List, etc.
    return 'Signed!';
  }
  else {
    // Throw an error if the user rejects the request
    throw Errors.getSdkError(Errors.USER_REJECTED_SIGN);
  }
}
wcClient.registerRequestHandler(
  chainId: 'eip155:1',
  method: 'eth_sendTransaction',
  handler: signRequestHandler,
);

// If you want to the library to handle Namespace validation automatically, 
// you can register your events and accounts like so:
wcClient.registerEventEmitter(
  chainId: 'eip155:1',
  event: 'chainChanged',
);
wcClient.registerAccount(
  chainId: 'eip155:1',
  account: '0xabc',
);

// If your wallet receives a session proposal that it can't make the proper Namespaces for,
// it will broadcast an onSessionProposalError
wcClient.onSessionProposalError.subscribe((SessionProposalError? args) {
  // Handle the error
});

// Setup the auth handling
clientB.onAuthRequest.subscribe((AuthRequest? args) async {

  // This is where you would 
  // 1. Store the information to be signed
  // 2. Display to the user that an auth request has been received

  // You can create the message to be signed in this manner
  String message = clientB.formatAuthMessage(
    iss: TEST_ISSUER_EIP191,
    cacaoPayload: CacaoRequestPayload.fromPayloadParams(
      args!.payloadParams,
    ),
  );
});

// Then, scan the QR code and parse the URI, and pair with the dApp
// On the first pairing, you will immediately receive onSessionProposal and onAuthRequest events.
Uri uri = Uri.parse(scannedUriString);
final PairingInfo pairing = await wcClient.pair(uri: uri);

// Present the UI to the user, and allow them to reject or approve the proposal
final walletNamespaces = {
  'eip155': Namespace(
    accounts: ['eip155:1:abc'],
    methods: ['eth_signTransaction'],
    events: ['accountsChanged'],
  ),
}
await wcClient.approveSession(
  id: id,
  namespaces: walletNamespaces // This will have the accounts requested in params
                               // If you registered correctly events emitters, methods handlers and accounts for your supported chains you can just us `args.params.generatedNamespaces!` value from SessionProposalEvent
);
// Or to reject...
// Error codes and reasons can be found here: https://docs.walletconnect.com/2.0/specs/clients/sign/error-codes
await wcClient.rejectSession(
  id: id,
  reason: Errors.getSdkError(Errors.USER_REJECTED),
);

// For auth, you can do the same thing: Present the UI to them, and have them approve the signature.
// Then respond with that signature. In this example I use EthSigUtil, but you can use any library that can perform
// a personal eth sign.
String sig = EthSigUtil.signPersonalMessage(
  message: Uint8List.fromList(message.codeUnits),
  privateKey: 'PRIVATE_KEY',
);
await wcClient.respondAuthRequest(
  id: args.id,
  iss: 'did:pkh:eip155:1:ETH_ADDRESS',
  signature: CacaoSignature(t: CacaoSignature.EIP191, s: sig),
);
// Or rejected
// Error codes and reasons can be found here: https://docs.walletconnect.com/2.0/specs/clients/sign/error-codes
await wcClient.respondAuthRequest(
  id: args.id,
  iss: 'did:pkh:eip155:1:ETH_ADDRESS',
  error: Errors.getSdkError(Errors.USER_REJECTED_AUTH),
);

// You can also emit events for the dApp
await wcClient.emitSessionEvent(
  topic: sessionTopic,
  chainId: 'eip155:1',
  event: SessionEventParams(
    name: 'chainChanged',
    data: 'a message!',
  ),
);

// Finally, you can disconnect
await wcClient.disconnectSession(
  topic: pairing.topic,
  reason: Errors.getSdkError(Errors.USER_DISCONNECTED),
);