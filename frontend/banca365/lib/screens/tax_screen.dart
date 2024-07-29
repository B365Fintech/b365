import 'package:flutter/material.dart';

class TaxScreen extends StatefulWidget {
  @override
  _TaxScreenState createState() => _TaxScreenState();
}

class _TaxScreenState extends State<TaxScreen> {
  bool _isEcuadorChecked = false;
  bool _isOtherCountriesChecked = false;
  String? _impuesto;

  // Variables para recibir datos
  late String fotoBase64;
  late String cedula;
  late String codigoDactilar;
  late String email;
  late String provincia;
  late String celular;
  late String situacionLaboral;
  late String nombreEmpresa;
  late String nombre;
  late String apellido;

  // Método para imprimir los datos recibidos por consola
  void printReceivedData(Map<String, dynamic> data) {
    fotoBase64 = data['fotoBase64'];
    cedula = data['cedula'];
    codigoDactilar = data['codigoDactilar'];
    email = data['email'];
    celular = data['celular'];
    provincia = data['provincia'];
    situacionLaboral = data['situacionLaboral'];
    nombreEmpresa = data['nombreEmpresa'] ?? '';
    nombre = data['nombres'];
    apellido = data['apellidos'];

    print('Datos recibidos en TaxScreen:');
    print('Foto en Base64: $fotoBase64');
    print('Cédula: $cedula');
    print('Código Dactilar: $codigoDactilar');
    print('Correo Electrónico: $email');
    print('Provincia: $provincia');
    print('Situación Laboral: $situacionLaboral');
    print('Célular: $celular');
    print('Nombre: $nombre');
    print('Apellido: $apellido');
    if (situacionLaboral == 'Empresa') {
      print('Nombre de la Empresa: $nombreEmpresa');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double textScaleFactor = size.width * 0.005;
    final double buttonHeight = size.height * 0.07;
    final double buttonWidth = size.width * 0.8;

    // Recibir datos enviados desde la pantalla anterior (WorkScreen)
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    printReceivedData(args); // Llama a la función para imprimir datos

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Impuestos',
          style: TextStyle(fontSize: 10 * textScaleFactor),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(size.width * 0.05),
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
                        if (_isEcuadorChecked) {
                          _isOtherCountriesChecked = false;
                          _impuesto = 'Ecuador';
                        } else {
                          _impuesto = null;
                        }
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
                        if (_isOtherCountriesChecked) {
                          _isEcuadorChecked = false;
                          _impuesto = 'Otros Países';
                        } else {
                          _impuesto = null;
                        }
                      });
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: size.height * 0.001),
            Image.asset(
              'assets/images/pais.png',
              width: size.width * 0.5,
              height: size.width * 0.5,
            ),
            ElevatedButton(
              onPressed: () {
                if (_impuesto == null) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Selecciona un país para pagar impuestos'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: Text('OK'),
                        ),
                      ],
                    ),
                  );
                } else {
                  // Navegar a la siguiente pantalla /terms y pasar todos los datos
                  Navigator.pushNamed(context, '/terms', arguments: {
                    'fotoBase64': fotoBase64,
                    'cedula': cedula,
                    'codigoDactilar': codigoDactilar,
                    'email': email,
                    'provincia': provincia,
                    'celular': cedula,
                    'situacionLaboral': situacionLaboral,
                    'nombreEmpresa': nombreEmpresa,
                    'impuesto': _impuesto,
                    'nombres': nombre,
                    'apellidos': apellido,
                  });
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                minimumSize: Size(buttonWidth, buttonHeight),
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.01,
                  vertical: size.height * 0.01,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
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
