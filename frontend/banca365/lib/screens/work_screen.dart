import 'package:flutter/material.dart';

class WorkScreen extends StatefulWidget {
  const WorkScreen({super.key});

  @override
  _WorkScreenState createState() => _WorkScreenState();
}

class _WorkScreenState extends State<WorkScreen> {
  bool _isIndependent = false;
  bool _isEmployed = false;
  bool _isUnemployed = false;
  TextEditingController _companyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Obtenemos el tamaño de la pantalla
    final size = MediaQuery.of(context).size;
    final double textScaleFactor = size.width * 0.005;

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
                        fontSize: 5 * textScaleFactor),
                  ),
                  value: _isIndependent,
                  onChanged: (bool? value) {
                    setState(() {
                      _isIndependent = value ?? false;
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
                        fontSize: 5 * textScaleFactor),
                  ),
                  value: _isEmployed,
                  onChanged: (bool? value) {
                    setState(() {
                      _isEmployed = value ?? false;
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
                        fontSize: 5 * textScaleFactor),
                  ),
                  value: _isUnemployed,
                  onChanged: (bool? value) {
                    setState(() {
                      _isUnemployed = value ?? false;
                    });
                  },
                ),
              ),
              SizedBox(height: size.height * 0.03),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextField(
                  controller: _companyController,
                  decoration: InputDecoration(
                    labelText: 'Nombre de la empresa',
                    labelStyle: TextStyle(
                        color: Colors.black, fontSize: 5 * textScaleFactor),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                  style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 5 * textScaleFactor),
                ),
              ),
              SizedBox(height: size.height * 0.09),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/tax');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Fondo azul
                  foregroundColor: Colors.white, // Texto blanco
                  padding: EdgeInsets.symmetric(
                      horizontal: size.height * 0.21,
                      vertical: size.height * 0.02), // Padding
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
