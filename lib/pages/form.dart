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
  String? placaAutomotora;
  String? nPlacaAutomotora;
  String? ingresoAccidente;
  String? tipoAutomotor;
  String? tipoServicio;
  String? marca;
  String? color;
  String? observaciones;
  String? ingresoPatio;

  bool isLoading = false;
  bool nameFile = false;
  List<bool> imageLoaded = [false, false, false, false, false];

  TextEditingController placaAutomotoraController = TextEditingController();
  TextEditingController nPlacaAutomotoraController = TextEditingController();
  TextEditingController marcaController = TextEditingController();
  TextEditingController colorController = TextEditingController();
  TextEditingController observacionesController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final List<File> _image = [File(""), File(""), File(""), File(""), File("")];
  final List<String> _fileName = ["", "", "", "", ""];

  @override
  void initState() {
    super.initState();
  }

  /* opciones(op) {
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
  }

  Future selectImage(op) async {
    final _picker = ImagePicker();
    var image = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = File(image!.path);
      inventa = true;
    });
    Navigator.of(context).pop();
  }
*/

  Future getImage(int _id) async {
    final _picker = ImagePicker();
    var image = await _picker.pickImage(source: ImageSource.camera);
    bool imageLoaded = false;
    setState(() {
      _image[_id] = File(image!.path);
      _fileName[_id] =
          '${placaAutomotoraController.text}-${image.path.split('/').last}';
      imageLoaded = true;
    });
    print(imageLoaded);
    return imageLoaded;
  }

  Future<void> confirm() async {
    const directory = "/storage/emulated/0/Pictures";
    await _image[0].copy('$directory/${_fileName[0]}');
    await _image[1].copy('$directory/${_fileName[1]}');
    await _image[2].copy('$directory/${_fileName[2]}');
    await _image[3].copy('$directory/${_fileName[3]}');
    await _image[4].copy('$directory/${_fileName[4]}');

    placaAutomotora = placaAutomotoraController.text;
    nPlacaAutomotora = nPlacaAutomotoraController.text;
    marca = marcaController.text;
    color = colorController.text;
    observaciones = observacionesController.text;

    var url = "http://192.168.1.13/automotor-home/insert.php";

    Map dataSend = {
      'lugarIngreso': lugarIngreso,
      'placaAutomotora': placaAutomotora,
      'nPlacaAutomotora': nPlacaAutomotora,
      'ingresoAccidente': ingresoAccidente,
      'tipoAutomotor': tipoAutomotor,
      'tipoServicio': tipoServicio,
      'marca': marca,
      'color': color,
      'inventario': _fileName[0],
      'foto1Evidencia': _fileName[1],
      'foto2Evidencia': _fileName[2],
      'foto3Evidencia': _fileName[3],
      'foto4Evidencia': _fileName[4],
      'observaciones': observaciones,
      'ingresoPropioPatio': ingresoPatio,
    };

    http.post(Uri.parse(url), body: dataSend);
  }

  void reset() {
    _formKey.currentState?.reset();
    placaAutomotoraController.clear();
    nPlacaAutomotoraController.clear();
    marcaController.clear();
    colorController.clear();
    observacionesController.clear();
    imageLoaded = [false, false, false, false, false];
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
                  reset();
                  print('Guardado');
                }),
          ],
        );
      },
    );
  }

  bool isValidForm() {
    return _formKey.currentState?.validate() ?? false;
  }

  Widget imageLoader(BuildContext context, Size size, String nameTitle, int id) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          nameTitle,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
        ),
        Container(
          width: double.maxFinite,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
              border: Border.all(color: Colors.black45, width: 1)),
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(50.0)),
            ),
            alignment: Alignment.center,
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      color: Colors.grey),
                  child: TextButton(
                      onPressed: () async {
                        imageLoaded[id] = await getImage(id);
                      },
                      child: const Text('Cargar archivo',
                          style: TextStyle(color: Colors.black))),
                ),
                SizedBox(width: size.width * 0.02),
                Text(
                    imageLoaded[id]
                        ? '$nameTitle cargado'
                        : 'Seleccione un archivo',
                    style: TextStyle(
                        fontSize: 18.0,
                        color:
                            imageLoaded[id] ? Colors.black : Colors.black54)),
              ],
            ),
          ),
        )
      ],
    );
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
                reset();
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

                    // Cualquier vuelta
                    SizedBox(height: size.height * 0.02),
                    imageLoader(context, size, 'Inventario', 0),
                    SizedBox(height: size.height * 0.02),
                    imageLoader(context, size, 'Foto 1', 1),
                    SizedBox(height: size.height * 0.02),
                    imageLoader(context, size, 'Foto 2', 2),
                    SizedBox(height: size.height * 0.02),
                    imageLoader(context, size, 'Foto 3', 3),
                    SizedBox(height: size.height * 0.02),
                    imageLoader(context, size, 'Foto 4', 4),
                    // Cualquier vuelta

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
                    SizedBox(height: size.height * 0.02),
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
                    SizedBox(height: size.height * 0.02),
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
