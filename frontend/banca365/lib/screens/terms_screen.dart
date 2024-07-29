import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // Para codificar la solicitud JSON

class TermsScreen extends StatefulWidget {
  const TermsScreen({super.key});

  @override
  _TermsScreenState createState() => _TermsScreenState();
}

class _TermsScreenState extends State<TermsScreen> {
  bool _acceptTerms = false;
  bool _readAndAcceptTerms = false;

  // Variables para recibir datos
  late String fotoBase64;
  late String cedula;
  late String codigoDactilar;
  late String email;
  late String provincia;
  late String celular;
  late String situacionLaboral;
  late String nombreEmpresa;
  late String impuesto;
  late String nombre;
  late String apellido;

  @override
  void initState() {
    super.initState();
    // Inicialización de variables al iniciar el estado
    fotoBase64 = '';
    cedula = '';
    codigoDactilar = '';
    email = '';
    celular = '';
    provincia = '';
    situacionLaboral = '';
    nombreEmpresa = '';
    impuesto = '';
    nombre = '';
    apellido = '';
  }

  // Método para imprimir los datos recibidos por consola
  void printReceivedData(Map<String, dynamic> data) {
    fotoBase64 = data['fotoBase64'];
    cedula = data['cedula'];
    codigoDactilar = data['codigoDactilar'];
    celular = data['celular'];
    email = data['email'];
    provincia = data['provincia'];
    situacionLaboral = data['situacionLaboral'];
    nombreEmpresa = data['nombreEmpresa'] ?? '';
    impuesto = data['impuesto'];
    nombre = data['nombres'];
    apellido = data['apellidos'];

    print('Datos recibidos en TermsScreen:');
    print('Foto en Base64: $fotoBase64');
    print('Cédula: $cedula');
    print('Código Dactilar: $codigoDactilar');
    print('Correo Electrónico: $email');
    print('Provincia: $provincia');
    print('Situación Laboral: $situacionLaboral');
    if (situacionLaboral == 'Empresa') {
      print('Nombre de la Empresa: $nombreEmpresa');
    }
    print('Impuesto: $impuesto');
    print('Nombre: $nombre');
    print('Apellido: $apellido');
  }

  // Método para realizar la solicitud POST y manejar la respuesta
  Future<void> _submitForm() async {
    final url = Uri.parse('https://servicios-web.lat/api/Usuario/crear-cuenta');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'nombres': nombre,
        'apellidos': apellido,
        'cedula': cedula,
        'codigoDactilar': codigoDactilar,
        'celular': celular, // Debes obtener este dato de alguna forma
        'email': email,
        'provincia': provincia,
        'rostroBase64': fotoBase64,
        'situacionLaboral': situacionLaboral,
        'empresa': nombreEmpresa,
        'paisPagoImpuestos': impuesto,
        'aceptoTerminosYConcidiones': true,
      }),
    );

    if (response.statusCode == 200) {
      Navigator.pushNamed(context, '/confirmation', arguments: {
        'fotoBase64': fotoBase64,
        'cedula': cedula,
        'codigoDactilar': codigoDactilar,
        'email': email,
        'provincia': provincia,
        'situacionLaboral': situacionLaboral,
        'nombreEmpresa': nombreEmpresa,
        'impuesto': impuesto,
        'terminos': true,
        'nombre': nombre,
        'apellido': apellido,
      });
    } else {
      // Mostrar mensaje de error
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content:
                Text('Error en la creación de la cuenta: ${response.body}'),
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
  }

  @override
  Widget build(BuildContext context) {
    // Obtenemos el tamaño de la pantalla
    final size = MediaQuery.of(context).size;
    final double textScaleFactor = size.width * 0.005;
    final double buttonHeight = size.height * 0.07; // Altura del botón
    final double buttonWidth = size.width * 0.8; // Anchura del botón

    // Recibir datos enviados desde la pantalla anterior (TaxScreen)
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    printReceivedData(args); // Llama a la función para imprimir datos

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Términos y Condiciones',
          style: TextStyle(fontSize: 8 * textScaleFactor),
        ),
        backgroundColor: Colors.blueAccent,
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
            SizedBox(height: size.height * 0.1),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed:
                    _acceptTerms && _readAndAcceptTerms ? _submitForm : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
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
                child: Text(
                  'Continuar',
                  style: TextStyle(fontSize: 5 * textScaleFactor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
