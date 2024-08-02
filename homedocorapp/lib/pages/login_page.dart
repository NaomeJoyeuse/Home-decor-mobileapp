// import 'package:flutter/material.dart';
// import 'package:homedocorapp/components/my_textfield.dart';
// import 'package:homedocorapp/components/app_drawer.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:homedocorapp/services/authservice.dart';
// import 'package:homedocorapp/localization.dart'; // Import your localization file

// class LoginPage extends StatefulWidget {
//   LoginPage({Key? key}) : super(key: key);

//   @override
//   _LoginPageState createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();
//   bool isLoading = false;

//   // Instance of AuthService
//   final AuthService _authService = AuthService();

//   @override
//   Widget build(BuildContext context) {
//     final localization = AppLocalizations.of(context);

//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
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
//       ),
//       drawer: AppDrawer(),
//       body: SafeArea(
//         child: Center(
//           child: SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.all(20.0),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   SizedBox(height: 50),
//                   Icon(
//                     Icons.lock,
//                     size: 100,
//                   ),
//                   SizedBox(height: 50),
//                   Text(
//                     localization?.translate('login_welcome') ?? 'Welcome back you\'ve been missed!',
//                     style: TextStyle(
//                       color: Color.fromARGB(255, 196, 173, 173),
//                       fontSize: 16,
//                     ),
//                   ),
//                   SizedBox(height: 25),
//                   MyTextfield(
//                     controller: emailController,
//                     hintText: localization?.translate('email_hint') ?? 'Email',
//                     obscureText: false,
//                     prefixIcon: Icon(Icons.person),
//                   ),
//                   SizedBox(height: 10),
//                   MyTextfield(
//                     controller: passwordController,
//                     hintText: localization?.translate('password_hint') ?? 'Password',
//                     obscureText: true,
//                     prefixIcon: Icon(Icons.lock),
//                   ),
//                   SizedBox(height: 10),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 20),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         Text(
//                           localization?.translate('forgot_password') ?? 'Forgot password?',
//                           style: TextStyle(color: Colors.grey[600]),
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   ElevatedButton(
//                     onPressed: isLoading ? null : signIn,
//                     child: isLoading
//                         ? CircularProgressIndicator(
//                             color: Colors.white,
//                           )
//                         : Text(localization?.translate('sign_in') ?? 'Sign In'),
//                   ),
//                   SizedBox(height: 20),
//                   ElevatedButton(
//                     onPressed: isLoading ? null : signInWithGoogle,
//                     style: ButtonStyle(
//                       backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
//                     ),
//                     child: isLoading
//                         ? CircularProgressIndicator(
//                             color: Colors.white,
//                           )
//                         : Text(localization?.translate('sign_in_google') ?? 'Sign In with Google'),
//                   ),
//                   SizedBox(height: 20),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         localization?.translate('not_a_member') ?? 'Not a member?',
//                         style: TextStyle(color: Colors.grey[700]),
//                       ),
//                       SizedBox(width: 4),
//                       GestureDetector(
//                         onTap: () {
//                           Navigator.pushNamed(context, '/signup');
//                         },
//                         child: Text(
//                           localization?.translate('register_now') ?? 'Register now',
//                           style: TextStyle(
//                             color: Colors.blue,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 20),
//                   Image.asset(
//                     'lib/Assets/imgs/image1.png',
//                     fit: BoxFit.contain,
//                     width: 380,
//                     height: 300,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   // Sign in with Google
//   void signInWithGoogle() async {
//     setState(() {
//       isLoading = true;
//     });

//     final User? user = await _authService.signInWithGoogle();

//     if (user != null) {
//       print('User signed in with Google: ${user.displayName}');
//       // Navigate to another screen or handle successful sign-in
//       // Example: Navigator.pushReplacementNamed(context, '/home');
//     } else {
//       // Handle sign-in failure
//       print('Failed to sign in with Google.');
//     }

//     setState(() {
//       isLoading = false;
//     });
//   }

//   // Sign in with email and password
//   void signIn() async {
//     setState(() {
//       isLoading = true;
//     });

//     try {
//       await FirebaseAuth.instance.signInWithEmailAndPassword(
//         email: emailController.text,
//         password: passwordController.text,
//       );
//       Navigator.pop(context);
//     } on FirebaseAuthException catch (e) {
//       if (e.code == 'invalid-email') {
//         wrongEmailMessage();
//       } else if (e.code == 'wrong-password') {
//         wrongPasswordMessage();
//       }
//     } finally {
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }

