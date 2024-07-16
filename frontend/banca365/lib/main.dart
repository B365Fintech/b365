import 'package:banca365/screens/begin_user.dart';
import 'package:flutter/material.dart';
import 'screens/slider_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/identity_validation_screen.dart';
import 'screens/personal_data_screen.dart';
import 'screens/work_screen.dart';
import 'screens/tax_screen.dart';
import 'screens/terms_screen.dart';
import 'screens/confirmation_screen.dart';
import 'screens/success_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => SliderScreen(),
        '/begin': (context) => BeginLogin(),
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/identity_validation': (context) => IdentityValidationScreen(),
        '/personal_data': (context) => PersonalDataScreen(),
        '/work': (context) => WorkScreen(),
        '/tax': (context) => TaxScreen(),
        '/terms': (context) => TermsScreen(),
        '/confirmation': (context) => ConfirmationScreen(),
        '/success': (context) => SuccessScreen(),
      },
    );
  }
}
