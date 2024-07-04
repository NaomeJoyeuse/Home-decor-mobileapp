import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:homedocorapp/pages/Home_page.dart';
import 'package:homedocorapp/pages/auth_page.dart';
import 'package:homedocorapp/pages/calculator.dart';
import 'package:homedocorapp/pages/login_page.dart';
import 'package:homedocorapp/pages/main_screen.dart';
import 'package:homedocorapp/pages/signup_Page.dart';
import 'package:homedocorapp/pages/welcome_page.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Auth App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // ignore: prefer_const_constructors
      home: AuthPage(),
      routes: {
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignupPage(),
        '/welcome': (context) => WelcomePage(),
         '/calculator': (context) => CalculatorPage(),
          '/home': (context) => Homepage(), 
      },
    );
  }
}


  


