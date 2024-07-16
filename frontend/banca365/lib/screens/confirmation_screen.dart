import 'package:flutter/material.dart';

class ConfirmationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Confirmación de Cuenta')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Confirmación de tu cuenta', style: TextStyle(fontSize: 24)),
            Text(
                'Se le enviará un correo a su correo o número de celular con un código',
                style: TextStyle(fontSize: 16)),
            TextField(
              decoration: InputDecoration(labelText: 'Código'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/success');
              },
              child: Text('Continuar'),
            ),
          ],
        ),
      ),
    );
  }
}
