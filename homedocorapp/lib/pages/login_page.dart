 import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class MyLoginPage extends StatelessWidget {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  void _handleGoogleSignIn() async {
    try {
      final user = await _googleSignIn.signIn();
      // Handle signed-in user
    } catch (error) {
      print('Error signing in with Google: $error');
      // Handle sign-in errors
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Sign-In Example'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _handleGoogleSignIn,
          child: Text('Sign in with Google'),
        ),
      ),
    );
  }
}
