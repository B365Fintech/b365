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
    final double buttonHeight = size.height * 0.07; // Altura del botón
    final double buttonWidth = size.width * 0.8; // Anchura del botón

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Términos y Condiciones',
          style: TextStyle(fontSize: 8 * textScaleFactor),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(size.width * 0.05),
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
                minimumSize: Size(buttonWidth, buttonHeight),
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.01,
                  vertical: size.height * 0.01,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // Bordes redondeados
                ),
                textStyle: TextStyle(fontSize: 5 * textScaleFactor),
              ),
              child: Text(
                'Continuar',
                style: TextStyle(fontSize: 5 * textScaleFactor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
