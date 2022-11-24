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
      "id": id.text,
      "password": pass1.text,
    });
    var data = json.decode(response.body);
    if (data.toString() == "success") {
      Fluttertoast.showToast(
        msg: 'Login Successful',
        backgroundColor: Colors.green,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_SHORT,
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FormPage(),
        ),
      );
    } else {
      Fluttertoast.showToast(
        msg: 'id or password invalid',
        backgroundColor: Colors.red,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_SHORT
        );
    }
  }

  bool isLoading = false;
  bool contrasenaVisible = true;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 100, horizontal: 20),
        width: 500,
        height: 525.1,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black, width: 2),
            borderRadius: const BorderRadius.all(Radius.circular(15))),
        child: Column(
          children: [
            Row(
              children: [
                Image.asset('assets/escudo.png', width: 100),
                const SizedBox(width: 50.0),
                Image.asset('assets/logo1.png', width: 250),
              ],
            ),
            const Text(
              'Control Patios',
              style: TextStyle(
                  fontSize: 32.0,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30.0),
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
                        const SizedBox(height: 30.0),
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
                        const SizedBox(height: 30.0),
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
                        const SizedBox(height: 6.8),
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
    );
  }
}
