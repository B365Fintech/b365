import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:image/image.dart' as img;

class IdentityValidationScreen extends StatefulWidget {
  @override
  _IdentityValidationScreenState createState() =>
      _IdentityValidationScreenState();
}

class _IdentityValidationScreenState extends State<IdentityValidationScreen> {
  CameraController? _controller;
  Future<void>? _initializeControllerFuture;
  String? cedula;
  String? codigoDactilar;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      final args =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      setState(() {
        cedula = args['cedula'];
        codigoDactilar = args['codigoDactilar'];
      });
      print('Cédula: $cedula');
      print('Código Dactilar: $codigoDactilar');
      _initializeCamera();
    });
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;

    _controller = CameraController(
      firstCamera,
      ResolutionPreset.high,
    );

    _initializeControllerFuture = _controller!.initialize();
    if (!mounted) return;
    setState(() {});
  }

  Future<String> _convertImageToBase64(XFile imageFile) async {
    final bytes = await imageFile.readAsBytes();
    final img.Image image = img.decodeImage(Uint8List.fromList(bytes))!;
    final List<int> pngBytes = img.encodePng(image);
    return base64Encode(pngBytes);
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Validación de Identidad'),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
                height:
                    size.height * 0.07), // Espacio entre la AppBar y la cámara
            Container(
              height: size.height * 0.6, // Ajusta la altura de la cámara
              child: FutureBuilder<void>(
                future: _initializeControllerFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return CameraPreview(_controller!);
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
            SizedBox(
                height:
                    size.height * 0.1), // Espacio entre la cámara y el botón
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.1), // Ajusta el padding horizontal
              child: ElevatedButton(
                onPressed: () async {
                  try {
                    await _initializeControllerFuture;
                    final XFile image = await _controller!.takePicture();
                    final base64Image = await _convertImageToBase64(image);
                    print('Foto tomada con éxito: ${image.path}');
                    print('Imagen en Base64: $base64Image');

                    Navigator.pushNamed(
                      context,
                      '/personal_data',
                      arguments: {
                        'cedula': cedula,
                        'codigoDactilar': codigoDactilar,
                        'fotoBase64': base64Image,
                      },
                    );
                  } catch (e) {
                    print('Error al tomar la foto: $e');
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Fondo azul
                  foregroundColor: Colors.white, // Texto blanco
                  minimumSize:
                      Size(double.infinity, 50), // Ancho completo y altura fija
                ),
                child: Text('Tomar Foto'),
              ),
            ),
            SizedBox(
                height: 20), // Añadido un pequeño espacio adicional al final
          ],
        ),
      ),
    );
  }
}













/*import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:image/image.dart' as img;

class IdentityValidationScreen extends StatefulWidget {
  @override
  _IdentityValidationScreenState createState() =>
      _IdentityValidationScreenState();
}

class _IdentityValidationScreenState extends State<IdentityValidationScreen> {
  CameraController? _controller;
  Future<void>? _initializeControllerFuture;
  String? cedula;
  String? codigoDactilar;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      final args =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      setState(() {
        cedula = args['cedula'];
        codigoDactilar = args['codigoDactilar'];
      });
      print('Cédula: $cedula');
      print('Código Dactilar: $codigoDactilar');
      _initializeCamera();
    });
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;

    _controller = CameraController(
      firstCamera,
      ResolutionPreset.high,
    );

    _initializeControllerFuture = _controller!.initialize();
    if (!mounted) return;
    setState(() {});
  }

  Future<String> _convertImageToBase64(XFile imageFile) async {
    final bytes = await imageFile.readAsBytes();
    final img.Image image = img.decodeImage(Uint8List.fromList(bytes))!;
    final List<int> pngBytes = img.encodePng(image);
    return base64Encode(pngBytes);
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Validación de Identidad'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: FutureBuilder<void>(
              future: _initializeControllerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return CameraPreview(_controller!);
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              try {
                await _initializeControllerFuture;
                final XFile image = await _controller!.takePicture();
                final base64Image = await _convertImageToBase64(image);
                print('Foto tomada con éxito: ${image.path}');
                print('Imagen en Base64: $base64Image');

                Navigator.pushNamed(
                  context,
                  '/personal_data',
                  arguments: {
                    'cedula': cedula,
                    'codigoDactilar': codigoDactilar,
                    'fotoBase64': base64Image,
                  },
                );
              } catch (e) {
                print('Error al tomar la foto: $e');
              }
            },
            child: Text('Tomar Foto'),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/personal_data');
            },
            child: Text('Siguiente'),
          ),
        ],
      ),
    );
  }
}*/


















