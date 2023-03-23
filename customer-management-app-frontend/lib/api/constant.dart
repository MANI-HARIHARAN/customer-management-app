import 'dart:convert';
import 'package:http/http.dart' as http;

// class ApiConstants {
//   static String baseUrl = 'http://127.0.0.1:8000/api';
//   static String usersEndpoint = '/customer';
// }
class Student {
  String baseUrl = "http://127.0.0.1:8000/api/customer";
  Future<List> getAllStudent() async {
    try {
      var response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
        //return Future.error("ok");
      } else {
        return Future.error("Server Error");
      }
    } catch (e) {
      return Future.error(e);
    }
  }
}

class CallApi {
  final String _url = 'http://127.0.0.1:8000/api/customer/add';

  postData(data, apiUrl) async {
    return await http.post(Uri.parse(_url),
        body: jsonEncode(data), headers: _setHeaders());
  }

  //getData(apiUrl) async {
  //  var fullUrl = _url + apiUrl + await _getToken();
  //  return await http.get(fullUrl, headers: _setHeaders());
  //}

  _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };
}
