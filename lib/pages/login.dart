import 'dart:core';

import 'package:automotor/pages/form.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isLoading = false;
  bool contrasenaVisible = true;

  Future<void> login() async {
    if (usernameController.text.isEmpty || passwordController.text.isEmpty) {
      Fluttertoast.showToast(
        msg: 'Ingrese sus credenciales',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        fontSize: 15,
      );
    } else {
      String username = usernameController.text;
      String password = passwordController.text;

      var url = "http://192.168.1.13/automotor-home/login.php";

      var response = await http.post(Uri.parse(url), body: {
        "username": username,
        "password": password,
      });
      var data = response.body;
      if (data == "Connected successfully success") {
        Navigator.push(context, MaterialPageRoute(builder: (context)=> FormPage()));
      } else {
        Fluttertoast.showToast(
          msg: 'credenciales invalidas',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.white,
          textColor: Colors.red,
          fontSize: 15,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.blue,
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 300, horizontal: 20),
          width: size.width * 1,
          height: size.height * 0.40,
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
                          TextField(
                              controller: usernameController,
                              autocorrect: false,
                              keyboardType: TextInputType.text,
                              decoration: const InputDecoration(
                                labelText: 'Ingrese número de documento',
                                hintText: 'Número de documento',
                                prefixIcon: Icon(Icons.account_circle_rounded),
                                border: OutlineInputBorder(),
                              )),
                          const SizedBox(height: 20.0),
                          TextField(
                              controller: passwordController,
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: contrasenaVisible,
                              decoration: InputDecoration(
                                  labelText: 'Ingrese la contraseña',
                                  hintText: 'Contraseña',
                                  prefixIcon:
                                      const Icon(Icons.password_rounded),
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
                                  ))),
                          const SizedBox(height: 20.0),
                          MaterialButton(
                              minWidth: double.infinity,
                              onPressed: () {
                                login();
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
