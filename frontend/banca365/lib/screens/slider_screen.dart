import 'package:flutter/material.dart';
import 'dart:async';

class SliderScreen extends StatefulWidget {
  @override
  _SliderScreenState createState() => _SliderScreenState();
}

class _SliderScreenState extends State<SliderScreen> {
  @override
  void initState() {
    super.initState();
    // Esperar 3 segundos antes de navegar a la pantalla de inicio de sesión
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/begin');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFF1e90ff), // Establecer el fondo azul oscuro
        child: Center(
          child: Image.asset('assets/images/logoanimado.gif',
              width: 200,
              height: 200), // Asegúrate de tener la imagen en la carpeta assets
        ),
      ),
    );
  }
}
