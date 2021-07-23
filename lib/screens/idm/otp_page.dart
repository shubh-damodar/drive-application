import 'package:file/bloc_patterns/idm_bloc_patterns/otp_login_bloc.dart';
import 'package:file/models/user.dart';
import 'package:file/utils/navigation_actions.dart';
import 'package:file/utils/shared_pref_manager.dart';
import 'package:file/utils/widgets_collection.dart';
import 'package:flutter/material.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';
import 'package:sms_autofill/sms_autofill.dart';

class OtpVerification extends StatefulWidget {
  String userName, password;
  final String previousScreen;
  OtpVerification({this.previousScreen, this.password, this.userName});
  @override
  _OtpVerificationState createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {
  String _code;
  String signature = "{{ app signature }}";
  final OtpLoginBloc _otpLoginBloc = OtpLoginBloc();
  NavigationActions _navigationActions;
  WidgetsCollection _widgetsCollection;

  @override
  void initState() {
    super.initState();
    _code = '808080';
    _navigationActions = NavigationActions(context);
    _widgetsCollection = WidgetsCollection(context);
  }

  @override
  void dispose() {
    SmsAutoFill().unregisterListener();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Otp Verification'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // PhoneFieldHint(autofocus: true),
            Spacer(),
            Center(child: Text("Otp Verify")),
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: PinFieldAutoFill(
                decoration: UnderlineDecoration(
                    textStyle: TextStyle(fontSize: 20, color: Colors.black)),
                currentCode: _code,
              ),
            ),
            Spacer(),
            Spacer(),
            // RaisedButton(
            //   child: Text('Listen for sms code'),
            //   onPressed: () async {
            //     await SmsAutoFill().listenForCode;
            //   },
            // ),
            // RaisedButton(
            //   child: Text('Set code to 123456'),
            //   onPressed: () async {
            //     setState(() {
            //       _code = '808080';
            //     });
            //   },
            // ),
            // SizedBox(height: 8.0),
            // Divider(height: 1.0),
            // SizedBox(height: 4.0),
            // Text("App Signature : $signature"),
            // SizedBox(height: 4.0),
            // RaisedButton(
            //   child: Text('Get app signature'),
            //   onPressed: () async {
            //     signature = await SmsAutoFill().getAppSignature;
            //     setState(() {});
            //   },
            // ),
            ButtonTheme(
              height: 40.0,
              minWidth: 350.0,
              child: RaisedButton(
                  color: Colors.deepOrange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Text(
                    'Login With Otp',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  onPressed: () {
                    _otpLoginBloc.loginWithOtp(
                        widget.userName, widget.password, _code);
                  }),
            ),
            StreamBuilder(
                stream: _otpLoginBloc.otpLoginStream,
                builder: (BuildContext context, AsyncSnapshot asyncSnapshot) {
                  return asyncSnapshot.data == null
                      ? Container(
                          width: 0.0,
                          height: 0.0,
                        )
                      : _loginFinished(asyncSnapshot.data);
                }),
          ],
        ),
      ),
    );
  }

  Widget _loginFinished(Map<String, dynamic> mapResponse) {
    Future.delayed(Duration.zero, () {
      // _navigationActions.closeDialog();
      _otpLoginBloc.otpLoginStreamSink.add(null);

      if (mapResponse == null) {
        _widgetsCollection.showToastMessage("Error");
      } else {
        Map<String, dynamic> userMap = mapResponse;
        if (SharedPrefManager.usersList.length > 0 &&
            widget.previousScreen == 'file_page') {
          bool _isAlreadyLoggedIn = false;

          for (User user in SharedPrefManager.usersList) {
            if (user.userId == userMap['_id']) {
              _widgetsCollection.showToastMessage('User already logged In');
              _isAlreadyLoggedIn = true;
            }
          }

          if (!_isAlreadyLoggedIn) {
            SharedPrefManager.setCurrentUser(
              User(
                userId: userMap['basic']['_id'].toString(),
                email: userMap['basic']['email'].toString(),
                mobile: userMap['basic']['mobile'].toString(),
                name: userMap['basic']['name'].toString(),
                username: userMap['basic']['username'].toString(),
                token: userMap['token'].toString(),
              ),
            ).then((value) {
              _navigationActions.navigateToScreenNameRoot('file_page');
            });
          }
        } else {
          SharedPrefManager.setCurrentUser(
            User(
              userId: userMap['basic']['_id'].toString(),
              email: userMap['basic']['email'].toString(),
              mobile: userMap['basic']['mobile'].toString(),
              name: userMap['basic']['name'].toString(),
              username: userMap['basic']['username'].toString(),
              token: userMap['token'].toString(),
            ),
          ).then((value) {
            _navigationActions.navigateToScreenNameRoot('file_page');
          });
        }
      }
    });
    return Container(
      width: 0.0,
      height: 0.0,
    );
  }
}
