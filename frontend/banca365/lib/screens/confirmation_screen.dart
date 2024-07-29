import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ConfirmationScreen extends StatefulWidget {
  @override
  _ConfirmationScreenState createState() => _ConfirmationScreenState();
}

class _ConfirmationScreenState extends State<ConfirmationScreen> {
  List<String> _codeFields = List.filled(6, '');
  bool _isButtonEnabled = false;
  String _codigo = '';

  // Verificar si todos los campos están llenos
  void _checkCodeCompletion() {
    setState(() {
      _isButtonEnabled = _codeFields.every((field) => field.isNotEmpty);
    });
  }

  // Manejar el cambio de valor en un cuadro de texto
  void _onCodeChanged(String value, int index) {
    if (value.length == 1 && index < 5) {
      FocusScope.of(context).nextFocus();
    }
    setState(() {
      _codeFields[index] = value;
      _checkCodeCompletion();
    });
  }

  // Obtener el código completo
  String get _codigoCompleto => _codeFields.join();

  // Función para consumir la API
  Future<void> _verificarCuenta(String email, String codigo) async {
    final url = Uri.parse('http://localhost:5063/api/Usuario/verificar-cuenta');
    final response = await http.put(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'codigo': codigo,
      }),
    );

    if (response.statusCode == 200) {
      // Si la respuesta es 200, navega a la siguiente pantalla
      Navigator.pushNamed(context, '/success');
    } else {
      // Si no, muestra un mensaje de error con la respuesta
      final responseBody = jsonDecode(response.body);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${responseBody['message']}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Obtenemos el tamaño de la pantalla
    final size = MediaQuery.of(context).size;
    final double textScaleFactor = size.width * 0.005;

    // Recibir datos enviados desde la pantalla anterior (TermsScreen)
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    // Imprimir datos recibidos por consola
    print(
        'Datos recibidos en ConfirmationScreen:----------------------------------------------');
    print('Cédula: ${args['cedula']}');
    print('Código Dactilar: ${args['codigoDactilar']}');
    print('Correo Electrónico: ${args['email']}');
    print('Contraseña: ${args['password']}');
    print('Provincia: ${args['provincia']}');
    print('Situación Laboral: ${args['situacionLaboral']}');
    if (args['situacionLaboral'] == 'Empresa') {
      print('Nombre de la Empresa: ${args['nombreEmpresa']}');
    }
    print('Impuesto: ${args['impuesto']}');
    print('Términos aceptados: ${args['terminos']}');
    print('Nombre: ${args['nombre']}');
    print('Apellido: ${args['apellido']}');

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Confirmación de Cuenta',
          style: TextStyle(fontSize: 10 * textScaleFactor),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(size.width * 0.05),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(6, (index) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: size.width * 0.02),
                  width: size.width * 0.10,
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: ' ',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    maxLength: 1,
                    style: TextStyle(fontSize: size.width * 0.04),
                    onChanged: (value) {
                      _onCodeChanged(value, index);
                    },
                  ),
                );
              }),
            ),
            SizedBox(height: size.height * 0.03),
            ElevatedButton(
              onPressed: _isButtonEnabled
                  ? () {
                      _codigo = _codigoCompleto;
                      _verificarCuenta(args['email'], _codigo);
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                minimumSize: Size(size.width * 0.8, size.height * 0.07),
              ),
              child: Text(
                'Continuar',
                style: TextStyle(fontSize: 5 * textScaleFactor),
              ),
            ),
            SizedBox(height: size.height * 0.02),
          ],
        ),
      ),
    );
  }
}
