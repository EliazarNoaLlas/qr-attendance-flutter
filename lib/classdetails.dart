// classdetails.dart
// Propósito: Este archivo define la página de detalles de la clase en la aplicación de asistencia QR.
// Autor: Walter Stefano
// Fecha de modificación: 09 de octubre de 2024

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:qr_attendance_app/generate.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

// Modelo para los detalles de la clase
class ClassDetailSchema {
  final String classname; // Nombre de la clase
  final DateTime start; // Hora de inicio
  final DateTime end; // Hora de fin
  final String facultyid; // ID de la facultad

  // Constructor que inicializa los atributos
  ClassDetailSchema(this.classname, this.start, this.end, this.facultyid);

  // Método para convertir el objeto a JSON
  Map<String, dynamic> toJson() => {
        'classname': classname,
        'starttime': start.toIso8601String(), // Convierte DateTime a String
        'endtime': end.toIso8601String(), // Convierte DateTime a String
        'facultyid': facultyid,
      };
}

// Página de detalles de la clase
class ClassDetailsPage extends StatefulWidget {
  final String id; // ID de la clase

  ClassDetailsPage(this.id);

  @override
  _ClassDetailsPageState createState() => _ClassDetailsPageState(id);
}

// Estado de la página de detalles de la clase
class _ClassDetailsPageState extends State<ClassDetailsPage> {
  String id; // ID de la clase
  _ClassDetailsPageState(this.id); // Constructor

  final passwordController =
      TextEditingController(); // Controlador para la contraseña
  final emailController =
      TextEditingController(); // Controlador para el correo electrónico
  final classnameController =
      TextEditingController(); // Controlador para el nombre de la clase
  DateTime pickeddate = DateTime.now(); // Fecha seleccionada
  TimeOfDay start = TimeOfDay.now(); // Hora de inicio
  TimeOfDay end = TimeOfDay.now(); // Hora de fin
  late DateTime
      start1; // Hora de inicio (declarado como 'late' para inicializar más tarde)
  late String cid; // ID de clase (declarado como 'late')
  late DateTime end1; // Hora de fin (declarado como 'late')

  // Método para codificar el objeto a JSON
  dynamic myEncode(dynamic item) {
    if (item is DateTime) {
      return item.toIso8601String(); // Convierte DateTime a String
    }
    return item; // Retorna el item si no es un DateTime
  }

  @override
  Widget build(BuildContext context) {
    // Formateo de minutos para la visualización
    int t = end.minute;
    int t1 = start.minute;
    String endmin = t < 10 ? "0$t" : t.toString();
    String startmin = t1 < 10 ? "0$t1" : t1.toString();

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
          "Class Builder",
          style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(padding: const EdgeInsets.only(top: 20)),
              SvgPicture.asset(
                "assets/classbuilder.svg",
                height: 200,
                width: 181,
              ),
              Padding(padding: const EdgeInsets.only(top: 20)),
              // Campo para el nombre de la clase
              Container(
                height: 64,
                width: 325,
                decoration: BoxDecoration(
                  color: Color(0xffEFF0F6),
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
                child: TextField(
                  controller: classnameController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.edit),
                    labelText: 'Class Name',
                  ),
                ),
              ),
              Padding(padding: const EdgeInsets.only(top: 20)),
              // ... Aquí puedes continuar con más widgets según sea necesario
            ],
          ),
        ),
      ),
    );
  }
}
