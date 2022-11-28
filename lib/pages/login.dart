import 'dart:convert';
import 'dart:core';

import 'package:a/pages/form.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController id = TextEditingController();
  TextEditingController pass1 = TextEditingController();

  Future _login() async {
    var url = Uri.http("10.1.1.16", '../login.php', {'q': '{http}'});
    
    var response = await http.post(url, body: {
      "id": id.toString(),
      "password": pass1.toString(),
    });
    var data = jsonDecode(response.body);
    if (data != null) {
      print("Login...");
    } else {
      print("No login...");
    }
  }

  bool isLoading = false;
  bool contrasenaVisible = true;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.blue,
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 100, horizontal: 20),
          width: size.width * 1,
          height: size.height * 0.67,
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
                            controller: id,
                            autocorrect: false,
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
                              labelText: 'Ingrese número de documento',
                              hintText: 'Número de documento',
                              prefixIcon: Icon(Icons.account_circle_rounded),
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          TextFormField(
                            controller: pass1,
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
                          ),
                          const SizedBox(height: 20.0),
                          MaterialButton(
                              minWidth: double.infinity,
                              onPressed: () {
                                _login();
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
                          const SizedBox(height: 10.8),
                          TextButton(
                              onPressed: () {},
                              child: const Text(
                                'Recuperar contraseña',
                                style: TextStyle(fontSize: 20),
                              ))
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
