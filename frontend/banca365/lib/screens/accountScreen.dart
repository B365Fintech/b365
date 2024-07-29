import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  int id = 0;
  String numero = '';
  double saldo = 0.0;
  List<dynamic> accounts = [];

  @override
  void initState() {
    super.initState();
    _fetchAccounts();
  }

  Future<void> _fetchAccounts() async {
    final prefs = await SharedPreferences.getInstance();
    final jwt = prefs.getString('jwt') ?? '';

    final response = await http.get(
      Uri.parse('https://servicios-web.lat/api/Usuario/obtener-cuentas'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwt', // Autorización con el token JWT
      },
    );

    if (response.statusCode == 200) {
      setState(() {
        accounts = jsonDecode(response.body); // Parsear la respuesta JSON

        // Asignar valores a las variables
        if (accounts.isNotEmpty) {
          id = accounts[0]['id'];
          numero = accounts[0]['numero'];
          saldo = accounts[0]['saldo'].toDouble();
        }

        print('id: $id, numero: $numero, saldo: $saldo');
      });
    } else {
      print('Error: ${response.statusCode}');
      // Mostrar mensaje de error si la solicitud falla
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('No se pudo obtener las cuentas de usuario'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Obtener el tamaño de la pantalla
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;

    // Obtener los argumentos de la navegación
    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final userName = arguments['userName'] as String;
    print(userName);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: screenHeight * 0.05), // Espacio superior
            // Fila con la imagen y el botón de salir
            Row(
              children: [
                Expanded(
                  child: Image.asset(
                    'assets/images/cedula.png',
                    height: screenHeight *
                        0.05, // Ajusta la altura en proporción a la pantalla
                    width: screenWidth * 0.05,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.exit_to_app, size: 30),
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/begin');
                  },
                ),
              ],
            ),
            // Título "Hola, [Nombre]"
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.04,
                  vertical: screenHeight *
                      0.02), // Ajusta el padding en proporción a la pantalla
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Spacer(),
                  Text(
                    'Hola, ',
                    style: TextStyle(
                      fontSize: screenWidth *
                          0.06, // Ajusta el tamaño del texto en proporción al ancho de la pantalla
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Flexible(
                    child: Text(
                      userName,
                      style: TextStyle(
                        fontSize: screenWidth *
                            0.06, // Ajusta el tamaño del texto en proporción al ancho de la pantalla
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),
            // Contenedor de la cuenta
            Container(
              margin: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.04,
                  vertical: screenHeight * 0.02),
              padding: EdgeInsets.all(screenWidth * 0.04),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 4.0,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Cuenta de ahorros',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize:
                          screenWidth * 0.05, // Ajusta el tamaño del texto
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Text(
                    'Número de cuenta: $numero',
                    style: TextStyle(
                        color: Colors.white, fontSize: screenWidth * 0.04),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Text(
                    'Saldo: \$$saldo',
                    style: TextStyle(
                        color: Colors.white, fontSize: screenWidth * 0.04),
                  ),
                ],
              ),
            ),
            // Slider con cajas
            Container(
              height: screenHeight *
                  0.25, // Ajusta la altura del slider en proporción a la pantalla
              padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildSliderItem(
                      Icons.payment, 'Transferir dinero', screenWidth),
                  _buildSliderItem(
                      Icons.payment, 'Pagar servicios', screenWidth),
                  _buildSliderItem(Icons.replay, 'Recargas', screenWidth),
                  _buildSliderItem(
                      Icons.credit_card, 'Pagar tarjetas', screenWidth),
                  _buildSliderItem(
                      Icons.more_horiz, 'Otros servicios', screenWidth),
                  _buildSliderItem(Icons.info, 'Más opciones', screenWidth),
                ],
              ),
            ),
            // Sección de consumos
            Container(
              height: screenHeight *
                  0.4, // Ajusta el alto del slider en proporción a la pantalla
              padding: EdgeInsets.all(screenWidth * 0.04),
              child: ListView(
                children: List.generate(8, (index) {
                  return Card(
                    margin: EdgeInsets.only(bottom: screenHeight * 0.01),
                    child: ListTile(
                      leading: Icon(Icons.shopping_cart),
                      title: Text('Consumo $index'),
                      subtitle: Text('Fecha: 25/07/2024'),
                      trailing: Text('\$-40.00'),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Método para construir los elementos del slider
  Widget _buildSliderItem(IconData icon, String text, double screenWidth) {
    return Container(
      width: screenWidth *
          0.25, // Ajusta el ancho del item en proporción a la pantalla
      padding: EdgeInsets.all(screenWidth * 0.02),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon,
              size: screenWidth * 0.1,
              color: Colors.blue), // Ajusta el tamaño del icono
          SizedBox(height: screenWidth * 0.02),
          Text(
            text,
            textAlign: TextAlign.center,
            overflow:
                TextOverflow.ellipsis, // Maneja el desbordamiento del texto
          ),
        ],
      ),
    );
  }
}
