import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    // Obtener el tamaño de la pantalla
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(title: Text('Registro')),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.01),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Empecemos', style: TextStyle(fontSize: screenWidth * 0.05)),
              Row(
                children: [
                  Image.asset(
                    'assets/images/cedula.png',
                    width: screenWidth * 0.5,
                    height: screenHeight * 0.3,
                  ),
                  SizedBox(width: screenWidth * 0.01),
                  Flexible(
                    child: Text(
                      'Ingresa tus datos',
                      style: TextStyle(fontSize: screenWidth * 0.075),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2, // Limitar a una sola línea
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.01),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Cédula',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: screenHeight * 0.01),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Código Dactilar',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              Row(
                children: [
                  Checkbox(
                    value: _isChecked,
                    onChanged: (bool? newValue) {
                      setState(() {
                        _isChecked = newValue ?? false;
                      });
                    },
                  ),
                  Expanded(
                    child: Text(
                      'Al hacer clic en “Deseo mi cuenta” autorizo al Banco verificar el tratamiento de mis datos personales',
                      style: TextStyle(fontSize: screenWidth * 0.04),
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.05),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/identity_validation');
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Color(0xFF1e90ff)),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    padding: MaterialStateProperty.all<EdgeInsets>(
                      EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.2,
                          vertical: screenHeight * 0.02),
                    ),
                    textStyle: MaterialStateProperty.all<TextStyle>(
                      TextStyle(fontSize: screenWidth * 0.04),
                    ),
                  ),
                  child: Text('Confirmar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
