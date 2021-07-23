import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:file/network/user_connect.dart';

import '../main.dart';

class ListConnect {
//  String _listBaseUrl = 'http://mail.simplifying.world/apis/v1.0.1/list/';

  String _listBaseUrl = 'https://mesbro.herokuapp.com/';

  static String fileList = 'api/business/file-manager/list',
      listContacts = 'list/contacts',
      listFavourite = 'list/favourite',
      listMailSearch = 'mail/search',
      a = '';

  Future<Map<String, dynamic>> sendMailPost(
      Map<String, dynamic> mapBody, String url) async {
    http.Response response = await http
        .post('$_listBaseUrl$url', body: json.encode(mapBody), headers: {
      'Authorization':
          Connect.currentUser == null ? '' : Connect.currentUser.token,
      "Content-Type": "application/json"
    });
    Map<String, dynamic> map = jsonDecode(response.body);
    return map;
  }

  Future<Map<String, dynamic>> sendMailPostWithHeaders(
      dynamic mapBody, String url) async {
    HttpClient httpClient = new HttpClient();
    HttpClientRequest request =
        await httpClient.postUrl(Uri.parse('$_listBaseUrl$url'));
    request.headers.add('Authorization', Connect.currentUser.token);
    request.add(utf8.encode(json.encode(mapBody)));
    HttpClientResponse httpClientResponse = await request.close();
    String response = await httpClientResponse.transform(utf8.decoder).join();
    httpClient.close();
    Map<String, dynamic> map = jsonDecode(response);
    return map;
  }

  Future<Map<String, dynamic>> sendMailGet(String url) async {
    http.Response response = await http.get('$_listBaseUrl$url');
    Map<String, dynamic> map = json.decode(response.body);
    return map;
  }

  Future<Map<String, dynamic>> sendMailGetWithHeaders(String url) async {
    HttpClient httpClient = new HttpClient();
    HttpClientRequest request =
        await httpClient.getUrl(Uri.parse('$_listBaseUrl$url'));
    request.headers.add('Authorization', Connect.currentUser.token);
    HttpClientResponse httpClientResponse = await request.close();
    String response = await httpClientResponse.transform(utf8.decoder).join();
    httpClient.close();
    Map<String, dynamic> map = jsonDecode(response);
    return map;
  }
}
