import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    // Obtener el tamaño de la pantalla
    final size = MediaQuery.of(context).size;
    final double textScaleFactor = size.width * 0.005;

    return Scaffold(
      appBar: AppBar(
        title:
            Text('Registro', style: TextStyle(fontSize: 8 * textScaleFactor)),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(size.width * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: size.height * 0.02),
            Text(
              'Empecemos',
              style: TextStyle(fontSize: 10 * textScaleFactor),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: size.height * 0.03),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/cedula.png',
                  width: size.width * 0.4,
                  height: size.height * 0.25,
                ),
                SizedBox(width: size.width * 0.05),
                Flexible(
                  child: Text(
                    'Ingresa tus datos',
                    style: TextStyle(fontSize: 7 * textScaleFactor),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
              ],
            ),
            SizedBox(height: size.height * 0.03),
            TextField(
              decoration: InputDecoration(
                labelText: 'Cédula',
                labelStyle: TextStyle(fontSize: 5 * textScaleFactor),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              keyboardType: TextInputType.number,
              style: TextStyle(fontSize: 5 * textScaleFactor),
            ),
            SizedBox(height: size.height * 0.02),
            TextField(
              decoration: InputDecoration(
                labelText: 'Código Dactilar',
                labelStyle: TextStyle(fontSize: 5 * textScaleFactor),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              style: TextStyle(fontSize: 5 * textScaleFactor),
            ),
            SizedBox(height: size.height * 0.02),
            Row(
              children: [
                Checkbox(
                  value: _isChecked,
                  onChanged: (bool? newValue) {
                    setState(() {
                      _isChecked = newValue ?? false;
                    });
                  },
                ),
                Expanded(
                  child: Text(
                    'Al hacer clic en “Deseo mi cuenta” autorizo al Banco verificar el tratamiento de mis datos personales',
                    style: TextStyle(fontSize: 5 * textScaleFactor),
                  ),
                ),
              ],
            ),
            SizedBox(height: size.height * 0.08),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/identity_validation');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF1e90ff),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.39,
                    vertical: size.height * 0.03),
                textStyle: TextStyle(fontSize: 5 * textScaleFactor),
              ),
              child: Text('Confirmar'),
            ),
          ],
        ),
      ),
    );
  }
}
