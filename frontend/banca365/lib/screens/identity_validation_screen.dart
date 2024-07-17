import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class IdentityValidationScreen extends StatefulWidget {
  @override
  _IdentityValidationScreenState createState() =>
      _IdentityValidationScreenState();
}

class _IdentityValidationScreenState extends State<IdentityValidationScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  bool _isCameraInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;

    _controller = CameraController(
      firstCamera,
      ResolutionPreset.high,
    );

    _initializeControllerFuture = _controller.initialize();
    await _initializeControllerFuture;

    setState(() {
      _isCameraInitialized = true;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _takePicture() async {
    try {
      await _initializeControllerFuture;
      await _controller.takePicture();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Foto tomada')),
      );
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al tomar la foto')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Obtener el tamaño de la pantalla
    final size = MediaQuery.of(context).size;
    final double textScaleFactor = size.width * 0.005;

    return Scaffold(
      appBar: AppBar(
        title: Text('Validación de Identidad',
            style: TextStyle(fontSize: 10 * textScaleFactor)),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: size.height * 0.02),
            Text(
              'Validación de Identidad',
              style: TextStyle(
                  fontSize: 8 * textScaleFactor, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.02),
            Container(
              margin: EdgeInsets.symmetric(horizontal: size.width * 0.05),
              child: Stack(
                children: [
                  SizedBox(
                    height: size.height * 0.5,
                    width: size.width,
                    child: _isCameraInitialized
                        ? CameraPreview(_controller)
                        : Center(child: CircularProgressIndicator()),
                  ),
                  Positioned(
                    left: size.width * 0.22,
                    top: size.height * 0.10,
                    child: Container(
                      width: size.width * 0.5,
                      height: size.height * 0.3,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.red, width: 2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          'Alinea tu cara aquí',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 5 * textScaleFactor),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: size.height * 0.02),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
              child: ElevatedButton(
                onPressed: _takePicture,
                child: SizedBox(
                  width: double.infinity,
                  height: size.height * 0.06,
                  child: Center(
                      child: Text('Tomar Foto',
                          style: TextStyle(fontSize: 5 * textScaleFactor))),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
            SizedBox(height: size.height * 0.02),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/personal_data');
                },
                child: SizedBox(
                  width: double.infinity,
                  height: size.height * 0.06,
                  child: Center(
                      child: Text('Validar',
                          style: TextStyle(fontSize: 5 * textScaleFactor))),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}






/*import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class IdentityValidationScreen extends StatefulWidget {
  @override
  _IdentityValidationScreenState createState() =>
      _IdentityValidationScreenState();
}

class _IdentityValidationScreenState extends State<IdentityValidationScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  bool _isCameraInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;

    _controller = CameraController(
      firstCamera,
      ResolutionPreset.high,
    );

    _initializeControllerFuture = _controller.initialize();
    await _initializeControllerFuture;

    setState(() {
      _isCameraInitialized = true;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _takePicture() async {
    try {
      await _initializeControllerFuture;

      await _controller.takePicture();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Foto tomada')),
      );
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al tomar la foto')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Validación de Identidad'),
      ),
      body: Column(
        children: [
          Expanded(
            child: _isCameraInitialized
                ? CameraPreview(_controller)
                : Center(child: CircularProgressIndicator()),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: _takePicture,
              child: Text('Tomar Foto'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: IdentityValidationScreen(),
    );
  }
}


*/