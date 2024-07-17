import 'package:flutter/material.dart';

class TermsScreen extends StatefulWidget {
  const TermsScreen({super.key});

  @override
  _TermsScreenState createState() => _TermsScreenState();
}

class _TermsScreenState extends State<TermsScreen> {
  bool _acceptTerms = false;
  bool _readAndAcceptTerms = false;

  @override
  Widget build(BuildContext context) {
    // Obtenemos el tamaño de la pantalla
    final size = MediaQuery.of(context).size;
    final double textScaleFactor = size.width * 0.005;

    return Scaffold(
      appBar: AppBar(
        title: Text('Términos y Condiciones',
            style: TextStyle(fontSize: 8 * textScaleFactor)),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: size.height * 0.02),
            Text(
              'Aceptación de Términos y Condiciones',
              style: TextStyle(fontSize: 10 * textScaleFactor),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: size.height * 0.03),
            Image.asset(
              'assets/images/logo.png', // Asegúrate de tener la imagen en la carpeta assets
              width: size.width * 0.5, // Ajusta el tamaño de la imagen
              height: size.height * 0.25,
            ),
            SizedBox(height: size.height * 0.03),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: CheckboxListTile(
                title: Text(
                  'Acepto los términos y condiciones',
                  style: TextStyle(fontSize: 5 * textScaleFactor),
                ),
                value: _acceptTerms,
                onChanged: (newValue) {
                  setState(() {
                    _acceptTerms = newValue ?? false;
                  });
                },
              ),
            ),
            SizedBox(height: size.height * 0.02),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: CheckboxListTile(
                title: Text(
                  'He leído y acepto los términos y condiciones',
                  style: TextStyle(fontSize: 5 * textScaleFactor),
                ),
                value: _readAndAcceptTerms,
                onChanged: (newValue) {
                  setState(() {
                    _readAndAcceptTerms = newValue ?? false;
                  });
                },
              ),
            ),
            SizedBox(height: size.height * 0.03),
            ElevatedButton(
              onPressed: _acceptTerms && _readAndAcceptTerms
                  ? () {
                      Navigator.pushNamed(context, '/confirmation');
                    }
                  : null,
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
