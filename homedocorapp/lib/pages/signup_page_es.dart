// signup_page_es.dart
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:homedocorapp/components/app_drawerEs.dart';
import 'package:homedocorapp/components/my_button.dart';
import 'package:homedocorapp/components/my_textfield.dart';
import 'package:homedocorapp/components/app_drawer.dart';

class SignupPageEs extends StatelessWidget {
  SignupPageEs({Key? key}) : super(key: key);

  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void registerUser(BuildContext context) async {
    if (passwordController.text == confirmPasswordController.text) {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Cuenta Creada'),
              content: Text('Tu cuenta ha sido creada con éxito.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      } on FirebaseAuthException catch (e) {
        showErrorMessage(context, e.message ?? "Ocurrió un error.");
      }
    } else {
      showErrorMessage(context, "Las contraseñas no coinciden");
    }
  }

  void showErrorMessage(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void signInWithGoogle(BuildContext context) async {
    try {
      final provider = FirebaseAuth.instance.signInWithPopup(GoogleAuthProvider());
      final UserCredential userCredential = await provider;
      final User? user = userCredential.user;
      if (user != null) {
        print('Usuario inició sesión con Google: ${user.displayName}');
        // Navegar a otra pantalla o manejar el inicio de sesión exitoso
        // Ejemplo: Navigator.pushReplacementNamed(context, '/home');
      }
    } catch (e) {
      print('Error al iniciar sesión con Google: $e');
      // Manejar errores aquí
    }
  }

  @override
  Widget build(BuildContext context) {
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
      drawer: AppDrawerEs(),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Image.asset(
                    'lib/Assets/imgs/register.jpg',
                    fit: BoxFit.contain,
                    width: 380,
                    height: 200,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  '¡Únete a nosotros hoy!',
                  style: TextStyle(
                    color: Color.fromARGB(255, 196, 173, 173),
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 25),
                // Username textfield
                MyTextfield(
                  controller: usernameController,
                  hintText: 'Nombre de usuario',
                  obscureText: false,
                  prefixIcon: Icon(Icons.person),
                ),
                SizedBox(height: 10),
                // Email textfield
                MyTextfield(
                  controller: emailController,
                  hintText: 'Correo electrónico',
                  obscureText: false,
                  prefixIcon: Icon(Icons.email),
                ),
                SizedBox(height: 10),
                // Password textfield
                MyTextfield(
                  controller: passwordController,
                  hintText: 'Contraseña',
                  obscureText: true,
                  prefixIcon: Icon(Icons.lock),
                ),
                SizedBox(height: 10),
                // Confirm password textfield
                MyTextfield(
                  controller: confirmPasswordController,
                  hintText: 'Confirmar Contraseña',
                  obscureText: true,
                  prefixIcon: Icon(Icons.lock),
                ),
                SizedBox(height: 20),
                // Register button
                MyButton(
                  onTap: () => registerUser(context),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () => signInWithGoogle(context),
                  child: Text('Registrarse con Google'),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[100],
                      ),
                    )
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '¿Ya tienes una cuenta?',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/login');
                      },
                      child: const Text(
                        'Inicia sesión ahora',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
