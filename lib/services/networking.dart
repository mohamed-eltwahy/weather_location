import 'package:http/http.dart' as http;
import 'dart:convert';
class NetworkHelper
{
  final String url;
  NetworkHelper(this.url);

  Future getData() async
  {
     var response = await http.get(url);
    if (response.statusCode == 200) {
      var data = response.body;
      var decodedData = jsonDecode(data);
      return decodedData;
      } else {
      print(response.statusCode);
    }
  }

}