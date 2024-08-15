import 'package:flutter/material.dart';
import 'loginPage.dart';
import 'registration.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Container(
        color: Color(0xFFB2DFB2), // Fondo verde claro
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: () {},
                icon: Icon(Icons.map, color: Colors.white), // Icono blanco
                label: Text('Mapa Offline'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF4CAF50), // Verde más oscuro
                ),
              ),
              SizedBox(height: 16), // Espacio entre botones
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignInPage()),
                  );
                },
                icon: Icon(Icons.login, color: Colors.white), // Icono blanco
                label: Text('Login'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF1976D2), // Azul
                ),
              ),
              SizedBox(height: 16), // Espacio entre botones
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Registration()),
                  );
                },
                icon:
                    Icon(Icons.person_add, color: Colors.white), // Icono blanco
                label: Text('Registro'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFFA500), // Naranja
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
