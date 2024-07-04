import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Homepage extends StatelessWidget {
  Homepage ({super.key});
  final user =FirebaseAuth.instance.currentUser!;

void signUserout(){
FirebaseAuth.instance.signOut();

}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Decor Shop'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              // Implement logout functionality here
              // For Firebase, it would be something like:
              FirebaseAuth.instance.signOut();
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Welcome" + user.email!,
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Implement navigation to shopping or other functionality
              },
              child: Text('Start Shopping'),
            ),
          ],
        ),
      ),
    );
  }
}
