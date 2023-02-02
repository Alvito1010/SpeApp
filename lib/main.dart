import 'package:flutter/material.dart';
import 'package:spe_project_app/screens/address_screen.dart';
import 'package:spe_project_app/screens/mainscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spe_project_app/screens/splash_screen.dart';

const buttoncolor1 = Color.fromARGB(249, 16, 212, 19);
const buttoncolor2 = Color.fromARGB(248, 239, 26, 26);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( MyApp());
}


class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _checkLoginStatus(),
      builder: (ctx, snapshot) {
        if (snapshot.data == true){
          return SplashtestWidget;
        } else if (snapshot.data == false){
          return testWidget;
        } else {
          return CircularProgressIndicator();
        }
        
      },
    );
  }
  Future<bool> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }
}
