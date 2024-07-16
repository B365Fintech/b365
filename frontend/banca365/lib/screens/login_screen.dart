import 'package:flutter/material.dart';
//import 'package:flutter/scheduler.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFF1e90ff), // Establecer el fondo azul oscuro
        padding: EdgeInsets.all(50.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Bienvenidos',
                  style: TextStyle(
                    color: Colors.white, // Letras blancas
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Image.asset('assets/images/logo.png', width: 200, height: 200),
                SizedBox(height: 20.0),
                const TextField(
                  style:
                      TextStyle(color: Colors.white), // Texto de entrada blanco
                  decoration: InputDecoration(
                    labelText: 'Correo o Usuario',
                    labelStyle: TextStyle(
                        color: Colors.white), // Texto del label blanco
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.white), // Borde blanco
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.white), // Borde blanco al enfocar
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                const TextField(
                  obscureText: true,
                  style:
                      TextStyle(color: Colors.white), // Texto de entrada blanco
                  decoration: InputDecoration(
                    labelText: 'Contraseña',
                    labelStyle: TextStyle(
                        color: Colors.white), // Texto del label blanco
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.white), // Borde blanco
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.white), // Borde blanco al enfocar
                    ),
                  ),
                ),
                SizedBox(height: 70.0),
                SizedBox(
                  width: 400,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/begin');
                      // Acción de inicio de sesión
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white, // Fondo del botón blanco
                      foregroundColor:
                          Colors.blue[900], // Texto del botón azul oscuro
                    ),
                    child: const Text('Iniciar'),
                  ),
                ),
                const SizedBox(height: 10.0),
                SizedBox(
                  width: 400,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/register');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white, // Fondo del botón blanco
                      foregroundColor:
                          Colors.blue[900], // Texto del botón azul oscuro
                    ),
                    child: const Text('Crear Cuenta'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
