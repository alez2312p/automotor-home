import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:image_picker/image_picker.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  String? texto = 'Seleccione una opción';
  String? texto1 = 'Seleccione una opción';
  String? texto2 = 'Seleccione una opción';
  String? texto3 = 'Seleccione una opción';
  String? texto4 = 'Seleccione una opción';
  String? rutaImg;

  bool isLoading = false;
  bool nameFile = false;

  ImagePicker? pickerImage;
  File? imagen;

  final _formKey = GlobalKey<FormState>();
  final _picker = ImagePicker();

  var pickedFile;

  opciones(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: EdgeInsets.all(0),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  InkWell(
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom:
                                  BorderSide(color: Colors.grey, width: 1))),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text('Tomar una foto',
                                style: TextStyle(fontSize: 16)),
                          ),
                          Icon(Icons.add_a_photo_rounded)
                        ],
                      ),
                    ),
                    onTap: (){
                      selectImage(1);
                    },
                  ),
                  InkWell(
                    child: Container(
                      padding: EdgeInsets.all(20),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text('Seleccionar una foto',
                                style: TextStyle(fontSize: 16)),
                          ),
                          Icon(Icons.image)
                        ],
                      ),
                    ),
                    onTap: (){
                      selectImage(2);
                    },
                  ),
                  InkWell(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                          color: Colors.red),
                      padding: EdgeInsets.all(20),
                      width: double.infinity,
                      child: Text(
                        'Cancelar',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    onTap: (){
                      Navigator.of(context).pop();
                    },
                  )
                ],
              ),
            ),
          );
        });
  }

    Future selectImage(op) async{
      if (op == 1) {
        pickedFile = await _picker.pickImage(source: ImageSource.camera);
      } else {
        pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      }
      setState(() {
        if (pickedFile != null) {
          imagen = File(pickedFile.path);
          rutaImg = imagen?.path.substring(33);
          print(imagen?.path.substring(33));
          print('Nombre del archivo $imagen');
        } else {
          print('No seleccionaste ninguna foto');
        }
      });
      Navigator.of(context).pop();
  }

  bool isValidForm() {
    return _formKey.currentState?.validate() ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: SizedBox(
              height: 500,
              width: 250,
              child: Row(children: [
                SizedBox(
                  height: 40.0,
                  child: Image.asset('assets/logo.png'),
                )
              ])),
          actions: [
            InkWell(
                child: Container(
              height: 50.0,
              padding: const EdgeInsets.all(15.0),
              margin: const EdgeInsets.all(4.5),
              decoration: const BoxDecoration(
                color: Colors.green,
              ),
              alignment: Alignment.center,
              child: const Text(
                'Nuevo Registro',
                style: TextStyle(fontSize: 20.0),
              ),
            )),
          ],
        ),
        body: ListView(
          padding: const EdgeInsets.all(8),
          children: [
            const Text(
              textAlign: TextAlign.center,
              'Ingreso nuevo automotor',
              style: TextStyle(
                fontSize: 40.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(width: 20),
            Form(
              key: _formKey,
              child: Container(
                padding: const EdgeInsets.all(10.0),
                margin: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black54,
                      width: 3,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(5))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Lugar de ingreso: ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20.0),
                        ),
                        Container(
                            width: double.maxFinite,
                            padding: const EdgeInsets.only(left: 10.0),
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(5.0)),
                                border: Border.all(
                                    color: Colors.black45, width: 1)),
                            child: DropdownButtonFormField(
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  errorBorder: InputBorder.none),
                              style: const TextStyle(
                                  fontSize: 22.0, color: Colors.black),
                              hint: Text(texto!),
                              isExpanded: true,
                              items: const [
                                DropdownMenuItem(
                                    value: 'La Estación - Kilómetro 25',
                                    child: Text('La Estación - Kilómetro 25')),
                                DropdownMenuItem(
                                    value: 'La Rinconada - Vereda Cabildo',
                                    child:
                                        Text('La Rinconada - Vereda Cabildo')),
                                DropdownMenuItem(
                                    value: 'Opción 3', child: Text('Opción 3'))
                              ],
                              onChanged: (value) {
                                setState(() {
                                  texto = value;
                                });
                              },
                              validator: (value) => value == null
                                  ? 'Por favor seleccione un lugar de ingreso'
                                  : null,
                            ))
                      ],
                    ),
                    const SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Placa automotora: ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20.0),
                        ),
                        Container(
                            height: 50.0,
                            width: double.maxFinite,
                            padding: const EdgeInsets.only(left: 10.0),
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(5.0)),
                                border: Border.all(
                                    color: Colors.black45, width: 1)),
                            child: TextFormField(
                                style: const TextStyle(fontSize: 22.0),
                                decoration: const InputDecoration(
                                    hintText: 'Ingrese una placa automotora',
                                    border: InputBorder.none,
                                    errorBorder: InputBorder.none),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Por favor ingrese una placa automotora';
                                  }
                                }))
                      ],
                    ),
                    const SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Ingrese nuevamente la placa: ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20.0),
                        ),
                        Container(
                            width: double.maxFinite,
                            padding: const EdgeInsets.only(left: 10.0),
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(5.0)),
                                border: Border.all(
                                    color: Colors.black45, width: 1)),
                            child: TextFormField(
                                style: const TextStyle(fontSize: 22.0),
                                decoration: const InputDecoration(
                                    hintText:
                                        'Ingrese nuevamente la placa del automotor',
                                    border: InputBorder.none,
                                    errorBorder: InputBorder.none),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Por favor ingrese una placa automotora';
                                  }
                                }))
                      ],
                    ),
                    const SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '¿Ingresa por accidente?: ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20.0),
                        ),
                        Container(
                            width: double.maxFinite,
                            padding: const EdgeInsets.only(left: 10.0),
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(5.0)),
                                border: Border.all(
                                    color: Colors.black45, width: 1)),
                            child: DropdownButtonFormField(
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  errorBorder: InputBorder.none),
                              style: const TextStyle(
                                  fontSize: 22.0, color: Colors.black),
                              hint: Text(texto1!),
                              isExpanded: true,
                              items: const [
                                DropdownMenuItem(
                                    value: 'Sí', child: Text('Sí')),
                                DropdownMenuItem(
                                    value: 'No', child: Text('No')),
                              ],
                              onChanged: (valor) {
                                setState(() {
                                  texto1 = valor;
                                });
                              },
                              validator: (value) => value == null
                                  ? 'Por favor seleccione una opción'
                                  : null,
                            ))
                      ],
                    ),
                    const SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Tipo automotor: ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20.0),
                        ),
                        Container(
                            width: double.maxFinite,
                            padding: const EdgeInsets.only(left: 10.0),
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(5.0)),
                                border: Border.all(
                                    color: Colors.black45, width: 1)),
                            child: DropdownButtonFormField(
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  errorBorder: InputBorder.none),
                              style: const TextStyle(
                                  fontSize: 22.0, color: Colors.black),
                              hint: Text(texto2!),
                              isExpanded: true,
                              items: const [
                                DropdownMenuItem(
                                    value: 'Moto', child: Text('Moto')),
                                DropdownMenuItem(
                                    value: 'Vehículo', child: Text('Vehículo')),
                                DropdownMenuItem(
                                    value: 'Camión', child: Text('Camión')),
                                DropdownMenuItem(
                                    value: 'Volqueta', child: Text('Volqueta')),
                                DropdownMenuItem(
                                    value: 'Tractocamión',
                                    child: Text('Tractocamión')),
                                DropdownMenuItem(
                                    value: 'Bus',
                                    child: Text(
                                      'Bus',
                                    )),
                                DropdownMenuItem(
                                    value: 'Microbus', child: Text('Microbus')),
                              ],
                              onChanged: (valor) {
                                setState(() {
                                  texto2 = valor;
                                });
                              },
                              validator: (value) => value == null
                                  ? 'Por favor seleccione un tipo de automotor'
                                  : null,
                            ))
                      ],
                    ),
                    const SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Tipo servicio: ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20.0),
                        ),
                        Container(
                            width: double.maxFinite,
                            padding: const EdgeInsets.only(left: 10.0),
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(5.0)),
                                border: Border.all(
                                    color: Colors.black45, width: 1)),
                            child: DropdownButtonFormField(
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  errorBorder: InputBorder.none),
                              style: const TextStyle(
                                  fontSize: 22.0, color: Colors.black),
                              hint: Text(texto1!),
                              isExpanded: true,
                              items: const [
                                DropdownMenuItem(
                                    value: 'Particular',
                                    child: Text('Particular')),
                                DropdownMenuItem(
                                    value: 'Público', child: Text('Público')),
                                DropdownMenuItem(
                                    value: 'otro', child: Text('Otro')),
                              ],
                              onChanged: (valor) {
                                setState(() {
                                  texto1 = valor;
                                });
                              },
                              validator: (value) => value == null
                                  ? 'Por favor seleccione un tipo de servicio'
                                  : null,
                            ))
                      ],
                    ),
                    const SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Marca: ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20.0),
                        ),
                        Container(
                            width: double.maxFinite,
                            padding: const EdgeInsets.only(left: 10.0),
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(5.0)),
                                border: Border.all(
                                    color: Colors.black45, width: 1)),
                            child: TextFormField(
                                style: const TextStyle(fontSize: 22.0),
                                decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Ingrese la marca del automotor'),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Por favor ingrese una placa automotora';
                                  }
                                }))
                      ],
                    ),
                    const SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Color: ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20.0),
                        ),
                        Container(
                            width: double.maxFinite,
                            padding: const EdgeInsets.only(left: 10.0),
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(5.0)),
                                border: Border.all(
                                    color: Colors.black45, width: 1)),
                            child: TextFormField(
                                style: const TextStyle(fontSize: 22.0),
                                decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Ingrese el color del automotor'),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Por favor ingrese una placa automotora';
                                  }
                                }))
                      ],
                    ),
                    const SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Inventario: ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20.0),
                        ),
                        Container(
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5.0)),
                              border:
                                  Border.all(color: Colors.black45, width: 1)),
                          child: Container(
                            height: 50.0,
                            margin: const EdgeInsets.only(right: 20.0),
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50.0)),
                            ),
                            alignment: Alignment.center,
                            child: Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black),
                                      color: Colors.grey),
                                  child: TextButton(
                                          onPressed: () {
                                            opciones(context);
                                          },
                                          child: const Text('Cargar archivo',
                                              style: TextStyle(
                                                  fontSize: 20.0,
                                                  color: Colors.black))),
                                ),
                                const SizedBox(width: 10.0),
                                Text(
                                    imagen == null
                                        ? 'Seleccione un archivo'
                                        : 'Imagen seleccionada',
                                    style: const TextStyle(
                                        fontSize: 23.0, color: Colors.black54))
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Foto 1 evidencia: ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20.0),
                        ),
                        Container(
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5.0)),
                              border:
                                  Border.all(color: Colors.black45, width: 1)),
                          child: Container(
                            height: 50.0,
                            margin: const EdgeInsets.only(right: 20.0),
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50.0)),
                            ),
                            alignment: Alignment.center,
                            child: Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black),
                                      color: Colors.grey),
                                  child: isLoading
                                      ? const CircularProgressIndicator()
                                      : TextButton(
                                          onPressed: () {
                                            opciones(context);
                                          },
                                          child: const Text('Cargar archivo',
                                              style: TextStyle(
                                                  fontSize: 20.0,
                                                  color: Colors.black))),
                                ),
                                const SizedBox(width: 10.0),
                                Text(
                                    imagen == null
                                        ? 'Seleccione un archivo'
                                        : 'Imagen seleccionada',
                                    style: const TextStyle(
                                        fontSize: 23.0, color: Colors.black54))
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Foto 2 evidencia: ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20.0),
                        ),
                        Container(
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                              borderRadius:
                              const BorderRadius.all(Radius.circular(5.0)),
                              border:
                              Border.all(color: Colors.black45, width: 1)),
                          child: Container(
                            height: 50.0,
                            margin: const EdgeInsets.only(right: 20.0),
                            decoration: const BoxDecoration(
                              borderRadius:
                              BorderRadius.all(Radius.circular(50.0)),
                            ),
                            alignment: Alignment.center,
                            child: Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black),
                                      color: Colors.grey),
                                  child: isLoading
                                      ? const CircularProgressIndicator()
                                      : TextButton(
                                      onPressed: () {
                                        opciones(context);
                                      },
                                      child: const Text('Cargar archivo',
                                          style: TextStyle(
                                              fontSize: 20.0,
                                              color: Colors.black))),
                                ),
                                const SizedBox(width: 10.0),
                                Text(
                                    imagen == null
                                        ? 'Seleccione un archivo'
                                        : 'Imagen seleccionada',
                                    style: const TextStyle(
                                        fontSize: 23.0, color: Colors.black54))
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Foto 3 evidencia: ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20.0),
                        ),
                        Container(
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                              borderRadius:
                              const BorderRadius.all(Radius.circular(5.0)),
                              border:
                              Border.all(color: Colors.black45, width: 1)),
                          child: Container(
                            height: 50.0,
                            margin: const EdgeInsets.only(right: 20.0),
                            decoration: const BoxDecoration(
                              borderRadius:
                              BorderRadius.all(Radius.circular(50.0)),
                            ),
                            alignment: Alignment.center,
                            child: Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black),
                                      color: Colors.grey),
                                  child: isLoading
                                      ? const CircularProgressIndicator()
                                      : TextButton(
                                      onPressed: () {
                                        opciones(context);
                                      },
                                      child: const Text('Cargar archivo',
                                          style: TextStyle(
                                              fontSize: 20.0,
                                              color: Colors.black))),
                                ),
                                const SizedBox(width: 10.0),
                                Text(
                                    imagen == null
                                        ? 'Seleccione un archivo'
                                        : 'Imagen seleccionada',
                                    style: const TextStyle(
                                        fontSize: 23.0, color: Colors.black54))
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Foto 4 evidencia: ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20.0),
                        ),
                        Container(
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                              borderRadius:
                              const BorderRadius.all(Radius.circular(5.0)),
                              border:
                              Border.all(color: Colors.black45, width: 1)),
                          child: Container(
                            height: 50.0,
                            margin: const EdgeInsets.only(right: 20.0),
                            decoration: const BoxDecoration(
                              borderRadius:
                              BorderRadius.all(Radius.circular(50.0)),
                            ),
                            alignment: Alignment.center,
                            child: Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black),
                                      color: Colors.grey),
                                  child: isLoading
                                      ? const CircularProgressIndicator()
                                      : TextButton(
                                      onPressed: () {
                                        opciones(context);
                                      },
                                      child: const Text('Cargar archivo',
                                          style: TextStyle(
                                              fontSize: 20.0,
                                              color: Colors.black))),
                                ),
                                const SizedBox(width: 10.0),
                                Text(
                                    imagen == null
                                        ? 'Seleccione un archivo'
                                        : 'Imagen seleccionada',
                                    style: const TextStyle(
                                        fontSize: 23.0, color: Colors.black54))
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Observaciones: ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20.0),
                        ),
                        Container(
                            width: double.maxFinite,
                            padding: const EdgeInsets.only(left: 10.0),
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(5.0)),
                                border: Border.all(
                                    color: Colors.black45, width: 1)),
                            child: const TextField(
                              maxLines: 4,
                              style: TextStyle(fontSize: 22.0),
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Ingrese las observaciones'),
                            ))
                      ],
                    ),
                    const SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '¿Ingreso propios medios al patio?: ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20.0),
                        ),
                        Container(
                            width: double.maxFinite,
                            padding: const EdgeInsets.only(left: 10.0),
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(5.0)),
                                border: Border.all(
                                    color: Colors.black45, width: 1)),
                            child: DropdownButtonFormField(
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  errorBorder: InputBorder.none),
                              style: const TextStyle(
                                  fontSize: 22.0, color: Colors.black),
                              hint: Text(texto4!),
                              isExpanded: true,
                              items: const [
                                DropdownMenuItem(
                                    value: 'Sí', child: Text('Sí')),
                                DropdownMenuItem(
                                    value: 'No', child: Text('No')),
                              ],
                              onChanged: (valor) {
                                setState(() {
                                  texto4 = valor;
                                });
                              },
                              validator: (value) => value == null
                                  ? 'Por favor seleccione una opción'
                                  : null,
                            ))
                      ],
                    ),
                    const SizedBox(height: 20),
                    MaterialButton(
                      minWidth: double.infinity,
                      onPressed: () {
                        if (!isValidForm()) return;
                      },
                      color: Colors.green,
                      textColor: Colors.white,
                      child: const Text(
                        'Guardar y enviar información',
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
