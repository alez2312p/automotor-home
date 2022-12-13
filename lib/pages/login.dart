import 'dart:convert';
import 'dart:core';

import 'package:a/pages/form.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();

  late String _username;
  late String _password;

  bool isLoading = false;
  bool contrasenaVisible = true;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.blue,
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 100, horizontal: 20),
          width: size.width * 1,
          height: size.height * 0.60,
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black, width: 2),
              borderRadius: const BorderRadius.all(Radius.circular(15))),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image.asset('assets/escudo.png', width: size.width * 0.25),
                  const SizedBox(width: 50.0),
                  Image.asset('assets/logo1.png', width: size.width * 0.5),
                ],
              ),
              const Text(
                'Control Patios',
                style: TextStyle(
                    fontSize: 28.0,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                      key: _formKey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: Column(
                        children: [
                          TextFormField(
                            autocorrect: false,
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
                              labelText: 'Ingrese número de documento',
                              hintText: 'Número de documento',
                              prefixIcon: Icon(Icons.account_circle_rounded),
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Por favor ingrese su nombre';
                              }
                              return null;
                            },
                            onSaved: (value) => _username = value!,
                          ),
                          const SizedBox(height: 20.0),
                          TextFormField(
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: contrasenaVisible,
                            decoration: InputDecoration(
                                labelText: 'Ingrese la contraseña',
                                hintText: 'Contraseña',
                                prefixIcon: const Icon(Icons.password_rounded),
                                border: const OutlineInputBorder(),
                                suffixIcon: IconButton(
                                  icon: Icon(contrasenaVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                  onPressed: () {
                                    setState(() {
                                      contrasenaVisible = !contrasenaVisible;
                                    });
                                  },
                                )),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Por favor ingrese su clave';
                              }
                              return null;
                            },
                            onSaved: (value) => _password = value!,
                          ),
                          const SizedBox(height: 20.0),
                          MaterialButton(
                              minWidth: double.infinity,
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                  final response = await http.post(
                                    Uri.parse(
                                        'http://172.16.9.233/automotor-home/login.php'),
                                    body: {
                                      'username': _username,
                                      'password': _password,
                                    },
                                  );
                                  final responseData = json.decode(json.encode(response.body));
                                      print('Valor del responseData antes del if ' + responseData);
                                  if (responseData == 'success') {
                                    print('Valor en el if ' + responseData);
                                    Navigator.pushReplacementNamed(
                                        context, 'form');
                                  } else {
                                    print('Valor en el else ' + responseData);
                                    print('No se inició sesión');
                                  }
                                }
                              },
                              color: Colors.blue,
                              textColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              //Remove?
                              child: Container(
                                margin: const EdgeInsets.all(15),
                                child: const Text(
                                  'Ingresar',
                                  style: TextStyle(
                                    fontSize: 20.0,
                                  ),
                                ),
                              )),
                          const SizedBox(height: 20.8),
                        ],
                      )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
