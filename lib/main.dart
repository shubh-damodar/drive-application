import 'package:file/screens/file/file_page.dart';
import 'package:file/screens/idm/otp_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:file/screens/idm/forgot_password_page.dart';
import 'package:file/screens/home_page.dart';
import 'package:file/screens/idm/login_page.dart';
import 'package:file/screens/profile_screens/edit_profile_screens/profile_page.dart';
import 'package:file/screens/idm/register_page.dart';
import 'package:file/utils/network_connectivity.dart';
import 'package:file/utils/shared_pref_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/user.dart';
import 'network/user_connect.dart';
import 'package:flutter_stetho/flutter_stetho.dart';

void main() {
  Stetho.initialize();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SharedPrefManager.getSharedPref().then((SharedPreferences sharedPreferences) {
    SharedPrefManager.getCurrentUser().then((User user) {
      SharedPrefManager.getAllUsers();
      if (user != null) {
        Connect.currentUser = user;
      }
      runApp(MyApp());
    });
  });
}

class MyApp extends StatelessWidget {
//  static GlobalKey<NavigatorState> navigatorStateGlobalKey=GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return NetworkConnectivity(
        widget: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Mesbro Articles',
            theme: ThemeData(
                accentColor: Colors.red,
                primarySwatch: Colors.red,
                fontFamily: 'Poppins'),
            home: Connect.currentUser == null
                ? LoginPage(previousScreen: '')
                : FilePage(),
            routes: <String, WidgetBuilder>{
          '/login_page': (BuildContext context) =>
              LoginPage(previousScreen: ''),
          '/register_page': (BuildContext context) => RegisterPage(),
          '/home_page': (BuildContext context) => HomePage(),
          '/forgot_password_page': (BuildContext context) =>
              ForgotPasswordPage(),
          '/profile_page': (BuildContext context) => ProfilePage(),
          '/file_page': (BuildContext context) => FilePage(),
          '/home_page': (BuildContext context) => HomePage(),
          '/otp_page': (BuildContext context) => OtpVerification(),
        }));
  }
}
