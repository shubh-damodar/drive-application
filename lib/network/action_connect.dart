import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:file/network/user_connect.dart';

import '../main.dart';

class ActionConnect {
  String _actionBaseUrl = 'https://mesbro.herokuapp.com/';

  static String fileList = 'api/business/file-manager/list',
      fevList = 'api/generic/favourite/my-list',
      a = '';

  Future<dynamic> sendActionPost(
      Map<String, dynamic> mapBody, String url) async {
    print(Connect.currentUser.token);
    http.Response response = await http
        .post('$_actionBaseUrl$url', body: json.encode(mapBody), headers: {
      'Authorization':
          Connect.currentUser == null ? '' : Connect.currentUser.token,
      "Content-Type": "application/json"
    });
    dynamic map = jsonDecode(response.body);
    return map;
  }

  Future<Map<String, dynamic>> sendActionPostWithHeaders(
      dynamic mapBody, String url) async {
    HttpClient httpClient = new HttpClient();
    HttpClientRequest request =
        await httpClient.postUrl(Uri.parse('$_actionBaseUrl$url'));
    request.headers.add("Authorization", Connect.currentUser.token);
    request.add(utf8.encode(json.encode(mapBody)));
    HttpClientResponse httpClientResponse = await request.close();
    String response = await httpClientResponse.transform(utf8.decoder).join();
    httpClient.close();
    Map<String, dynamic> map = jsonDecode(response);
    return map;
  }

  Future<Map<String, dynamic>> sendActionGet(String url) async {
    http.Response response = await http.get('$_actionBaseUrl$url');
    Map<String, dynamic> map = json.decode(response.body);
    return map;
  }

  Future<Map<String, dynamic>> sendActionGetWithHeaders(String url) async {
    HttpClient httpClient = new HttpClient();
    HttpClientRequest request =
        await httpClient.getUrl(Uri.parse('$_actionBaseUrl$url'));
    request.headers.add("Authorization", Connect.currentUser.token);
    HttpClientResponse httpClientResponse = await request.close();
    String response = await httpClientResponse.transform(utf8.decoder).join();
    httpClient.close();
    Map<String, dynamic> map = jsonDecode(response);
    return map;
  }
}
