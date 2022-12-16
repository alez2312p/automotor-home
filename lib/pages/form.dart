import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  String? lugarIngreso;
  String? ingresoAccidente;
  String? tipoAutomotor;
  String? tipoServicio;
  String? ingresoPatio;

  bool inventario = false;
  bool imagen1 = false;
  bool imagen2 = false;
  bool imagen3 = false;
  bool imagen4 = false;
  bool isLoading = false;
  bool nameFile = false;

  File? imagen;

  TextEditingController placaAutomotoraController = TextEditingController();
  TextEditingController nPlacaAutomotoraController = TextEditingController();
  TextEditingController marcaController = TextEditingController();
  TextEditingController colorController = TextEditingController();
  TextEditingController observacionesController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _picker = ImagePicker();

  var _pickedFile;

  @override
  void initState() {
    super.initState();
  }

  opciones(op) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: const EdgeInsets.all(0),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  InkWell(
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom:
                                  BorderSide(color: Colors.grey, width: 1))),
                      child: Row(
                        children: const [
                          Expanded(
                            child: Text('Tomar una foto',
                                style: TextStyle(fontSize: 16)),
                          ),
                          Icon(Icons.add_a_photo_rounded)
                        ],
                      ),
                    ),
                    onTap: () {
                      selectImage(1);
                    },
                  ),
                  InkWell(
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        children: const [
                          Expanded(
                            child: Text('Seleccionar una foto',
                                style: TextStyle(fontSize: 16)),
                          ),
                          Icon(Icons.image)
                        ],
                      ),
                    ),
                    onTap: () {
                      selectImage(2);
                    },
                  ),
                  InkWell(
                    child: Container(
                      decoration: const BoxDecoration(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(15)),
                          color: Colors.red),
                      padding: const EdgeInsets.all(20),
                      width: double.infinity,
                      child: const Text(
                        'Cancelar',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              ),
            ),
          );
        });

    if (op == 1) {
      inventario = true;
    }
    if (op == 2) {
      imagen1 = true;
    }
    if (op == 3) {
      imagen2 = true;
    }
    if (op == 4) {
      imagen3 = true;
    }
    if (op == 5) {
      imagen4 = true;
    }
  }

  Future<void> confirm() async {
    var url = "http://172.16.9.233/automotor-home/insert.php";

    var response = await http.post(Uri.parse(url), body: {
      'lugarIngreso': lugarIngreso,
      'placaAutomotora': placaAutomotoraController.text,
      'nPlacaAutomotora': nPlacaAutomotoraController.text,
      'ingresoAccidente': ingresoAccidente,
      'tipoAutomotor': tipoAutomotor,
      'tipoServicio': tipoServicio,
      'marca': marcaController.text,
      'color': colorController.text,
      //'inventario': inventario,
      //'foto1Evidencia': foto1Evidencia,
      //'foto2Evidencia': foto2Evidencia,
      //'foto3Evidencia': foto3Evidencia,
      //'foto4Evidencia': foto4Evidencia,
      'observaciones': observacionesController.text,
      'ingresoPropioPatio': ingresoPatio,
    });
  }

  _alertConfirm(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text('Alerta'),
          content:
              const Text("¿Seguro que desea guardar y enviar la información?"),
          actions: <Widget>[
            TextButton(
                child: const Text("Aceptar"),
                onPressed: () {
                  if (!isValidForm()) return;
                  confirm();
                  _formKey.currentState?.reset();
                  placaAutomotoraController.clear();
                  nPlacaAutomotoraController.clear();
                  marcaController.clear();
                  colorController.clear();
                  observacionesController.clear();
                  Navigator.of(context).pop();
                  _alertSave(context);
                  print('Enviado');
                }),
            TextButton(
                child: const Text("Cancelar"),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
          ],
        );
      },
    );
  }

  _alertSave(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text('Alerta'),
          content: const Text("¡¡Guardado con exito!!"),
          actions: <Widget>[
            TextButton(
                child: const Text("Aceptar"),
                onPressed: () {
                  Navigator.of(context).pop();
                  print('Guardado');
                }),
          ],
        );
      },
    );
  }

  Future selectImage(op) async {
    if (op == 1) {
      _pickedFile = await _picker.pickImage(source: ImageSource.camera);
    } else {
      _pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    }
    setState(() {
      if (_pickedFile != null) {
        imagen = File(_pickedFile.path);
      } else {
        print('No se seleccionó ninguna foto');
      }
    });
    Navigator.of(context).pop();
  }

  bool isValidForm() {
    return _formKey.currentState?.validate() ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: SizedBox(
              width: size.width * 0.4,
              height: size.height * 0.5,
              child: Row(children: [
                SizedBox(
                  height: size.height * 0.05,
                  child: Image.asset('assets/logo.png'),
                )
              ])),
          actions: [
            InkWell(
              child: Container(
                padding: const EdgeInsets.all(12.0),
                margin: const EdgeInsets.all(4.5),
                decoration: const BoxDecoration(
                  color: Colors.green,
                ),
                alignment: Alignment.center,
                child: const Text(
                  'Nuevo Registro',
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
              onTap: () {
                if (isValidForm()) return;
                _formKey.currentState?.reset();
                placaAutomotoraController.clear();
                nPlacaAutomotoraController.clear();
                marcaController.clear();
                colorController.clear();
                observacionesController.clear();
              },
            ),
          ],
        ),
        body: ListView(
          padding: const EdgeInsets.all(8),
          children: [
            const Text(
              textAlign: TextAlign.center,
              'Ingreso nuevo automotor',
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            Form(
              key: _formKey,
              child: Container(
                padding: const EdgeInsets.all(10.0),
                margin: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black54,
                      width: 2,
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
                                  fontSize: 18.0, color: Colors.black),
                              hint: const Text('Seleccione una opción'),
                              isExpanded: true,
                              items: const [
                                DropdownMenuItem(
                                    value: 'La Estación - Kilómetro 25',
                                    child: Text('La Estación - Kilómetro 25')),
                                DropdownMenuItem(
                                    value: 'La Rinconada - Vereda Cabildo',
                                    child:
                                        Text('La Rinconada - Vereda Cabildo'))
                              ],
                              onChanged: (value) {
                                setState(() {
                                  lugarIngreso = value;
                                });
                              },
                              validator: (value) => value == null
                                  ? 'Por favor seleccione un lugar de ingreso'
                                  : null,
                            ))
                      ],
                    ),
                    SizedBox(height: size.height * 0.02),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Placa automotora: ',
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
                                controller: placaAutomotoraController,
                                style: const TextStyle(fontSize: 18.0),
                                decoration: const InputDecoration(
                                    hintText: 'Ingrese una placa automotora',
                                    border: InputBorder.none,
                                    errorBorder: InputBorder.none),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Por favor ingrese una placa automotora';
                                  }
                                  return null;
                                }))
                      ],
                    ),
                    SizedBox(height: size.height * 0.02),
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
                                controller: nPlacaAutomotoraController,
                                style: const TextStyle(fontSize: 18.0),
                                decoration: const InputDecoration(
                                    hintText:
                                        'Ingrese nuevamente la placa del automotor',
                                    border: InputBorder.none,
                                    errorBorder: InputBorder.none),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Por favor ingrese nuevamente la placa automotora';
                                  }

                                  if (value != placaAutomotoraController.text) {
                                    return 'La placa automotora no coincide';
                                  }
                                  return null;
                                }))
                      ],
                    ),
                    SizedBox(height: size.height * 0.02),
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
                                  fontSize: 18.0, color: Colors.black),
                              hint: const Text('Seleccione una opción'),
                              isExpanded: true,
                              items: const [
                                DropdownMenuItem(
                                    value: 'Sí', child: Text('Sí')),
                                DropdownMenuItem(
                                    value: 'No', child: Text('No')),
                              ],
                              onChanged: (valor) {
                                setState(() {
                                  ingresoAccidente = valor;
                                });
                              },
                              validator: (value) => value == null
                                  ? 'Por favor seleccione una opción'
                                  : null,
                            ))
                      ],
                    ),
                    SizedBox(height: size.height * 0.02),
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
                                  fontSize: 18.0, color: Colors.black),
                              hint: const Text('Seleccione una opción'),
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
                                  tipoAutomotor = valor;
                                });
                              },
                              validator: (value) => value == null
                                  ? 'Por favor seleccione un tipo de automotor'
                                  : null,
                            ))
                      ],
                    ),
                    SizedBox(height: size.height * 0.02),
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
                                  fontSize: 18.0, color: Colors.black),
                              hint: const Text('Seleccione una opción'),
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
                                  tipoServicio = valor;
                                });
                              },
                              validator: (value) => value == null
                                  ? 'Por favor seleccione un tipo de servicio'
                                  : null,
                            ))
                      ],
                    ),
                    SizedBox(height: size.height * 0.02),
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
                                controller: marcaController,
                                style: const TextStyle(fontSize: 18.0),
                                decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Ingrese la marca del automotor'),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Por favor ingrese una marca automotora';
                                  }
                                  return null;
                                }))
                      ],
                    ),
                    SizedBox(height: size.height * 0.02),
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
                                controller: colorController,
                                style: const TextStyle(fontSize: 18.0),
                                decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Ingrese el color del automotor'),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Por favor ingrese el color del automotor';
                                  }
                                  return null;
                                }))
                      ],
                    ),
                    SizedBox(height: size.height * 0.02),
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
                                        opciones(1);
                                      },
                                      child: const Text('Cargar archivo',
                                          style:
                                              TextStyle(color: Colors.black))),
                                ),
                                SizedBox(width: size.width * 0.02),
                                inventario == false
                                    ? const Text('Seleccione un archivo',
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            color: Colors.black54))
                                    : const Text(
                                        'Inventario cargado',
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            color: Colors.black),
                                      )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: size.height * 0.02),
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
                                        opciones(2);
                                      },
                                      child: const Text('Cargar archivo',
                                          style:
                                              TextStyle(color: Colors.black))),
                                ),
                                SizedBox(width: size.width * 0.02),
                                imagen1 == false
                                    ? const Text('Seleccione un archivo',
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            color: Colors.black54))
                                    : const Text(
                                        'Foto 1 evidencia cargada',
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            color: Colors.black),
                                      )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: size.height * 0.02),
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
                                        opciones(3);
                                      },
                                      child: const Text('Cargar archivo',
                                          style:
                                              TextStyle(color: Colors.black))),
                                ),
                                SizedBox(width: size.width * 0.02),
                                imagen2 == false
                                    ? const Text('Seleccione un archivo',
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            color: Colors.black54))
                                    : const Text(
                                        'Foto 2 evidencia cargada',
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            color: Colors.black),
                                      )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: size.height * 0.02),
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
                                        opciones(4);
                                      },
                                      child: const Text('Cargar archivo',
                                          style:
                                              TextStyle(color: Colors.black))),
                                ),
                                SizedBox(width: size.width * 0.02),
                                imagen3 == false
                                    ? const Text('Seleccione un archivo',
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            color: Colors.black54))
                                    : const Text(
                                        'Foto 3 evidencia cargada',
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            color: Colors.black),
                                      )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: size.height * 0.02),
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
                                        opciones(5);
                                      },
                                      child: const Text('Cargar archivo',
                                          style:
                                              TextStyle(color: Colors.black))),
                                ),
                                SizedBox(width: size.width * 0.02),
                                imagen4 == false
                                    ? const Text('Seleccione un archivo',
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            color: Colors.black54))
                                    : const Text(
                                        'Foto 4 evidencia cargada',
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            color: Colors.black),
                                      )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: size.height * 0.02),
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
                            child: TextFormField(
                              controller: observacionesController,
                              maxLines: 4,
                              style: const TextStyle(fontSize: 18.0),
                              decoration: const InputDecoration(
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
                                  fontSize: 18.0, color: Colors.black),
                              hint: const Text('Seleccione una opción'),
                              isExpanded: true,
                              items: const [
                                DropdownMenuItem(
                                    value: 'Sí', child: Text('Sí')),
                                DropdownMenuItem(
                                    value: 'No', child: Text('No')),
                              ],
                              onChanged: (valor) {
                                setState(() {
                                  ingresoPatio = valor;
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
                        _alertConfirm(context);
                      },
                      color: Colors.green,
                      textColor: Colors.white,
                      child: const Text(
                        'Guardar y enviar información',
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
