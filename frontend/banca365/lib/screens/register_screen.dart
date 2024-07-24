import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _isChecked = false;
  bool _isLoading = false;
  bool _isButtonEnabled = false;
  String _responseMessage = '';
  final TextEditingController _cedulaController = TextEditingController();
  final TextEditingController _codigoDactilarController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Obtener el tamaño de la pantalla
    final size = MediaQuery.of(context).size;
    final double textScaleFactor = size.width * 0.005;
    final double buttonHeight = size.height * 0.07; // Altura del botón
    final double buttonWidth = size.width * 0.8; // Anchura del botón

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
              controller: _cedulaController,
              decoration: InputDecoration(
                labelText: 'Cédula',
                labelStyle: TextStyle(fontSize: 5 * textScaleFactor),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              keyboardType: TextInputType.number,
              style: TextStyle(fontSize: 5 * textScaleFactor),
              onChanged: (text) => _updateButtonState(),
            ),
            SizedBox(height: size.height * 0.02),
            TextField(
              controller: _codigoDactilarController,
              decoration: InputDecoration(
                labelText: 'Código Dactilar',
                labelStyle: TextStyle(fontSize: 5 * textScaleFactor),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              style: TextStyle(fontSize: 5 * textScaleFactor),
              onChanged: (text) => _updateButtonState(),
            ),
            SizedBox(height: size.height * 0.02),
            Row(
              children: [
                Checkbox(
                  value: _isChecked,
                  onChanged: (bool? newValue) {
                    setState(() {
                      _isChecked = newValue ?? false;
                      _updateButtonState();
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
            _isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _isButtonEnabled ? _checkConnection : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF1e90ff),
                      foregroundColor: Colors.white,
                      minimumSize: Size(buttonWidth, buttonHeight),
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.01,
                        vertical: size.height * 0.01,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(10), // Bordes redondeados
                      ),
                      textStyle: TextStyle(fontSize: 5 * textScaleFactor),
                    ),
                    child: Text('Confirmar'),
                  ),
            if (_responseMessage.isNotEmpty)
              Padding(
                padding: EdgeInsets.only(top: size.height * 0.02),
                child: Text(
                  _responseMessage,
                  style: TextStyle(
                    color: _responseMessage == 'Cédula válida'
                        ? Colors.green
                        : Colors.red,
                    fontSize: 5 * textScaleFactor,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _updateButtonState() {
    setState(() {
      _isButtonEnabled = _cedulaController.text.isNotEmpty &&
          _codigoDactilarController.text.isNotEmpty &&
          _isChecked;
    });
  }

  Future<void> _checkConnection() async {
    setState(() {
      _isLoading = true;
      _responseMessage = '';
    });

    final url = 'http://localhost:5063/api/RegistroCivil/validar-cedula';
    final headers = {'Content-Type': 'application/json', 'Accept': '*/*'};
    final body = json.encode({
      'cedula': _cedulaController.text,
      'codigoDactilar': _codigoDactilarController.text,
    });

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        Navigator.pushNamed(
          context,
          '/identity_validation',
          arguments: {
            'cedula': _cedulaController.text,
            'codigoDactilar': _codigoDactilarController.text,
          },
        );
      } else {
        setState(() {
          _responseMessage = 'Cédula o código dactilar incorrectos';
        });
      }
    } catch (e) {
      setState(() {
        _responseMessage = 'Error en la conexión: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}
