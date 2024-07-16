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
    return Scaffold(
      body: Container(
        color: const Color.fromARGB(255, 255, 255, 255),
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Cuéntanos en qué trabajas',
                style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Image.asset('assets/images/trabajo.png'),
              const SizedBox(height: 10.0),
              const Text(
                'Situación laboral',
                style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontSize: 18.0,
                ),
              ),
              const SizedBox(height: 20.0),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: CheckboxListTile(
                  title: const Text(
                    'Trabajador independiente',
                    style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                  ),
                  value: _isIndependent,
                  onChanged: (bool? value) {
                    setState(() {
                      _isIndependent = value ?? false;
                    });
                  },
                ),
              ),
              const SizedBox(height: 10.0),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: CheckboxListTile(
                  title: const Text(
                    'Trabajo en una empresa',
                    style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                  ),
                  value: _isEmployed,
                  onChanged: (bool? value) {
                    setState(() {
                      _isEmployed = value ?? false;
                    });
                  },
                ),
              ),
              const SizedBox(height: 10.0),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: CheckboxListTile(
                  title: const Text(
                    'No trabajo',
                    style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                  ),
                  value: _isUnemployed,
                  onChanged: (bool? value) {
                    setState(() {
                      _isUnemployed = value ?? false;
                    });
                  },
                ),
              ),
              const SizedBox(height: 20.0),
              TextField(
                controller: _companyController,
                decoration: InputDecoration(
                  labelText: 'Nombre de la empresa',
                  labelStyle: TextStyle(color: Colors.black),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
                style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
              ),
              const SizedBox(height: 100.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/tax');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Fondo azul
                  foregroundColor: Colors.white, // Texto blanco
                  padding: EdgeInsets.symmetric(
                      horizontal: 150, vertical: 15), // Padding
                ),
                child: const Text('Continuar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
