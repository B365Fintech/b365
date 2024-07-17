import 'package:flutter/material.dart';

class ConfirmationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Obtenemos el tamaño de la pantalla
    final size = MediaQuery.of(context).size;
    final double textScaleFactor = size.width * 0.005;

    return Scaffold(
      appBar: AppBar(
        title: Text('Confirmación de Cuenta',
            style: TextStyle(fontSize: 10 * textScaleFactor)),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: size.height * 0.02),
            Text(
              'Confirmación de tu cuenta',
              style: TextStyle(fontSize: 8 * textScaleFactor),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: size.height * 0.03),
            Text(
              'Se le enviará un correo a su correo o número de celular con un código',
              style: TextStyle(fontSize: 5 * textScaleFactor),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: size.height * 0.03),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Código',
                  labelStyle: TextStyle(fontSize: 5 * textScaleFactor),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
              ),
            ),
            SizedBox(height: size.height * 0.03),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/success');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
              child: Text('Continuar',
                  style: TextStyle(fontSize: 5 * textScaleFactor)),
            ),
          ],
        ),
      ),
    );
  }
}
