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
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 100, horizontal: 20),
        width: 500,
        height: 525.1,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black, width: 2),
            borderRadius: BorderRadius.all(Radius.circular(15))),
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
                          autocorrect: false,
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                            labelText: 'Ingrese número de documento',
                            hintText: 'Número de documento',
                            prefixIcon: Icon(Icons.account_circle_rounded),
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (value) => user = value,
                          validator: (value) {
                            String usuario = 'admin';
                            return value != usuario
                                ? 'Número de documento incorrecto'
                                : null;
                          },
                        ),
                        const SizedBox(height: 30.0),
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
                          onChanged: (value) => pass = value,
                          validator: (value) {
                            String clave = '1234';
                            return value != clave
                                ? 'Contraseña incorrecto'
                                : null;
                          },
                        ),
                        const SizedBox(height: 30.0),
                        MaterialButton(
                            minWidth: double.infinity,
                            onPressed: () {
                              if (!isValidForm()) return;
                              Navigator.pushReplacementNamed(context, 'form');
                            },
                            color: Colors.blue,
                            textColor: Colors.white,
                            //Remove?
                            child: Container(
                              margin: EdgeInsets.all(15),
                              child: Text(
                                'Ingresar',
                                style: TextStyle(
                                  fontSize: 20.0,
                                ),
                              ),
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        const SizedBox(height: 6.8),
                        TextButton(
                            onPressed: () {},
                            child: Text(
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
