import 'package:flutter/material.dart';

class WalletConnectUI extends StatefulWidget {
  const WalletConnectUI({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _WalletConnectUIState createState() => _WalletConnectUIState();
}

class _WalletConnectUIState extends State<WalletConnectUI> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String _walletAddress; // Address of the Wallet Connect wallet
  late String _password; // Password for the Wallet Connect wallet

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wallet Connect'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Wallet Address',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a wallet address';
                }
                return null;
              },
              onSaved: (value) => _walletAddress = value!,
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value!.isEmpty || value.length < 12) {
                  return 'Please enter a password';
                }
                return null;
              },
              onSaved: (value) => _password = value!,
            ),
            ElevatedButton(
              onPressed: () async {
                final formKey = _formKey;
                if (formKey.currentState!.validate()) {
                  await WalletConnectProvider().getAccounts();
                  // Call the deploy function here
                }
              },
              child: const Text('Deploy Contract'),
            ),
          ],
        ),
      ),
    );
  }
}
