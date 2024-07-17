import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

class BeginLogin extends StatefulWidget {
  const BeginLogin({super.key});

  @override
  _BeginLoginState createState() => _BeginLoginState();
}

class _BeginLoginState extends State<BeginLogin> {
  final LocalAuthentication _localAuth = LocalAuthentication();
  bool _isBiometricAvailable = false;

  @override
  void initState() {
    super.initState();
    _checkBiometrics();
  }

  Future<void> _checkBiometrics() async {
    try {
      bool canCheckBiometrics = await _localAuth.canCheckBiometrics;
      List<BiometricType> availableBiometrics =
          await _localAuth.getAvailableBiometrics();

      print("Can check biometrics: $canCheckBiometrics");
      print("Available biometrics: $availableBiometrics");

      setState(() {
        _isBiometricAvailable = canCheckBiometrics &&
            (availableBiometrics.contains(BiometricType.fingerprint) ||
                availableBiometrics.contains(BiometricType.weak) ||
                availableBiometrics.contains(BiometricType.strong));
      });
    } catch (e) {
      print("Error al verificar biometría: $e");
      setState(() {
        _isBiometricAvailable = false;
      });
    }
  }

  Future<void> _authenticate() async {
    if (!_isBiometricAvailable) return;

    try {
      bool didAuthenticate = await _localAuth.authenticate(
        localizedReason: 'Coloque su huella',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
      if (didAuthenticate) {
        Navigator.pushNamed(context, '/success');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Autenticación fallida')),
        );
      }
    } catch (e) {
      print("Error en la autenticación: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error en la autenticación')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Obtener el tamaño de la pantalla
    final size = MediaQuery.of(context).size;
    final double buttonHeight = size.height * 0.25;
    final double buttonWidth = size.width * 0.4;
    final double iconSize = size.width * 0.08;
    final double fontSize = size.width * 0.03;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Inicio de Sesión'),
      ),
      body: Container(
        color: Colors.blue, // Fondo azul
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(size.width * 0.04),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Bienvenidos',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Image.asset(
                    'assets/images/logoanimado.gif',
                    width: size.width * 0.6,
                    height: size.width * 0.6,
                  ),
                  SizedBox(height: size.height * 0.05),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: _isBiometricAvailable ? _authenticate : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          minimumSize: Size(buttonWidth, buttonHeight),
                          padding: EdgeInsets.symmetric(
                            horizontal: size.width * 0.05,
                            vertical: size.height * 0.02,
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              'Huella Dactilar',
                              style: TextStyle(fontSize: fontSize),
                            ),
                            Icon(
                              Icons.fingerprint,
                              color: Colors.blue,
                              size: iconSize,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: size.width * 0.05),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/login');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          minimumSize: Size(buttonWidth, buttonHeight),
                          padding: EdgeInsets.symmetric(
                            horizontal: size.width * 0.05,
                            vertical: size.height * 0.02,
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              'Usuario o Correo',
                              style: TextStyle(fontSize: fontSize),
                            ),
                            Icon(
                              Icons.person,
                              color: Colors.blue,
                              size: iconSize,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: size.height * 0.02),
                  Text(
                    'No tienes una cuenta?',
                    style: TextStyle(fontSize: fontSize, color: Colors.white),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/register');
                    },
                    child: Text(
                      'Crear cuenta',
                      style: TextStyle(fontSize: fontSize, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
























/*import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

class BeginLogin extends StatefulWidget {
  const BeginLogin({super.key});

  @override
  _BeginLoginState createState() => _BeginLoginState();
}

class _BeginLoginState extends State<BeginLogin> {
  final LocalAuthentication _localAuth = LocalAuthentication();
  bool _isBiometricAvailable = false;

  @override
  void initState() {
    super.initState();
    _checkBiometrics();
  }

  Future<void> _checkBiometrics() async {
    try {
      bool canCheckBiometrics = await _localAuth.canCheckBiometrics;
      List<BiometricType> availableBiometrics =
          await _localAuth.getAvailableBiometrics();

      print("Can check biometrics: $canCheckBiometrics");
      print("Available biometrics: $availableBiometrics");

      setState(() {
        _isBiometricAvailable = canCheckBiometrics &&
            (availableBiometrics.contains(BiometricType.fingerprint) ||
                availableBiometrics.contains(BiometricType.weak) ||
                availableBiometrics.contains(BiometricType.strong));
      });
    } catch (e) {
      print("Error al verificar biometría: $e");
      setState(() {
        _isBiometricAvailable = false;
      });
    }
  }

  Future<void> _authenticate() async {
    if (!_isBiometricAvailable) return;

    try {
      bool didAuthenticate = await _localAuth.authenticate(
        localizedReason: 'Coloque su huella',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
      if (didAuthenticate) {
        Navigator.pushNamed(context, '/success');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Autenticación fallida')),
        );
      }
    } catch (e) {
      print("Error en la autenticación: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error en la autenticación')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inicio de Sesión'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/logoanimado.gif',
            width: 250,
            height: 250,
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _isBiometricAvailable ? _authenticate : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                  minimumSize: const Size(150, 60),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Text('Huella Dactilar'),
                    const Icon(
                      Icons.fingerprint,
                      color: Colors.white,
                      size: 25.0,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                  minimumSize: const Size(150, 60),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Text('Usuario o Correo'),
                    const Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 25.0,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}*/
