// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:homedocorapp/localization.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:permission_handler/permission_handler.dart';


// class ProfilePage extends StatefulWidget {
//   @override
//   _ProfilePageState createState() => _ProfilePageState();
// }

// class _ProfilePageState extends State<ProfilePage> {
//   File? _profileImage;
//   final ImagePicker _picker = ImagePicker();

//   Future<void> _pickImage(ImageSource source) async {
//     final pickedFile = await _picker.pickImage(source: source);
//     setState(() {
//       if (pickedFile != null) {
//         _profileImage = File(pickedFile.path);
//       }
//     });
//   }

//   Future<void> _requestPermission(Permission permission) async {
//     final status = await permission.request();
//     if (!status.isGranted) {
//       print('${permission.toString()} permission denied');
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     _requestPermission(Permission.camera);
//     _requestPermission(Permission.photos);
//   }

//   void _showImagePickerDialog(BuildContext context) {
//     var localization = AppLocalizations.of(context);
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text(localization?.translate('choose_profile_picture') ?? 'Choose Profile Picture'),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: <Widget>[
//               ListTile(
//                 leading: Icon(Icons.photo_library),
//                 title: Text(localization?.translate('select_from_gallery') ?? 'Select from Gallery'),
//                 onTap: () {
//                   Navigator.of(context).pop();
//                   _pickImage(ImageSource.gallery);
//                 },
//               ),
//               ListTile(
//                 leading: Icon(Icons.camera),
//                 title: Text(localization?.translate('take_a_picture') ?? 'Take a Picture'),
//                 onTap: () {
//                   Navigator.of(context).pop();
//                   _pickImage(ImageSource.camera);
//                 },
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     var localization = AppLocalizations.of(context);
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(localization?.translate('profile') ?? 'Profile'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: <Widget>[
//             _profileImage != null
//                 ? CircleAvatar(
//                     radius: 80,
//                     backgroundImage: FileImage(_profileImage!),
//                   )
//                 : CircleAvatar(
//                     radius: 80,
//                     backgroundImage: AssetImage('assets/images/profile_placeholder.png'),
//                   ),
//             SizedBox(height: 10.0),
//             TextButton(
//               onPressed: () => _showImagePickerDialog(context),
//               child: Text(localization?.translate('pick_image') ?? 'Pick Image'),
//               style: TextButton.styleFrom(
//                 foregroundColor: Colors.green,
//                 backgroundColor: Colors.grey[200],
//                 side: BorderSide(color: Colors.green),
//               ),
//             ),
//             if (_profileImage != null)
//               Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 10.0),
//                 child: Image.file(
//                   _profileImage!,
//                   height: 200,
//                 ),
//               ),
//             SizedBox(height: 16),
//             Text(
//               localization?.translate('user_details') ?? 'User Details Here',
//               style: TextStyle(fontSize: 18),
//             ),
//             // Add more widgets to display user details
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:homedocorapp/localization.dart';
import 'package:homedocorapp/pages/Home_page.dart';
import 'package:homedocorapp/pages/calculator.dart';
import 'package:homedocorapp/pages/login_page_es.dart';
import 'package:homedocorapp/pages/signup_Page.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'settings_page.dart'; // Import your SettingsPage


class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
      print('${permission.toString()} permission denied');
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
          title: Text(localization?.translate('choose_profile_picture') ?? 'Choose Profile Picture'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text(localization?.translate('select_from_gallery') ?? 'Select from Gallery'),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: Icon(Icons.camera),
                title: Text(localization?.translate('take_a_picture') ?? 'Take a Picture'),
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
        Navigator.pushReplacementNamed(context, '/home');
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Homepage()),
        );
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => CalculatorPage()),
        );
        break;
      case 3:
       
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
        title: Text(localization?.translate('profile') ?? 'Profile'),
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
              child: Text(localization?.translate('pick_image') ?? 'Pick Image'),
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
              localization?.translate('user_details') ?? 'User Details Here',
              style: TextStyle(fontSize: 18),
            ),
            // Add more widgets to display user details
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                _onItemTapped(0);
              },
            ),
            IconButton(
              icon: Icon(Icons.calculate),
              onPressed: () {
                _onItemTapped(1);
              },
            ),
            IconButton(
              icon: Icon(Icons.login),
              onPressed: () {
                _onItemTapped(2);
              },
            ),
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                _onItemTapped(3);
              },
            ),
          ],
        ),
      ),
    );
  }
}

