import 'dart:async';
import 'package:file/network/user_connect.dart';
import 'package:file/utils/password_crypto.dart';
import 'package:file/validators/login_validators.dart';
import 'package:rxdart/rxdart.dart';

class OtpLoginBloc {
  final StreamController<Map<String, dynamic>> _otpLoginStreamController =
      StreamController<Map<String, dynamic>>();

  StreamSink<Map<String, dynamic>> get otpLoginStreamSink =>
      _otpLoginStreamController.sink;

  Stream<Map<String, dynamic>> get otpLoginStream =>
      _otpLoginStreamController.stream;

  void loginWithOtp(String userName, String password, String otp) async {
    print(otp);
    Map<String, String> mapBody = Map<String, String>();
    mapBody['username'] = userName;
    // mapBody['password']=await PasswordCrypto().generateMd5(password);
    mapBody['password'] = password;
    mapBody['smsOTP'] = otp;
    mapBody['emailOTP'] = otp;

    Connect _connect = Connect();
    _connect
        .sendPost(mapBody, Connect.userLogin)
        .then((Map<String, dynamic> mapResponse) {
      print(mapResponse);
      otpLoginStreamSink.add(mapResponse);
    });
  }

  void dispose() {
    _otpLoginStreamController.close();
  }
}
