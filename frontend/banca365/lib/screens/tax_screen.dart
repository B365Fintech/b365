import 'package:flutter/material.dart';

class TaxScreen extends StatefulWidget {
  @override
  _TaxScreenState createState() => _TaxScreenState();
}

class _TaxScreenState extends State<TaxScreen> {
  bool _isEcuadorChecked = false;
  bool _isOtherCountriesChecked = false;

  @override
  Widget build(BuildContext context) {
    // Obtenemos el tamaño de la pantalla
    final size = MediaQuery.of(context).size;
    final double textScaleFactor = size.width * 0.005;

    return Scaffold(
      appBar: AppBar(
        title:
            Text('Impuestos', style: TextStyle(fontSize: 10 * textScaleFactor)),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: size.height * 0.08),
            Text(
              '¿Dónde pagas tus impuestos?',
              style: TextStyle(fontSize: 8 * textScaleFactor),
            ),
            SizedBox(height: size.height * 0.02),
            Text(
              'Elige el país donde pagas tus impuestos',
              style: TextStyle(fontSize: 5 * textScaleFactor),
            ),
            SizedBox(height: size.height * 0.06),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Column(
                children: [
                  CheckboxListTile(
                    title: Text(
                      'Ecuador',
                      style: TextStyle(fontSize: 5 * textScaleFactor),
                    ),
                    value: _isEcuadorChecked,
                    onChanged: (newValue) {
                      setState(() {
                        _isEcuadorChecked = newValue ?? false;
                      });
                    },
                  ),
                  SizedBox(height: size.height * 0.03),
                  CheckboxListTile(
                    title: Text(
                      'Otros Países',
                      style: TextStyle(fontSize: 5 * textScaleFactor),
                    ),
                    value: _isOtherCountriesChecked,
                    onChanged: (newValue) {
                      setState(() {
                        _isOtherCountriesChecked = newValue ?? false;
                      });
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: size.height * 0.1),
            Image.asset('assets/images/pais.png'),
            SizedBox(height: size.height * 0.01),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/terms');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(
                    horizontal: size.height * 0.21,
                    vertical: size.height * 0.02),
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
