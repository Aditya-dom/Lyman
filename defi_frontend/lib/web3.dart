import 'eth_rpc_api.dart';
   import 'dart:async';

   class Web3 {
     final EthRpcApi _rpcApi;

     Web3(this._rpcApi);

     Future<AccountsMap> ethGetAccounts() async {
       final Response response = await _rpcApi.sendTransaction('', '', 0, 
0, 0);
       return AccountsMap.fromJson(response.data['result']);
     }

     // Implement other Web3 methods as needed
   }

   class AccountsMap {
     final Map _accounts;

     AccountsMap.fromJson(this._accounts) : _accounts = 
jsonDecode(_accounts)['Result'] as Map;
   }