import 'package:flutter/material.dart';

class WorkScreen extends StatefulWidget {
  const WorkScreen({Key? key}) : super(key: key);

  @override
  _WorkScreenState createState() => _WorkScreenState();
}

class _WorkScreenState extends State<WorkScreen> {
  String? _situacionLaboral;
  TextEditingController _companyController = TextEditingController();

  // Método para imprimir los datos recibidos por consola
  void printReceivedData(Map<String, dynamic> data) {
    print('Foto en Base64: ${data['fotoBase64']}');
    print('Datos recibidos en WorkScreen:');
    print('Cédula: ${data['cedula']}');
    print('Código Dactilar: ${data['codigoDactilar']}');
    print('Correo Electrónico: ${data['email']}');
    print('Celular: ${data['celular']}');
    print('Provincia: ${data['provincia']}');
    print('Nombres: ${data['nombres']}'); // Añadido
    print('Apellidos: ${data['apellidos']}'); // Añadido
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double textScaleFactor = size.width * 0.005;

    // Recibimos los datos pasados desde PersonalDataScreen
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    printReceivedData(args); // Llama a la función para imprimir datos

    return Scaffold(
      appBar: AppBar(
        title: Text('Situación Laboral',
            style: TextStyle(fontSize: 10 * textScaleFactor)),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Cuéntanos en qué trabajas',
                style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontSize: 10 * textScaleFactor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Image.asset('assets/images/trabajo.png'),
              SizedBox(height: size.height * 0.03),
              Text(
                'Situación laboral',
                style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontSize: 8 * textScaleFactor,
                ),
              ),
              SizedBox(height: size.height * 0.03),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: CheckboxListTile(
                  title: Text(
                    'Trabajador independiente',
                    style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 5 * textScaleFactor,
                    ),
                  ),
                  value: _situacionLaboral == 'Independiente',
                  onChanged: (bool? value) {
                    setState(() {
                      if (value ?? false) {
                        _situacionLaboral = 'Independiente';
                        _companyController.text = 'Ninguna';
                      } else {
                        _situacionLaboral = null;
                      }
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
                    'Trabajo en una empresa',
                    style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 5 * textScaleFactor,
                    ),
                  ),
                  value: _situacionLaboral == 'Empresa',
                  onChanged: (bool? value) {
                    setState(() {
                      if (value ?? false) {
                        _situacionLaboral = 'Empresa';
                        _companyController.text = ''; // Limpiar el texto
                      } else {
                        _situacionLaboral = null;
                      }
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
                    'No trabajo',
                    style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 5 * textScaleFactor,
                    ),
                  ),
                  value: _situacionLaboral == 'No Trabajo',
                  onChanged: (bool? value) {
                    setState(() {
                      if (value ?? false) {
                        _situacionLaboral = 'No Trabajo';
                        _companyController.text = 'Ninguna';
                      } else {
                        _situacionLaboral = null;
                      }
                    });
                  },
                ),
              ),
              SizedBox(height: size.height * 0.03),
              if (_situacionLaboral == 'Empresa')
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextField(
                    controller: _companyController,
                    decoration: InputDecoration(
                      labelText: 'Nombre de la empresa',
                      labelStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 5 * textScaleFactor,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                    style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 5 * textScaleFactor,
                    ),
                  ),
                ),
              SizedBox(height: size.height * 0.09),
              ElevatedButton(
                onPressed: () {
                  // Validar que se seleccione una situación laboral
                  if (_situacionLaboral == null) {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title:
                            Text('Selecciona una opción de situación laboral'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: Text('OK'),
                          ),
                        ],
                      ),
                    );
                  } else {
                    // Navegar a la siguiente pantalla /tax
                    Navigator.pushNamed(context, '/tax', arguments: {
                      // Pasar los datos actuales más los recibidos desde PersonalDataScreen
                      ...args,
                      'situacionLaboral': _situacionLaboral,
                      if (_situacionLaboral == 'Empresa')
                        'nombreEmpresa': _companyController.text,
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(
                    horizontal: size.height * 0.21,
                    vertical: size.height * 0.02,
                  ),
                ),
                child: Text('Continuar',
                    style: TextStyle(fontSize: 5 * textScaleFactor)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
