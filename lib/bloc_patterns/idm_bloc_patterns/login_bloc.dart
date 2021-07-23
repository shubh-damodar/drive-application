import 'dart:async';
import 'package:file/network/user_connect.dart';
import 'package:file/utils/password_crypto.dart';
import 'package:file/validators/login_validators.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc {
  final StreamController<Map<String, dynamic>> _loginStreamController =
      StreamController<Map<String, dynamic>>();

  StreamSink<Map<String, dynamic>> get loginStreamSink =>
      _loginStreamController.sink;

  Stream<Map<String, dynamic>> get loginStream => _loginStreamController.stream;

  void checkLogin(String username, String password) async {
    print(username);
    Map<String, String> mapBody = Map<String, String>();
    mapBody['username'] = username;
    mapBody['password'] = await PasswordCrypto().generateMd5(password);
    // mapBody['password'] = password;
    Connect _connect = Connect();
    _connect.sendPost(mapBody, Connect.userLogin).then((mapResponse) {
      loginStreamSink.add(mapResponse);
    });
  }

  void dispose() {
    _loginStreamController.close();
  }
}
