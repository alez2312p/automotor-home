import 'package:a/pages/form.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  String user = "";
  String pass = "";

  bool isLoading = false;
  bool contrasenaVisible = true;

  final myController = TextEditingController();
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  bool isValidForm() {
    print(_formKey.currentState?.validate());
    return _formKey.currentState?.validate() ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Iniciar sesión'),
        ),
        body: ListView(
          padding: const EdgeInsets.all(8.0),
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
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
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: Column(
                        children: [
                          TextFormField(
                            autocorrect: false,
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
                              labelText: 'Usuario',
                              hintText: 'Ingrese su usuario',
                              prefixIcon: Icon(Icons.account_circle_rounded),
                              border: OutlineInputBorder(),
                            ),
                            onChanged: (value) => user = value,
                            validator: (value){
                              String usuario = 'admin';
                              return value != usuario ? 'Usuario incorrecto' : null;
                            },
                          ),
                          const SizedBox(height: 30.0),
                          TextFormField(
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
                            onChanged: (value) => pass = value,
                            validator: (value){
                              String clave = '1234';
                              return value != clave ? 'Contraseña incorrecto' : null;
                            },
                          ),
                          const SizedBox(height: 30.0),
                          MaterialButton(
                            minWidth: double.infinity,
                            onPressed: (){
                              if(!isValidForm()) return;
                              Navigator.pushReplacementNamed(context, 'form');
                            },
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
          ]
        ),
      )
    );
  }
}