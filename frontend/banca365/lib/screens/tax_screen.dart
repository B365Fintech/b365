import 'package:flutter/material.dart';

class TaxScreen extends StatefulWidget {
  @override
  _TaxScreenState createState() => _TaxScreenState();
}

class _TaxScreenState extends State<TaxScreen> {
  bool _isEcuadorChecked = false;
  bool _isOtherCountriesChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Impuestos')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 26),
            const Text('¿Dónde pagas tus impuestos?',
                style: TextStyle(fontSize: 24)),
            const SizedBox(height: 8),
            const Text('Elige el país donde pagas tus impuestos',
                style: TextStyle(fontSize: 16)),
            const SizedBox(height: 66),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Column(
                children: [
                  CheckboxListTile(
                    title: const Text('Ecuador'),
                    value: _isEcuadorChecked,
                    onChanged: (newValue) {
                      setState(() {
                        _isEcuadorChecked = newValue ?? false;
                      });
                    },
                  ),
                  const SizedBox(height: 66),
                  CheckboxListTile(
                    title: const Text('Otros Países'),
                    value: _isOtherCountriesChecked,
                    onChanged: (newValue) {
                      setState(() {
                        _isOtherCountriesChecked = newValue ?? false;
                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 116),
            Image.asset('assets/images/pais.png'),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/terms');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 146, vertical: 15),
              ),
              child: const Text('Continuar'),
            ),
          ],
        ),
      ),
    );
  }
}
