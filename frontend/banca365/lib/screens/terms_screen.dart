import 'package:flutter/material.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Términos y Condiciones')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text('Aceptación de Términos y Condiciones',
                // ignore: prefer_const_constructors
                style: TextStyle(fontSize: 24)),
            Image.asset(
                'assets/images/logo.png'), // Asegúrate de tener la imagen en la carpeta assets
            CheckboxListTile(
              title: const Text('Acepto los términos y condiciones'),
              value: false,
              onChanged: (newValue) {
                // Lógica para cambiar el estado del checkbox
              },
            ),
            CheckboxListTile(
              title: const Text('He leído y acepto los términos y condiciones'),
              value: false,
              onChanged: (newValue) {
                // Lógica para cambiar el estado del checkbox
              },
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/confirmation');
              },
              child: const Text('Continuar'),
            ),
          ],
        ),
      ),
    );
  }
}