//   // Dialogs for error messages
//   void wrongEmailMessage() {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text(AppLocalizations.of(context)?.translate('error_incorrect_email') ?? 'Incorrect Email'),
//           content: Text(AppLocalizations.of(context)?.translate('error_incorrect_email_message') ?? 'Please check your email and try again.'),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: Text(AppLocalizations.of(context)?.translate('ok') ?? 'OK'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void wrongPasswordMessage() {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text(AppLocalizations.of(context)?.translate('error_incorrect_password') ?? 'Incorrect Password'),
//           content: Text(AppLocalizations.of(context)?.translate('error_incorrect_password_message') ?? 'Please check your password and try again.'),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: Text(AppLocalizations.of(context)?.translate('ok') ?? 'OK'),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:homedocorapp/components/my_textfield.dart';
import 'package:homedocorapp/components/app_drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:homedocorapp/services/authservice.dart';
import 'package:homedocorapp/localization.dart'; // Import your localization file

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;

  // Instance of AuthService
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
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
      ),
      drawer: AppDrawer(),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 50),
                  Icon(
                    Icons.lock,
                    size: 100,
                  ),
                  SizedBox(height: 50),
                  Text(
                    localization?.translate('login_welcome') ?? 'Welcome back you\'ve been missed!',
                    style: TextStyle(
                      color: Color.fromARGB(255, 196, 173, 173),
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 25),
                  MyTextfield(
                    controller: emailController,
                    hintText: localization?.translate('email_hint') ?? 'Email',
                    obscureText: false,
                    prefixIcon: Icon(Icons.person),
                  ),
                  SizedBox(height: 10),
                  MyTextfield(
                    controller: passwordController,
                    hintText: localization?.translate('password_hint') ?? 'Password',
                    obscureText: true,
                    prefixIcon: Icon(Icons.lock),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          localization?.translate('forgot_password') ?? 'Forgot password?',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: isLoading ? null : signIn,
                    child: isLoading
                        ? CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : Text(localization?.translate('sign_in') ?? 'Sign In'),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: isLoading ? null : signInWithGoogle,
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                    ),
                    child: isLoading
                        ? CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : Text(localization?.translate('sign_in_google') ?? 'Sign In with Google'),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        localization?.translate('not_a_member') ?? 'Not a member?',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      SizedBox(width: 4),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/signup');
                        },
                        child: Text(
                          localization?.translate('register_now') ?? 'Register now',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                 
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Sign in with Google
  void signInWithGoogle() async {
    setState(() {
      isLoading = true;
    });

    final User? user = await _authService.signInWithGoogle();

    if (user != null) {
      print('User signed in with Google: ${user.displayName}');
      Navigator.pushReplacementNamed(context, '/home'); // Navigate to home screen
    } else {
      // Handle sign-in failure
      print('Failed to sign in with Google.');
    }

    setState(() {
      isLoading = false;
    });
  }

  // Sign in with email and password
  void signIn() async {
    setState(() {
      isLoading = true;
    });

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      Navigator.pushReplacementNamed(context, '/home'); // Navigate to home screen
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        wrongEmailMessage();
      } else if (e.code == 'wrong-password') {
        wrongPasswordMessage();
      }
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  // Dialogs for error messages
  void wrongEmailMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)?.translate('error_incorrect_email') ?? 'Incorrect Email'),
          content: Text(AppLocalizations.of(context)?.translate('error_incorrect_email_message') ?? 'Please check your email and try again.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(AppLocalizations.of(context)?.translate('ok') ?? 'OK'),
            ),
          ],
        );
      },
    );
  }

  void wrongPasswordMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)?.translate('error_incorrect_password') ?? 'Incorrect Password'),
          content: Text(AppLocalizations.of(context)?.translate('error_incorrect_password_message') ?? 'Please check your password and try again.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(AppLocalizations.of(context)?.translate('ok') ?? 'OK'),
            ),
          ],
        );
      },
    );
  }
}
