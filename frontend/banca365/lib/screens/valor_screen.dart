import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
//import 'package:flutter/scheduler.dart';

class ValorScreen extends StatefulWidget {
  const ValorScreen({super.key});

  @override
  _ValorScreenState createState() => _ValorScreenState();
}

class _ValorScreenState extends State<ValorScreen> {
  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    // Obtener el tamaño de la pantalla
    //final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bank365'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              // Agrega la lógica para cerrar sesión aquí
              _closeSession();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.01),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Hola Juan',
                style: TextStyle(fontSize: 24.0),
              ),
              const SizedBox(height: 16.0),
              Card(
                color: Colors.blue[800],
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'CUENTA DE AHORROS',
                        style: TextStyle(color: Colors.white, fontSize: 27.0),
                      ),
                      const SizedBox(height: 8.0),
                      const Text(
                        'N° 1234567890',
                        style: TextStyle(color: Colors.white, fontSize: 24.0),
                      ),
                      const SizedBox(height: 16.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            '\$',
                            style:
                                TextStyle(color: Colors.white, fontSize: 24.0),
                          ),
                          _showPassword
                              ? const Text(
                                  '1000.00',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 24.0),
                                )
                              : const Text(
                                  '*.*',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 24.0),
                                ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _showPassword = !_showPassword;
                              });
                            },
                            child: Icon(
                              _showPassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.white,
                              size: 24.0,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16.0),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildServiceIcon(Icons.send, 'Transferir'),
                  _buildServiceIcon(Icons.payment, 'Pagar'),
                  _buildServiceIcon(Icons.add_circle, 'Recargar'),
                  _buildServiceIcon(Icons.more_horiz, 'Más Servicios'),
                ],
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Actividad Reciente',
                style: TextStyle(fontSize: 24.0),
              ),
              // Aquí puedes agregar la lista de actividad reciente
              const Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(height: 16.0), // Espacio entre filas
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.local_grocery_store),
                          SizedBox(width: 8.0),
                          Text('Compras', style: TextStyle(fontSize: 18.0)),
                        ],
                      ),
                      Text('-\$500.00', style: TextStyle(fontSize: 18.0)),
                    ],
                  ),
                  SizedBox(height: 16.0), // Espacio entre filas
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.fastfood),
                          SizedBox(width: 8.0),
                          Text('Comida', style: TextStyle(fontSize: 18.0)),
                        ],
                      ),
                      Text('-\$150.00', style: TextStyle(fontSize: 18.0)),
                    ],
                  ),
                  SizedBox(height: 16.0), // Espacio entre filas
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.fastfood),
                          SizedBox(width: 8.0),
                          Text('Comida', style: TextStyle(fontSize: 18.0)),
                        ],
                      ),
                      Text('-\$50.00', style: TextStyle(fontSize: 18.0)),
                    ],
                  ),
                  SizedBox(height: 16.0), // Espacio entre filas
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.local_airport),
                          SizedBox(width: 8.0),
                          Text('Viaje', style: TextStyle(fontSize: 18.0)),
                        ],
                      ),
                      Text('-\$500.00', style: TextStyle(fontSize: 18.0)),
                    ],
                  ),
                  SizedBox(height: 16.0), // Espacio entre filas
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.local_airport),
                          SizedBox(width: 8.0),
                          Text('Viaje', style: TextStyle(fontSize: 18.0)),
                        ],
                      ),
                      Text('-\$500.00', style: TextStyle(fontSize: 18.0)),
                    ],
                  ),
                  SizedBox(height: 16.0), // Espacio entre filas
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.local_airport),
                          SizedBox(width: 8.0),
                          Text('Viaje', style: TextStyle(fontSize: 18.0)),
                        ],
                      ),
                      Text('-\$500.00', style: TextStyle(fontSize: 18.0)),
                    ],
                  ),
                  SizedBox(height: 16.0), // Espacio entre filas
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.local_airport),
                          SizedBox(width: 8.0),
                          Text('Viaje', style: TextStyle(fontSize: 18.0)),
                        ],
                      ),
                      Text('-\$500.00', style: TextStyle(fontSize: 18.0)),
                    ],
                  ),
                  SizedBox(height: 16.0), // Espacio entre filas
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.local_airport),
                          SizedBox(width: 8.0),
                          Text('Viaje', style: TextStyle(fontSize: 18.0)),
                        ],
                      ),
                      Text('-\$500.00', style: TextStyle(fontSize: 18.0)),
                    ],
                  ),
                  SizedBox(height: 16.0), // Espacio entre filas
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.local_airport),
                          SizedBox(width: 8.0),
                          Text('Viaje', style: TextStyle(fontSize: 18.0)),
                        ],
                      ),
                      Text('-\$500.00', style: TextStyle(fontSize: 18.0)),
                    ],
                  ),
                  SizedBox(height: 16.0), // Espacio entre filas
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.local_airport),
                          SizedBox(width: 8.0),
                          Text('Viaje', style: TextStyle(fontSize: 18.0)),
                        ],
                      ),
                      Text('-\$500.00', style: TextStyle(fontSize: 18.0)),
                    ],
                  ),
                  SizedBox(height: 16.0), // Espacio entre filas
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.local_airport),
                          SizedBox(width: 8.0),
                          Text('Viaje', style: TextStyle(fontSize: 18.0)),
                        ],
                      ),
                      Text('-\$500.00', style: TextStyle(fontSize: 18.0)),
                    ],
                  ),
                  SizedBox(height: 16.0), // Espacio entre filas
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.logout),
                          SizedBox(width: 8.0),
                          Text('Viaje', style: TextStyle(fontSize: 18.0)),
                        ],
                      ),
                      Text('-\$500.00', style: TextStyle(fontSize: 18.0)),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildServiceIcon(IconData icon, String label) {
    return Column(
      children: [
        Icon(icon),
        const SizedBox(height: 8.0),
        Text(label),
      ],
    );
  }

  void _closeSession() {
    // Eliminar datos de sesión del usuario
    _removeUserSessionData();

    // Redirigir a la pantalla de inicio de sesión
    Navigator.pushReplacementNamed(context, '/login');
  }

  void _removeUserSessionData() {
    // Aquí debes implementar la lógica para eliminar los datos de sesión del usuario
    // Por ejemplo, borrar el token de autenticación guardado localmente
  }
}
