import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

class PersonalDataScreen extends StatefulWidget {
  @override
  _PersonalDataScreenState createState() => _PersonalDataScreenState();
}

class _PersonalDataScreenState extends State<PersonalDataScreen> {
  final LocalAuthentication auth = LocalAuthentication();
  bool _isAuthenticating = false;

  Future<void> _authenticate() async {
    setState(() {
      _isAuthenticating = true;
    });

    try {
      final bool didAuthenticate = await auth.authenticate(
        localizedReason: 'Por favor, autentícate para continuar',
        options: const AuthenticationOptions(
          useErrorDialogs: true,
          stickyAuth: true,
        ),
      );
      if (didAuthenticate) {
        _showAuthSuccessDialog();
      } else {
        _showAuthFailedDialog();
      }
    } catch (e) {
      print(e);
      _showAuthFailedDialog();
    }

    setState(() {
      _isAuthenticating = false;
    });
  }

  void _showAuthSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Autenticación Exitosa'),
          content: Text('Huella dactilar autenticada con éxito.'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showAuthFailedDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Autenticación Fallida'),
          content: Text(
              'No se pudo autenticar usando la huella dactilar. Inténtalo de nuevo.'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Datos Personales')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Datos Personales', style: TextStyle(fontSize: 24)),
            SizedBox(height: 56),
            TextField(
              decoration: InputDecoration(
                labelText: 'Cédula',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(0), // Bordes cuadrados
                ),
              ),
            ),
            SizedBox(height: 26),
            TextField(
              decoration: InputDecoration(
                labelText: 'Correo Electrónico',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(0), // Bordes cuadrados
                ),
              ),
            ),
            SizedBox(height: 26),
            TextField(
              decoration: InputDecoration(
                labelText: 'Contraseña',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(0), // Bordes cuadrados
                ),
              ),
              obscureText: true,
            ),
            SizedBox(height: 26),
            TextField(
              decoration: InputDecoration(
                labelText: 'Confirmar Contraseña',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(0), // Bordes cuadrados
                ),
              ),
              obscureText: true,
            ),
            SizedBox(height: 26),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(0), // Bordes cuadrados
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  hint: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Provincia'),
                  ),
                  isExpanded: true,
                  items: <String>['Provincia 1', 'Provincia 2', 'Provincia 3']
                      .map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(value),
                      ),
                    );
                  }).toList(),
                  onChanged: (_) {},
                ),
              ),
            ),
            SizedBox(height: 26),
            ElevatedButton(
              onPressed: _isAuthenticating ? null : _authenticate,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
              child: _isAuthenticating
                  ? CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.fingerprint),
                        SizedBox(width: 10),
                        Text('Leer Huella Dactilar'),
                      ],
                    ),
            ),
            SizedBox(height: 26),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/work');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Fondo azul
                foregroundColor: Colors.white, // Texto blanco
                padding: EdgeInsets.symmetric(
                    horizontal: 50, vertical: 15), // Padding
              ),
              child: Text('Continuar'),
            ),
          ],
        ),
      ),
    );
  }
}
