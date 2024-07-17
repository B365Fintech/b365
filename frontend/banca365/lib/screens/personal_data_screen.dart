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
