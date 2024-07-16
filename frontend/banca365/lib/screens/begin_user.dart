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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inicio de Sesión'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/logo.gif',
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
}
