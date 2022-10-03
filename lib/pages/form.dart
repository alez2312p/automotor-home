import 'dart:io';
import 'package:flutter/material.dart';

import 'package:file_picker/file_picker.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  String? _texto = 'Seleccione una opción';
  String? _texto1 = 'Seleccione una opción';
  String? _fileName;
  PlatformFile? pickedfile;
  bool isLoading = false;
  bool nameFile = false;
  File? fileToDisplay;

  void pickFile() async {
    try {
      setState(() {
        isLoading = true;
      });
      FilePickerResult? result = await FilePicker.platform
          .pickFiles(type: FileType.custom, allowMultiple: false, allowedExtensions: ['pdf', 'png', 'jgp']);
      if (result != null) {
        _fileName = result.files.first.name;
        pickedfile = result.files.first;
        fileToDisplay = File(pickedfile!.path.toString());

        print('nombre del archivo $_fileName');
      }

      setState(() {
        isLoading = false;
        nameFile = !nameFile;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: SizedBox(
              width: 150,
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
              'Ingreso nuevo automotor',
              style: TextStyle(
                fontSize: 40.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(width: 20),
            Container(
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
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                      ),
                      Container(
                          height: 50.0,
                          alignment: Alignment.center,
                          width: double.maxFinite,
                          padding: const EdgeInsets.only(left: 5.0),
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                              border: Border.all(color: Colors.black45, width: 1)),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                                style: const TextStyle(fontSize: 22.0, color: Colors.black),
                                hint: Text(_texto1!),
                                isExpanded: true,
                                items: const [
                                  DropdownMenuItem(value: 'Opción 1', child: Text('Opción 1')),
                                  DropdownMenuItem(value: 'Opción 2', child: Text('Opción 2')),
                                  DropdownMenuItem(value: 'Opción 3', child: Text('Opción 3'))
                                ],
                                onChanged: (valor) {
                                  setState(() {
                                    _texto1 = valor;
                                  });
                                }),
                          ))
                    ],
                  ),
                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Placa automotora: ',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                      ),
                      Container(
                          height: 50.0,
                          width: double.maxFinite,
                          padding: const EdgeInsets.only(left: 10.0),
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                              border: Border.all(color: Colors.black45, width: 1)),
                          child: const TextField(
                            style: TextStyle(fontSize: 22.0),
                            decoration:
                                InputDecoration(border: InputBorder.none, hintText: 'Ingrese una placa automotora'),
                          ))
                    ],
                  ),
                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Ingrese nuevamente la placa: ',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                      ),
                      Container(
                          width: double.maxFinite,
                          padding: const EdgeInsets.only(left: 10.0),
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                              border: Border.all(color: Colors.black45, width: 1)),
                          child: const TextField(
                            style: TextStyle(fontSize: 22.0),
                            decoration: InputDecoration(
                                border: InputBorder.none, hintText: 'Introduza nuevamente la placa automotora'),
                          ))
                    ],
                  ),
                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '¿Ingresa por accidente?: ',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                      ),
                      Container(
                          width: double.maxFinite,
                          padding: const EdgeInsets.only(left: 10.0),
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                              border: Border.all(color: Colors.black45, width: 1)),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                                style: const TextStyle(
                                  fontSize: 22.0,
                                  color: Colors.black,
                                ),
                                hint: Text(_texto!),
                                isExpanded: true,
                                items: const [
                                  DropdownMenuItem(value: 'Sí', child: Text('Sí')),
                                  DropdownMenuItem(value: 'No', child: Text('No'))
                                ],
                                onChanged: (valor) {
                                  setState(() {
                                    _texto = valor;
                                  });
                                }),
                          ))
                    ],
                  ),
                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Tipo automotor: ',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                      ),
                      Container(
                          width: double.maxFinite,
                          padding: const EdgeInsets.only(left: 10.0),
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                              border: Border.all(color: Colors.black45, width: 1)),
                          child: const TextField(
                            style: TextStyle(fontSize: 22.0),
                            decoration:
                                InputDecoration(border: InputBorder.none, hintText: 'Ingrese el tipo de automotor'),
                          ))
                    ],
                  ),
                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Tipo servicio: ',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                      ),
                      Container(
                          width: double.maxFinite,
                          padding: const EdgeInsets.only(left: 10.0),
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                              border: Border.all(color: Colors.black45, width: 1)),
                          child: const TextField(
                            style: TextStyle(fontSize: 22.0),
                            decoration:
                                InputDecoration(border: InputBorder.none, hintText: 'Ingrese el tipo de servicio'),
                          ))
                    ],
                  ),
                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Marca: ',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                      ),
                      Container(
                          width: double.maxFinite,
                          padding: const EdgeInsets.only(left: 10.0),
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                              border: Border.all(color: Colors.black45, width: 1)),
                          child: const TextField(
                            style: TextStyle(fontSize: 22.0),
                            decoration:
                                InputDecoration(border: InputBorder.none, hintText: 'Ingrese la marca del automotor'),
                          ))
                    ],
                  ),
                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Color: ',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                      ),
                      Container(
                          width: double.maxFinite,
                          padding: const EdgeInsets.only(left: 10.0),
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                              border: Border.all(color: Colors.black45, width: 1)),
                          child: const TextField(
                            style: TextStyle(fontSize: 22.0),
                            decoration:
                                InputDecoration(border: InputBorder.none, hintText: 'Ingrese el color del automotor'),
                          ))
                    ],
                  ),
                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Inventario: ',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                      ),
                      Container(
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                            border: Border.all(color: Colors.black45, width: 1)),
                        child: Container(
                          height: 50.0,
                          margin: const EdgeInsets.only(right: 20.0),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(50.0)),
                          ),
                          alignment: Alignment.center,
                          child: Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(border: Border.all(color: Colors.black), color: Colors.grey),
                                child: isLoading
                                    ? const CircularProgressIndicator()
                                    : TextButton(
                                        onPressed: () {
                                          pickFile();
                                        },
                                        child: const Text('Cargar archivo',
                                            style: TextStyle(fontSize: 20.0, color: Colors.black))),
                              ),
                              const SizedBox(width: 10.0),
                              Text(nameFile == false ? 'Seleccione un archivo' : _fileName!,
                                  style: const TextStyle(fontSize: 23.0, color: Colors.black54))
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
                        'Foto 1: ',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                      ),
                      Container(
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                            border: Border.all(color: Colors.black45, width: 1)),
                        child: Container(
                          height: 50.0,
                          margin: const EdgeInsets.only(right: 20.0),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(50.0)),
                          ),
                          alignment: Alignment.center,
                          child: Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(border: Border.all(color: Colors.black), color: Colors.grey),
                                child: isLoading
                                    ? const CircularProgressIndicator()
                                    : TextButton(
                                        onPressed: () {
                                          pickFile();
                                        },
                                        child: const Text('Cargar archivo',
                                            style: TextStyle(fontSize: 20.0, color: Colors.black))),
                              ),
                              const SizedBox(width: 10.0),
                              Text(nameFile == false ? 'Seleccione un archivo' : _fileName!,
                                  style: const TextStyle(fontSize: 23.0, color: Colors.black54))
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
