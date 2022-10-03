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
                      child: Column(
                        children: [
                          TextFormField(
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
                              labelText: 'Usuario',
                              hintText: 'Ingrese su usuario',
                              prefixIcon: Icon(Icons.account_circle_rounded),
                              border: OutlineInputBorder(),
                            ),
                            onChanged: (value) => setState(() {
                              _nombre = value;
                            }),
                            validator: (value){
                              return value!.isEmpty ? 'Usuario incorrecto' : null;
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
                            onChanged: (value){
                              _contrasena = value;
                            },
                            validator: (value){
                              return value!.isEmpty ? 'Contraseña incorrecta' : null;
                            },
                          ),
                          const SizedBox(height: 30.0),
                          MaterialButton(
                            minWidth: double.infinity,
                            onPressed: (){
                              if(_nombre == 'admin'){
                                if(_contrasena == '1234'){
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => const FormPage(),
                                  ));
                                }}else{
                                print('Invalido');
                              }
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