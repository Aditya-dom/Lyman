import 'dio';

   class EthRpcApi {
     final Dio _http;
     final String _url;

     EthRpcApi(this._url) : _http = Dio(BaseOptions(baseUrl: _url));

     Future<dynamic> sendTransaction(String fromAddress, String toAddress,
int value, int gasPrice, int nonce) async {
       final Map body = {
         'jsonrpc': '2.0',
         'method': 'eth_sendTransaction',
         'params': [
           {
             'from': fromAddress,
             'to': toAddress,
             'value': value,
             'gasPrice': gasPrice,
             'nonce': nonce,
           }
         ],
         'id': 1
       };

       final Response response = await _http.post(''); // Replace with 
your Django backend's URL

       return response.data;
     }
   }
