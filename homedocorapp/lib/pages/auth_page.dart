import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:homedocorapp/pages/home_page.dart';
import 'package:homedocorapp/pages/login_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // user is logged in
          if (snapshot.hasData && snapshot.data != null) {
            return Homepage();
          }
          // user is NOT logged in
          else {
            return LoginPage();
          }
        },
      ),
    );
  }
}
