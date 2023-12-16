import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app_task/data/services/base_api_services.dart';

class NetworkApiServices extends BaseApiServices {
  @override
  Future<dynamic> getApi(String url) async {
    try {
      dynamic decodedJson;
      http.Response apiResponse = await http.get(Uri.parse(url));
      if (apiResponse.statusCode == 200) {
        decodedJson = jsonDecode(apiResponse.body.toString());
        return decodedJson;
      }
    } catch (e) {
      print(e);
    }
    // on SocketException catch (e) {
    //   print(e);
    // } on TimeoutException catch (e) {
    //   print(e);
    // } on Error catch (e) {
    //   print(e);
    // }
  }
}
