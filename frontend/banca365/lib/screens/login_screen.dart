import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> login() async {
    try {
      final response = await http.post(
        Uri.parse('https://servicios-web.lat/api/Autenticacion/login'),
        headers: {
          'Content-Type': 'application/json',
          'accept': '*/*',
        },
        body: jsonEncode({
          'email': emailController.text,
          'password': passwordController.text,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final jwt = data['jwt'];
        final userName = data['usuario']['nombres']; // Extraer el nombre

        // Guardar el token JWT en shared_preferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('jwt', jwt);

        // Redirigir a la siguiente pantalla con el nombre del usuario
        Navigator.pushNamed(
          context,
          '/account',
          arguments: {'userName': userName},
        );
      } else {
        // Mostrar mensaje de error
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('Correo o contraseña incorrectos'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      // Manejo de errores de red y excepciones
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text(
                'Ocurrió un error al realizar la solicitud. Intenta nuevamente.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

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
                TextField(
                  controller: emailController,
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
                TextField(
                  controller: passwordController,
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
                      login(); // Llamar a la función login
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






/*import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> login() async {
    final response = await http.post(
      Uri.parse('https://servicios-web.lat/api/Autenticacion/login'),
      headers: {
        'Content-Type': 'application/json',
        'accept': '*',
      },
      body: jsonEncode({
        'email': emailController.text,
        'password': passwordController.text,
      }),
    );

    if (response.statusCode == 200) {
      // Si el servidor devuelve una respuesta OK, redirigir a la pantalla de inicio
      Navigator.pushNamed(context, '/begin');
    } else {
      // Si la respuesta no es OK, muestra un mensaje de error
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Correo o contraseña incorrectos'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

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
                TextField(
                  controller: emailController,
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
                TextField(
                  controller: passwordController,
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
                      login(); // Llamar a la función login
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
}*/

