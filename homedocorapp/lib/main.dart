// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:homedocorapp/Services/connectivity_service.dart';
// import 'package:homedocorapp/Services/contact_service.dart';
// import 'package:homedocorapp/pages/calaculator_page_es.dart';
// import 'package:homedocorapp/pages/home_page.dart';
// import 'package:homedocorapp/pages/home_page_es.dart'; 
// import 'package:homedocorapp/pages/auth_page.dart';
// import 'package:homedocorapp/pages/calculator.dart';
// import 'package:homedocorapp/pages/login_page.dart';
// import 'package:homedocorapp/pages/login_page_es.dart'; 
// import 'package:homedocorapp/pages/profile.dart';
// import 'package:homedocorapp/pages/profile_page_es.dart';
// import 'package:homedocorapp/pages/settings_page.dart';
// import 'package:homedocorapp/pages/signup_page.dart';
// import 'package:homedocorapp/pages/signup_page_es.dart';
// import 'package:homedocorapp/pages/welcome_page.dart';
// import 'package:homedocorapp/pages/welcome_page_es.dart'; 
// import 'firebase_options.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:flutter/services.dart';

// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//     FlutterLocalNotificationsPlugin();

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//   final ContactService contactService = ContactService();
//   await contactService.getContacts();

//   // Initialize local notifications
//   const AndroidInitializationSettings initializationSettingsAndroid =
//       AndroidInitializationSettings('@mipmap/ic_launcher');
//   const InitializationSettings initializationSettings =
//       InitializationSettings(android: initializationSettingsAndroid);
//   await flutterLocalNotificationsPlugin.initialize(initializationSettings);

//   ConnectivityService(flutterLocalNotificationsPlugin);
//   startBatteryMonitor();

//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Auth App',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       initialRoute: '/welcome',
//       routes: {
//         // English pages
//         '/welcome': (context) => WelcomePage(),
//         '/login': (context) => LoginPage(),
//         '/signup': (context) => SignupPage(),
//         '/calculator': (context) => CalculatorPage(),
//         '/home': (context) => Homepage(),
//         '/profile': (context) => ProfilePage(),
         

//         // Spanish pages
//         '/welcome_es': (context) => WelcomePageEs(),
//         '/login_es': (context) => LoginPageEs(),
//         '/signup_es': (context) => SignupPageEs(),
//         '/calculator_es': (context) => CalculatorPageEs(),
//         '/home_es': (context) => HomepageEs(),
//         '/profile_es': (context) => ProfilePageEs(),
//       },
//     );
//   }
// }

// const platform = MethodChannel('battery_channel');

// Future<void> startBatteryMonitor() async {
//   try {
//     await platform.invokeMethod('startBatteryMonitor');
//   } on PlatformException catch (e) {
//     print("Failed to start battery monitor: '${e.message}'.");
//   }
// }

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart'; // Import provider
import 'package:homedocorapp/Services/connectivity_service.dart';
import 'package:homedocorapp/Services/contact_service.dart';
import 'package:homedocorapp/pages/calaculator_page_es.dart';
import 'package:homedocorapp/pages/home_page.dart';
import 'package:homedocorapp/pages/home_page_es.dart'; 
import 'package:homedocorapp/pages/auth_page.dart';
import 'package:homedocorapp/pages/calculator.dart';
import 'package:homedocorapp/pages/login_page.dart';
import 'package:homedocorapp/pages/login_page_es.dart'; 
import 'package:homedocorapp/pages/profile.dart';
import 'package:homedocorapp/pages/profile_page_es.dart';
import 'package:homedocorapp/pages/settings_page.dart';
import 'package:homedocorapp/pages/signup_page.dart';
import 'package:homedocorapp/pages/signup_page_es.dart';
import 'package:homedocorapp/pages/welcome_page.dart';
import 'package:homedocorapp/pages/welcome_page_es.dart'; 
import 'firebase_options.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/services.dart';

import 'pages/theme.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final ContactService contactService = ContactService();
  await contactService.getContacts();

  // Initialize local notifications
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  const InitializationSettings initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  ConnectivityService(flutterLocalNotificationsPlugin);
  startBatteryMonitor();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'Auth App',
            theme: themeProvider.isDarkMode
                ? ThemeData.dark()
                : ThemeData.light(),
            initialRoute: '/welcome',
            routes: {
              // English pages
              '/welcome': (context) => WelcomePage(),
              '/login': (context) => LoginPage(),
              '/signup': (context) => SignupPage(),
              '/calculator': (context) => CalculatorPage(),
              '/home': (context) => Homepage(),
              '/profile': (context) => ProfilePage(),
             

              // Spanish pages
              '/welcome_es': (context) => WelcomePageEs(),
              '/login_es': (context) => LoginPageEs(),
              '/signup_es': (context) => SignupPageEs(),
              '/calculator_es': (context) => CalculatorPageEs(),
              '/home_es': (context) => HomepageEs(),
              '/profile_es': (context) => ProfilePageEs(),
            },
          );
        },
      ),
    );
  }
}

const platform = MethodChannel('battery_channel');

Future<void> startBatteryMonitor() async {
  try {
    await platform.invokeMethod('startBatteryMonitor');
  } on PlatformException catch (e) {
    print("Failed to start battery monitor: '${e.message}'.");
  }
}
