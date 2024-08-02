import 'package:flutter/material.dart';
import 'package:homedocorapp/components/app_drawerEs.dart';


class WelcomePageEs extends StatelessWidget {
  WelcomePageEs({Key? key}) : super(key: key);

  void navigateToLogin(BuildContext context) {
    Navigator.pushNamed(context, '/login_es'); // Ensure the correct route for Spanish login
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Aplicación de Decoración del Hogar'),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer(); // Open the global drawer
              },
            );
          },
        ),
      ),
      drawer: AppDrawerEs(), // Call the global drawer here
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'lib/images/welcome_img.png', // Update with an appropriate image
                  width: 300,
                  height: 350,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 30),
                Text(
                  '¡Bienvenido a tu tienda de Decoración del Hogar!',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Experimenta la mejor plataforma de compras en línea. Descubre una amplia gama de productos para tu hogar a precios increíbles.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                  ),
                ),
                SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () => navigateToLogin(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    textStyle: TextStyle(fontSize: 18),
                  ),
                  child: Text('Comienza a Comprar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
