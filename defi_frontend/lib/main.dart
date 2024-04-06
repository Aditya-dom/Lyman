import 'package:flutter/material.dart';
import 'web3.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Defi App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Defi Swap'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _tokenInController = TextEditingController();
  TextEditingController _desiredTokensOutController = TextEditingController();
  Web3 _web3 = Web3(EthRpcApi('')); // Replace with your Django backend's URL
  AccountsMap? _accounts;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _tokenInController,
              decoration: InputDecoration(hintText: 'Token In'),
            ),
            TextField(
              controller: _desiredTokensOutController,
              decoration: InputDecoration(hintText: 'Desired Tokens Out'),
            ),
            ElevatedButton(
              onPressed: () async {
                final accounts = await _web3.ethGetAccounts();
                setState(() {
                  _accounts = accounts;
                });
                final String fromAddress = accounts.values.first;
                final int tokenIn = int.parse(_tokenInController.text);
                final int desiredTokensOut = int.parse(_desiredTokensOutController.text);

                final String receipt = await _web3.swapTokens(fromAddress, tokenIn, desiredTokensOut);
                if (receipt != null) {
                  print('Swap successful: $receipt');
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Swap failed')));
                }
              },
              child: Text('Swap'),
            ),
          ],
        ),
      ),
    );
  }
}
