// homepage_es.dart
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:homedocorapp/Services/contact_service.dart';
import 'package:homedocorapp/components/app_drawer.dart';
import 'package:homedocorapp/components/app_drawerEs.dart';
import 'package:permission_handler/permission_handler.dart';

class HomepageEs extends StatelessWidget {
  HomepageEs({super.key});
  final user = FirebaseAuth.instance.currentUser!;
  final ContactService contactService = ContactService();

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  Future<void> _openContacts() async {
    final status = await Permission.contacts.status;
    if (status.isGranted) {
      await contactService.getContacts();
    } else {
      print('Permiso de contactos no concedido');
      final permissionStatus = await Permission.contacts.request();
      if (permissionStatus.isGranted) {
        await contactService.getContacts();
      } else {
        print('Permiso de contactos denegado');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tienda de Decoración para el Hogar'),
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
      drawer: AppDrawerEs(), // Use the existing AppDrawer here
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Bienvenido, " + user.email!,
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navegar a compras u otra funcionalidad
              },
              child: Text('Comenzar a Comprar'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _openContacts,
              child: Text('Abrir Contactos'),
            ),
          ],
        ),
      ),
    );
  }
}
