// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// // Provider for theme management
// class ThemeProvider with ChangeNotifier {
//   bool _isDarkMode = false;

//   bool get isDarkMode => _isDarkMode;

//   void toggleTheme() {
//     _isDarkMode = !_isDarkMode;
//     notifyListeners();
//   }
// }

// class SettingsPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Row(
//           children: [
//             IconButton(
//               icon: Icon(Icons.arrow_back),
//               onPressed: () {
//                 Navigator.pop(context); // Navigate back to previous screen
//               },
//             ),
//             Expanded(
//               child: Center(
//                 child: Text('Settings'),
//               ),
//             ),
//           ],
//         ),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: ListView(
//           children: [
//             // Theme Preference Section
//             ListTile(
//               title: Text('Theme Preference'),
//               trailing: Consumer<ThemeProvider>(
//                 builder: (context, themeProvider, child) {
//                   return Switch(
//                     value: themeProvider.isDarkMode,
//                     onChanged: (value) {
//                       themeProvider.toggleTheme();
//                     },
//                   );
//                 },
//               ),
//             ),
//             Divider(),
//             // Profile Section
//             ListTile(
//               title: Text('Profile'),
//               onTap: () {
//                 // Navigate to profile settings page
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => ProfileSettingsPage()),
//                 );
//               },
//             ),
//             Divider(),
//             // Other Settings
//             ListTile(
//               title: Text('Other Settings'),
//               onTap: () {
//                 // Navigate to other settings page
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class ProfileSettingsPage extends StatefulWidget {
//   @override
//   _ProfileSettingsPageState createState() => _ProfileSettingsPageState();
// }

// class _ProfileSettingsPageState extends State<ProfileSettingsPage> {
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   bool _isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     _loadUserProfile();
//   }

//   Future<void> _loadUserProfile() async {
//     final prefs = await SharedPreferences.getInstance();
//     String? userName = prefs.getString('userName');

//     if (userName != null) {
//       setState(() {
//         _nameController.text = userName;
//         _isLoading = false;
//       });
//     } else {
//       setState(() {
//         _isLoading = false; // No data, but stop loading
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Profile Settings'),
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.pop(context); // Navigate back to previous screen
//           },
//         ),
//       ),
//       body: _isLoading
//           ? Center(child: CircularProgressIndicator())
//           : Padding(
//               padding: EdgeInsets.all(16.0),
//               child: ListView(
//                 children: [
//                   // User Information
//                   Text(
//                     'Name: ${_nameController.text.isNotEmpty ? _nameController.text : 'Not available'}',
//                     style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
//                   ),
//                 ],
//               ),
//             ),
//     );
//   }
// }
