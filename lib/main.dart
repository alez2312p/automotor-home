import 'package:automotor/pages/login.dart';
import 'package:flutter/material.dart';

import 'package:automotor/pages/form.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Automotor',
      initialRoute: 'login',
      routes: {
        'login' : (_) => const Login(),
        'form' : (_) => const FormPage(),
      },
    );
  }
}
