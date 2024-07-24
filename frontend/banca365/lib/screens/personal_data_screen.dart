import 'package:flutter/material.dart';

class PersonalDataScreen extends StatefulWidget {
  @override
  _PersonalDataScreenState createState() => _PersonalDataScreenState();
}

class _PersonalDataScreenState extends State<PersonalDataScreen> {
  String? cedula;
  String? codigoDactilar;
  String? fotoBase64;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  String? provinciaSeleccionada;

  bool isValid = false; // Variable para habilitar el botón de continuar

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      final args =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      setState(() {
        cedula = args['cedula'];
        codigoDactilar = args['codigoDactilar'];
        fotoBase64 = args['fotoBase64'];
      });

      print('Foto en Base64: $fotoBase64');
      print('Cédula: $cedula');
      print('Código Dactilar: $codigoDactilar');
    });
  }

  // Función para validar si todos los campos están completos
  void validateFields() {
    setState(() {
      if (cedula != null &&
          codigoDactilar != null &&
          emailController.text.isNotEmpty &&
          passwordController.text.isNotEmpty &&
          confirmPasswordController.text.isNotEmpty &&
          provinciaSeleccionada != null) {
        isValid = true;
      } else {
        isValid = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double textScaleFactor = size.width * 0.005;

    return Scaffold(
      appBar: AppBar(title: Text('Datos Personales')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Datos Personales',
              style: TextStyle(fontSize: 10 * textScaleFactor),
            ),
            SizedBox(height: size.height * 0.06),
            Text(
              'Empecemos',
              style: TextStyle(fontSize: 8 * textScaleFactor),
            ),
            SizedBox(height: size.height * 0.04),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Cédula',
                  labelStyle: TextStyle(fontSize: 5 * textScaleFactor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                ),
                controller: TextEditingController(text: cedula),
                enabled: false, // Deshabilitar edición
              ),
            ),
            SizedBox(height: size.height * 0.04),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Correo Electrónico',
                  labelStyle: TextStyle(fontSize: 5 * textScaleFactor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                ),
                controller: emailController,
                onChanged: (_) => validateFields(),
              ),
            ),
            SizedBox(height: size.height * 0.04),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                  labelStyle: TextStyle(fontSize: 5 * textScaleFactor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                ),
                obscureText: true,
                controller: passwordController,
                onChanged: (_) => validateFields(),
              ),
            ),
            SizedBox(height: size.height * 0.04),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Confirmar Contraseña',
                  labelStyle: TextStyle(fontSize: 5 * textScaleFactor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                ),
                obscureText: true,
                controller: confirmPasswordController,
                onChanged: (_) => validateFields(),
              ),
            ),
            SizedBox(height: size.height * 0.04),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(0),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    hint: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Provincia',
                          style: TextStyle(fontSize: 5 * textScaleFactor)),
                    ),
                    isExpanded: true,
                    value: provinciaSeleccionada,
                    items:
                        <String>['Loja', 'Cuenca', 'Quito'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(value,
                              style: TextStyle(fontSize: 5 * textScaleFactor)),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        provinciaSeleccionada = value;
                      });
                      validateFields();
                    },
                  ),
                ),
              ),
            ),
            SizedBox(height: size.height * 0.09),
            ElevatedButton(
              onPressed: isValid
                  ? () {
                      Navigator.pushNamed(context, '/work', arguments: {
                        'cedula': cedula,
                        'codigoDactilar': codigoDactilar,
                        'email': emailController.text,
                        'password': passwordController.text,
                        'provincia': provinciaSeleccionada,
                        'fotoBase64': fotoBase64,
                      });
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
              child: Text('Continuar',
                  style: TextStyle(fontSize: 6 * textScaleFactor)),
            ),
          ],
        ),
      ),
    );
  }
}






/*
import 'package:flutter/material.dart';

class PersonalDataScreen extends StatefulWidget {
  @override
  _PersonalDataScreenState createState() => _PersonalDataScreenState();
}

class _PersonalDataScreenState extends State<PersonalDataScreen> {
  @override
  Widget build(BuildContext context) {
    // Obtenemos el tamaño de la pantalla
    final size = MediaQuery.of(context).size;
    final double textScaleFactor = size.width * 0.005;

    return Scaffold(
      appBar: AppBar(title: Text('Datos Personales')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Datos Personales',
              style: TextStyle(fontSize: 10 * textScaleFactor),
            ),
            SizedBox(height: size.height * 0.06),
            Text(
              'Empecemos',
              style: TextStyle(fontSize: 8 * textScaleFactor),
            ),
            SizedBox(height: size.height * 0.04),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Cédula',
                  labelStyle: TextStyle(fontSize: 5 * textScaleFactor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(0), // Bordes cuadrados
                  ),
                ),
              ),
            ),
            SizedBox(height: size.height * 0.04),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Correo Electrónico',
                  labelStyle: TextStyle(fontSize: 5 * textScaleFactor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(0), // Bordes cuadrados
                  ),
                ),
              ),
            ),
            SizedBox(height: size.height * 0.04),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                  labelStyle: TextStyle(fontSize: 5 * textScaleFactor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(0), // Bordes cuadrados
                  ),
                ),
                obscureText: true,
              ),
            ),
            SizedBox(height: size.height * 0.04),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Confirmar Contraseña',
                  labelStyle: TextStyle(fontSize: 5 * textScaleFactor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(0), // Bordes cuadrados
                  ),
                ),
                obscureText: true,
              ),
            ),
            SizedBox(height: size.height * 0.04),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(0), // Bordes cuadrados
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    hint: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Provincia',
                          style: TextStyle(fontSize: 5 * textScaleFactor)),
                    ),
                    isExpanded: true,
                    items:
                        <String>['Loja', 'Cuenca', 'Quito'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(value,
                              style: TextStyle(fontSize: 5 * textScaleFactor)),
                        ),
                      );
                    }).toList(),
                    onChanged: (_) {},
                  ),
                ),
              ),
            ),
            SizedBox(height: size.height * 0.09),
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
              child: Text('Continuar',
                  style: TextStyle(fontSize: 6 * textScaleFactor)),
            ),
          ],
        ),
      ),
    );
  }
}
*/