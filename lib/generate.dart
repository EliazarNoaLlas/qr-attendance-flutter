// generate.dart
// Propósito: Generar un código QR que contenga información de asistencia basada en una clase.
// Autor: [Tu Nombre]
// Fecha de modificación: [Fecha Actual]

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart'; // Importa la biblioteca para generar códigos QR
import 'package:intl/intl.dart'; // Importa la biblioteca para formatear fechas y horas
import 'package:flutter/rendering.dart'; // Importa la biblioteca para renderizar elementos en Flutter

// Clase principal que representa la página de generación del código QR
class GeneratePage extends StatefulWidget {
  final DateTime date; // Fecha de la clase
  final String cid; // ID de la clase
  final TimeOfDay start; // Hora de inicio de la clase
  final TimeOfDay end; // Hora de fin de la clase
  final String classname; // Nombre de la clase
  final String id; // ID del estudiante

  // Constructor de la clase GeneratePage
  GeneratePage(this.date, this.start, this.end, this.classname, this.id, this.cid);

  @override
  State<StatefulWidget> createState() => GeneratePageState(date, start, end, classname, id, cid);
}

// Estado de la clase GeneratePage
class GeneratePageState extends State<GeneratePage> {
  DateTime date; // Fecha de la clase
  TimeOfDay start; // Hora de inicio de la clase
  TimeOfDay end; // Hora de fin de la clase
  String cid; // ID de la clase
  String id; // ID del estudiante
  String classname; // Nombre de la clase

  // Constructor del estado de GeneratePage
  GeneratePageState(this.date, this.start, this.end, this.classname, this.id, this.cid);

  // Método para formatear la hora
  String formatTimeOfDay(TimeOfDay tod, DateTime date) {
    final now = date;
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    final format = DateFormat('yyyy-MM-dd HH:mm:ss'); // Corrige el formato de minutos: debe ser 'mm' no 'MM'
    return format.format(dt);
  }

  @override
  Widget build(BuildContext context) {
    print(cid);
    // Crea los datos del QR combinando información relevante
    String qrData = formatTimeOfDay(start, date) +
        "," +
        formatTimeOfDay(end, date) +
        "," +
        classname +
        "," +
        id +
        "," +
        cid;
    print(qrData);
    
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              stops: [0.5, 1],
              colors: [Color(0xff661EFF), Color(0xffFFA3FD)],
            ),
          ),
        ),
        title: Text(
          "QR ATTENDANCE SYSTEM",
          style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: Container(
                    height: 339,
                    width: 405,
                    child: Center(
                      child: QrImageView(
                        data: qrData, // Agrega la cadena qrData como el contenido del código QR
                        version: QrVersions.auto, // Especifica la versión del QR (opcional)
                        size: 200.0, // Especifica el tamaño del QR (opcional)
                      ),
                    ),
                  ),
                ),
                Padding(padding: const EdgeInsets.only(top: 30)),
                Divider(height: 20, thickness: 1, color: Color(0xff6C63FF), indent: 60, endIndent: 60,),
                Padding(padding: const EdgeInsets.only(top: 30)),
                Center(
                  child: Container(
                    padding: EdgeInsets.only(left: 5),
                    child: Column(
                      children: [
                        Center(
                          child: Row(
                            children: [
                              Center(
                                child: Container(
                                  height: 45,
                                  width: 170,
                                  decoration: BoxDecoration(
                                    color: Color(0xffFCFCFC),
                                    borderRadius: BorderRadius.all(Radius.circular(0)),
                                    border: Border.all(color: Colors.purple, width: 0.7),
                                  ),
                                  child: Center(
                                    child: Text('Class Name'),
                                  ),
                                ),
                              ),
                              Container(
                                height: 45,
                                width: 170,
                                decoration: BoxDecoration(
                                  color: Color(0xffFCFCFC),
                                  borderRadius: BorderRadius.all(Radius.circular(0)),
                                  border: Border.all(color: Colors.purple, width: 0.7),
                                ),
                                child: Center(
                                  child: Text(classname),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(padding: const EdgeInsets.only(top: 20)),
                        Row(
                          children: [
                            Container(
                              height: 45,
                              width: 170,
                              decoration: BoxDecoration(
                                color: Color(0xffFCFCFC),
                                borderRadius: BorderRadius.all(Radius.circular(0)),
                                border: Border.all(color: Colors.purple, width: 0.7),
                              ),
                              child: Center(
                                child: Text('Class Date'),
                              ),
                            ),
                            Container(
                              height: 45,
                              width: 170,
                              decoration: BoxDecoration(
                                color: Color(0xffFCFCFC),
                                borderRadius: BorderRadius.all(Radius.circular(0)),
                                border: Border.all(color: Colors.purple, width: 0.7),
                              ),
                              child: Center(
                                child: Text(formatTimeOfDay(start, date).substring(0, 10)),
                              ),
                            ),
                          ],
                        ),
                        Padding(padding: const EdgeInsets.only(top: 20)),
                        Row(
                          children: [
                            Container(
                              height: 45,
                              width: 170,
                              decoration: BoxDecoration(
                                color: Color(0xffFCFCFC),
                                borderRadius: BorderRadius.all(Radius.circular(0)),
                                border: Border.all(color: Colors.purple, width: 0.7),
                              ),
                              child: Center(
                                child: Text('Start time'),
                              ),
                            ),
                            Container(
                              height: 45,
                              width: 170,
                              decoration: BoxDecoration(
                                color: Color(0xffFCFCFC),
                                borderRadius: BorderRadius.all(Radius.circular(0)),
                                border: Border.all(color: Colors.purple, width: 0.7),
                              ),
                              child: Center(
                                child: Text('${start.hour}:${start.minute}'),
                              ),
                            ),
                          ],
                        ),
                        Padding(padding: const EdgeInsets.only(top: 20)),
                        Row(
                          children: [
                            Container(
                              height: 45,
                              width: 170,
                              decoration: BoxDecoration(
                                color: Color(0xffFCFCFC),
                                borderRadius: BorderRadius.all(Radius.circular(0)),
                                border: Border.all(color: Colors.purple, width: 0.7),
                              ),
                              child: Center(
                                child: Text('End time'),
                              ),
                            ),
                            Container(
                              height: 45,
                              width: 170,
                              decoration: BoxDecoration(
                                color: Color(0xffFCFCFC),
                                borderRadius: BorderRadius.all(Radius.circular(0)),
                                border: Border.all(color: Colors.purple, width: 0.7),
                              ),
                              child: Center(
                                child: Text('${end.hour}:${end.minute}'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                // Añadir más widgets o contenido aquí según sea necesario
              ],
            ),
          ),
        ),
      ),
    );
  }
}
