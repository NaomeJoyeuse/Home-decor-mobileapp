import 'package:flutter/material.dart';

class AppDrawerEs extends StatelessWidget {
  const AppDrawerEs({Key? key}) : super(key: key);

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
              'Espacio de Vendass',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Inicio'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/welcome_es');
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Iniciar sesión'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/login_es');
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Registrarse'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/signup_es');
            },
          ),
          ListTile(
            leading: Icon(Icons.calculate),
            title: Text('Calculadora'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/calculator_es');
            },
          ),
          ListTile(
            leading: Icon(Icons.person_2_rounded),
            title: Text('Mi perfil'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/profile_es');
            },
          ),
          // Language change button
          ListTile(
            leading: Icon(Icons.language),
            title: Text('Cambiar idioma'),
            onTap: () {
              _showLanguageDialog(context);
            },
          ),
        ],
      ),
    );
  }

  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Seleccionar idioma'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('Inglés'),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.pushReplacementNamed(context, '/welcome');
                },
              ),
              ListTile(
                title: Text('Español'),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.pushReplacementNamed(context, '/welcome_es');
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
