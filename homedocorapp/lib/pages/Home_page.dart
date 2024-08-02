// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:homedocorapp/Services/contact_service.dart';
// import 'package:homedocorapp/components/app_drawer.dart';
// import 'package:permission_handler/permission_handler.dart';


// class Homepage extends StatelessWidget {
//   Homepage({super.key});
//   final user = FirebaseAuth.instance.currentUser!;
//   final ContactService contactService = ContactService();

//   void signUserOut() {
//     FirebaseAuth.instance.signOut();
//   }

//   Future<void> _openContacts() async {
//     final status = await Permission.contacts.status;
//     if (status.isGranted) {
//       await contactService.getContacts();
//     } else {
//       print('Contacts permission not granted');
//       final permissionStatus = await Permission.contacts.request();
//       if (permissionStatus.isGranted) {
//         await contactService.getContacts();
//       } else {
//         print('Contacts permission denied');
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Home Decor Shop'),
//         leading: Builder(
//           builder: (BuildContext context) {
//             return IconButton(
//               icon: Icon(Icons.menu),
//               onPressed: () {
//                 Scaffold.of(context).openDrawer();
//               },
//             );
//           },
//         ),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.logout),
//             onPressed: () {
//               signUserOut();
//             },
//           ),
//         ],
//       ),
//       drawer: AppDrawer(), // Use the existing AppDrawer here
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               "Welcome, " + user.email!,
//               style: TextStyle(fontSize: 24),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 // Navigate to shopping or other functionality
//               },
//               child: Text('Start Shopping'),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _openContacts,
//               child: Text('Open Contacts'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:homedocorapp/components/app_drawer.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:contacts_service/contacts_service.dart';

class Homepage extends StatefulWidget {
  Homepage({super.key});
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final user = FirebaseAuth.instance.currentUser!;
  List<Contact> contacts = [];

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  Future<void> _openContacts() async {
    final status = await Permission.contacts.status;
    if (status.isGranted) {
      await _fetchContacts();
    } else {
      final permissionStatus = await Permission.contacts.request();
      if (permissionStatus.isGranted) {
        await _fetchContacts();
      } else {
        print('Contacts permission denied');
      }
    }
  }

  Future<void> _fetchContacts() async {
    final fetchedContacts = await ContactsService.getContacts();
    setState(() {
      contacts = fetchedContacts.toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Decor Shop'),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              signUserOut();
            },
          ),
        ],
      ),
      drawer: AppDrawer(), // Use the existing AppDrawer here
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Welcome, " + user.email!,
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to shopping or other functionality
              },
              child: Text('Start Shopping'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _openContacts,
              child: Text('Open Contacts'),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: contacts.length,
                itemBuilder: (context, index) {
                  final contact = contacts[index];
                  return ListTile(
                    title: Text(contact.displayName ?? 'No name'),
                    subtitle: Text(contact.phones!.isNotEmpty ? contact.phones!.first.value! : 'No phone number'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
