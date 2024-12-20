// scan.dart
// Propósito: Página para escanear códigos QR y registrar asistencia.
// Autor: Walter Stefano
// Fecha de modificación: 09 de octubre de 2024

import 'package:barcode_scan2/platform_wrapper.dart';
import 'package:flutter/material.dart'; // Importa Flutter Material Design
import 'package:flutter_svg/svg.dart'; // Importa SVG para imágenes
import 'package:qr_attendance_app/attendance.dart'; // Importa la página de asistencia
import 'package:http/http.dart' as http; // Importa el paquete HTTP para hacer solicitudes
import 'dart:convert'; // Importa la biblioteca para manejar JSON
import 'package:fluttertoast/fluttertoast.dart'; // Importa para mostrar mensajes emergentes

// Clase que representa el esquema de asistencia
class AttendanceSchema {
  final String cid; // ID de la clase
  final String sid; // ID del estudiante
  final DateTime scantime; // Hora de escaneo

  AttendanceSchema(this.cid, this.sid, this.scantime);

  // Convierte la instancia a JSON
  Map<String, dynamic> toJson() => {
        'classid': cid,
        'studentid': sid,
        'scantime': scantime.toIso8601String(), // Formatea la fecha
      };
}

// Clase de la página de escaneo
class ScanPage extends StatefulWidget {
  final String sid; // ID del estudiante

  ScanPage(this.sid);

  @override
  _ScanPageState createState() => _ScanPageState(sid);
}

// Estado de la página de escaneo
class _ScanPageState extends State<ScanPage> {
  final String sid; // ID del estudiante
  String qrCodeResult = "Scan The QR for Attendance"; // Mensaje por defecto
  DateTime start; // Hora de inicio
  DateTime end; // Hora de fin
  Map<String, dynamic> _response; // Respuesta del servidor

  // Constructor
  _ScanPageState(this.sid) : _response = {}, start = DateTime.now(), end = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  stops: [0.5, 1],
                  colors: [Color(0xff661EFF), Color(0xffFFA3FD)])),
        ),
        title: Text(
          "QR Scanner",
          style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(padding: const EdgeInsets.only(top: 20)),
              Center(
                  child: Text(
                'Scan the QR',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 32,
                    fontWeight: FontWeight.w700),
              )),
              Padding(padding: const EdgeInsets.only(top: 5)),
              Center(
                  child: Text(
                'for',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 32,
                    fontWeight: FontWeight.w700),
              )),
              Padding(padding: const EdgeInsets.only(top: 5)),
              Center(
                  child: Text(
                'Attendance',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 32,
                    fontWeight: FontWeight.w700),
              )),
              Padding(padding: const EdgeInsets.only(top: 20)),
              Divider(
                height: 3,
                thickness: 2,
                color: Color(0xff6C63FF),
              ),
              Padding(padding: const EdgeInsets.only(top: 20)),
              ElevatedButton( // Cambiado de FlatButton a ElevatedButton
                onPressed: () async {
                  try {
                    String codeScanner = await BarcodeScanner.scan().then((value) => value.rawContent); // Escanea el código QR//+
                    setState(() {
                      qrCodeResult = codeScanner; // Actualiza el resultado del escaneo
                    });
                    var details = codeScanner.split(","); // Separa los detalles
                    print(details);
                    start = DateTime.parse(details[0]); // Parsea la fecha de inicio
                    end = DateTime.parse(details[1]); // Parsea la fecha de fin

                    // Crea un nuevo objeto de asistencia
                    AttendanceSchema s1 =
                        AttendanceSchema(details[4], sid, DateTime.now());
                    Map<String, dynamic> data = s1.toJson(); // Convierte a JSON
                    print(data);

                    String body1 = json.encode(data); // Convierte el mapa a JSON

                    var client = http.Client();
                    try {
                      var uriResponse = await client.post(
                        Uri.parse('SERVER ATTENDANCE ENDPOINT'), // Reemplaza con el endpoint real
                        headers: {"Content-Type": "application/json;charset=UTF-8"},
                        body: body1,
                      );
                      _response = json.decode(uriResponse.body); // Decodifica la respuesta
                    } finally {
                      // Verifica si el estudiante está presente
                      if (_response["present"]) {
                        Fluttertoast.showToast(
                          msg: "Attendance added for class " + details[2],
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.SNACKBAR,
                          fontSize: 20.0,
                        );
                      } else {
                        Fluttertoast.showToast(
                          msg: "You have scanned late. Please contact the faculty.",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.SNACKBAR,
                          fontSize: 20.0,
                        );
                      }
                    }
                  } catch (e) {
                    print("Error scanning QR code: $e"); // Manejo de errores al escanear
                  }
                },
                child: Text(
                  "Open Scanner",
                  style: TextStyle(
                      color: Color(0xffF7F7FC),
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w600),
                ),
                style: ElevatedButton.styleFrom( // Configuración de estilo
                  backgroundColor: Color(0xff5F2EEA),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40.0)),
                ),
              ),
              Padding(padding: const EdgeInsets.only(top: 20)),
              flatButton("Check Attendance", AttendancePage(_response)), // Crea un botón para revisar asistencia
              Padding(padding: const EdgeInsets.only(top: 35)),
              SvgPicture.asset(
                "assets/phone.svg", // Imagen SVG
                height: 282,
                width: 342,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Método para crear un botón que verifica la asistencia
  Widget flatButton(String text, Widget widget) {
    return ElevatedButton( // Cambiado de FlatButton a ElevatedButton
      onPressed: () async {
        var client = http.Client();
        try {
          var uriResponse = await client.get(
            Uri.parse('SERVER ENDPOINT TO GET ATTENDANCE OF SID'), // Reemplaza con el endpoint real
            headers: {"Content-Type": "application/json;charset=UTF-8"},
          );
          Map<String, dynamic> _response = json.decode(uriResponse.body); // Decodifica la respuesta
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => AttendancePage(_response))); // Navega a la página de asistencia
        } finally {
          client.close(); // Cierra el cliente HTTP
        }
      },
      child: Text(
        text,
        style: TextStyle(
            color: Color(0xffF7F7FC),
            fontFamily: "Poppins",
            fontWeight: FontWeight.w600),
      ),
      style: ElevatedButton.styleFrom( // Configuración de estilo
        backgroundColor: Color(0xff5F2EEA),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40.0)),
      ),
    );
  }
}
