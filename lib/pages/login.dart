import 'package:a/pages/form.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String _nombre = '';
  String _contrasena = '';
  bool isLoading = false;
  bool contrasenaVisible = true;

  final myController = TextEditingController();
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  void _onFormSubmit() {
    final form = _formKey.currentState;
    if(form!.validate()){
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const FormPage(),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ListView(
          padding: const EdgeInsets.all(8.0),
          children: [
            Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 150,
                          width: 150,
                          child: Row(children: [
                            SizedBox(

                              height: 60.0,
                              child: Image.asset('assets/logo1.png'),
                            )
                          ])),
                      SizedBox(
                          width: 150,
                          child: Row(children: [
                            SizedBox(
                              height: 40.0,
                              child: Image.asset('assets/escudo.png'),
                            )
                          ])),
                    ],
                  ),
                  const Text(
                  'Iniciar sesión',
                  style: TextStyle(
                    fontSize: 32.0,
                    color: Colors.orange,
                    fontWeight: FontWeight.bold
                  ),
                ),
                  Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30.0),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Form(
                        child: Column(
                          children: [
                            TextFormField(
                              controller: myController,
                              keyboardType: TextInputType.text,
                              decoration: const InputDecoration(
                                labelText: 'Usuario',
                                hintText: 'Ingrese su usuario',
                                prefixIcon: Icon(Icons.account_circle_rounded),
                                border: OutlineInputBorder(),
                              ),
                              onChanged: (valor) => setState(() {
                                _nombre = valor;
                              }),
                              validator: (value) {
                                if(value?.length == 0) {
                                  return 'Usuario no ingresado';
                                }else if(value != 'admin') {
                                  return 'Usuario incorrecto';
                                }else {
                                  return null;
                                }
                              },
                            ),
                            const SizedBox(height: 30.0),
                            TextFormField(
                              controller: myController,
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: contrasenaVisible,
                              decoration: InputDecoration(
                                labelText: 'Contraseña',
                                hintText: 'Ingrese su contraseña',
                                prefixIcon: const Icon(Icons.password_rounded),
                                border: const OutlineInputBorder(),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    contrasenaVisible ? Icons.visibility : Icons.visibility_off
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      contrasenaVisible = !contrasenaVisible;
                                    });
                                  },
                                )
                              ),
                              onChanged: (value){
                                _contrasena = value;
                              },
                              validator: (value) {
                                if(value != '1234') {
                                  print(_contrasena);
                                  return 'Contraseña incorrecta';
                                }
                              },
                            ),
                            const SizedBox(height: 30.0),
                            MaterialButton(
                              minWidth: double.infinity,
                              onPressed: _onFormSubmit,
                              color: Colors.orange,
                              textColor: Colors.white,
                              child: const Text('Iniciar sesión',
                              style: TextStyle(
                                fontSize: 20.0,
                              ),),
                            )
                          ],
                        )
                    ),
                  ),
                )
                ],
              ),
            ),
          ]
        ),
      )
    );
  }
}