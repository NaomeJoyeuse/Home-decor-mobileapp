import 'dart:io';
import 'package:flutter/material.dart';
import 'package:homedocorapp/localization.dart';
import 'package:homedocorapp/pages/calaculator_page_es.dart';
import 'package:homedocorapp/pages/home_page_es.dart';
import 'package:homedocorapp/pages/login_page_es.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:homedocorapp/pages/settings_page.dart';
import 'package:homedocorapp/pages/auth_page.dart';

class ProfilePageEs extends StatefulWidget {
  @override
  _ProfilePageEsState createState() => _ProfilePageEsState();
}

class _ProfilePageEsState extends State<ProfilePageEs> {
  File? _profileImage;
  final ImagePicker _picker = ImagePicker();
  int _selectedIndex = 0;

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    setState(() {
      if (pickedFile != null) {
        _profileImage = File(pickedFile.path);
      }
    });
  }

  Future<void> _requestPermission(Permission permission) async {
    final status = await permission.request();
    if (!status.isGranted) {
      print('${permission.toString()} permiso denegado');
    }
  }

  @override
  void initState() {
    super.initState();
    _requestPermission(Permission.camera);
    _requestPermission(Permission.photos);
  }

  void _showImagePickerDialog(BuildContext context) {
    var localization = AppLocalizations.of(context);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(localization?.translate('choose_profile_picture') ?? 'Elegir foto de perfil'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text(localization?.translate('select_from_gallery') ?? 'Seleccionar desde la galería'),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: Icon(Icons.camera),
                title: Text(localization?.translate('take_a_picture') ?? 'Tomar una foto'),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage(ImageSource.camera);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _onItemTapped(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? loggedUser = prefs.getInt('userId') ?? 0;
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/home_es');
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomepageEs()),
        );
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => CalculatorPageEs()),
        );
        break;
      case 3:
        // Perform logout
       
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginPageEs()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    var localization = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(localization?.translate('profile') ?? 'Perfil'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            _profileImage != null
                ? CircleAvatar(
                    radius: 80,
                    backgroundImage: FileImage(_profileImage!),
                  )
                : CircleAvatar(
                    radius: 80,
                    backgroundImage: AssetImage('assets/images/profile_placeholder.png'),
                  ),
            SizedBox(height: 10.0),
            TextButton(
              onPressed: () => _showImagePickerDialog(context),
              child: Text(localization?.translate('pick_image') ?? 'Elegir imagen'),
              style: TextButton.styleFrom(
                foregroundColor: Colors.green,
                backgroundColor: Colors.grey[200],
                side: BorderSide(color: Colors.green),
              ),
            ),
            if (_profileImage != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Image.file(
                  _profileImage!,
                  height: 200,
                ),
              ),
            SizedBox(height: 16),
            Text(
              localization?.translate('user_details') ?? 'Detalles del usuario aquí',
              style: TextStyle(fontSize: 18),
            ),
            // Add more widgets to display user details
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calculate),
            label: 'Mis Libros',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.login),
            label: 'Configuración',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.logout),
            label: 'Cerrar Sesión',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
    );
  }
}
