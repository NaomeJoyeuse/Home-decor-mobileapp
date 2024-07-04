import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Naomi space',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
             
              Navigator.pop(context); 
              Navigator.pushNamed(context, '/welcome'); 
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Login'),
            onTap: () {
             Navigator.pushNamed(context, '/login');
              Navigator.pop(context); 
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Signup'),
            onTap: () {
              Navigator.pushNamed(context, '/signup');
              Navigator.pop(context); 
            },
          ),
           ListTile(
            leading: Icon(Icons.calculate),
            title: const Text('Calculator'),
            onTap: () {
              Navigator.pop(context); // Close drawer first
              Navigator.pushNamed(context, '/calculator'); // Navigate to '/calculator'
            },
          ),
         
        ],
      ),
    );
  }
}
