// login_student.dart
// Propósito: Implementar la página de inicio de sesión para estudiantes.
// Autor: Walter Stefano
// Fecha de modificación: 2024-10-09

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qr_attendance_app/scan.dart'; // Asegúrate de que este archivo exista
import 'package:http/http.dart' as http; // Para realizar solicitudes HTTP
import 'dart:convert'; // Para codificación y decodificación JSON
import 'package:fluttertoast/fluttertoast.dart'; // Para mostrar notificaciones

// Modelo para la solicitud de inicio de sesión del estudiante
class StudentLoginSchema {
  final String regno; // Registro del estudiante
  final String password; // Contraseña del estudiante
  final bool isStudent; // Indica si es un estudiante

  StudentLoginSchema(this.regno, this.password, this.isStudent);

  // Convierte el objeto a un mapa para el formato JSON
  Map<String, dynamic> toJson() => {
        'username': regno,
        'password': password,
        'isStudent': isStudent,
      };
}

// Clase principal para la página de inicio de sesión del estudiante
class LoginStudentPage extends StatefulWidget {
  @override
  _LoginStudentPageState createState() => _LoginStudentPageState();
}

class _LoginStudentPageState extends State<LoginStudentPage> {
  final passwordController =
      TextEditingController(); // Controlador para el campo de contraseña
  final regnoController =
      TextEditingController(); // Controlador para el campo de registro

  @override
  Widget build(BuildContext context) {
    // Declaración de 'regno' eliminada, se puede obtener directamente de regnoController.text
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
          "",
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
                "assets/student.svg", // Asegúrate de que este archivo SVG exista
                height: 200,
                width: 181,
              ),
              Padding(padding: const EdgeInsets.only(top: 20)),
              Center(
                child: Text(
                  'LOGIN',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 32,
                      fontWeight: FontWeight.w700),
                ),
              ),
              Padding(padding: const EdgeInsets.only(top: 20)),
              Container(
                height: 64,
                width: 325,
                decoration: BoxDecoration(
                  color: Color(0xffEFF0F6),
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
                child: TextField(
                  controller: regnoController,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.mail_outline),
                      labelText: 'Registration no.'),
                ),
              ),
              Padding(padding: const EdgeInsets.only(top: 40)),
              Container(
                height: 64,
                width: 295,
                decoration: BoxDecoration(
                  color: Color(0xffFCFCFC),
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  border: Border(
                    top: BorderSide(
                      color: Colors.purple,
                      width: 0.7,
                    ),
                    bottom: BorderSide(
                      color: Colors.purple,
                      width: 0.7,
                    ),
                    left: BorderSide(
                      color: Colors.purple,
                      width: 0.7,
                    ),
                    right: BorderSide(
                      color: Colors.purple,
                      width: 0.7,
                    ),
                  ),
                ),
                child: TextField(
                  obscureText: true,
                  controller: passwordController,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.remove_red_eye_outlined),
                      labelText: 'Password',
                      suffixIcon: Icon(Icons.clear)),
                ),
              ),
              Padding(padding: const EdgeInsets.only(top: 20)),
              // Cambiado el método de llamada de FlatButton a TextButton (recomendado en Flutter)
              textButton("Login", context), // Cambié a 'textButton'
            ],
          ),
        ),
      ),
    );
  }

  // Método para crear un botón de texto
  Widget textButton(String text, BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        padding: EdgeInsets.all(20.0),
        backgroundColor: Color(0xff5F2EEA),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
      onPressed: () async {
        // Usar el controlador directamente para obtener el registro
        String regno = regnoController.text;
        StudentLoginSchema s1 =
            StudentLoginSchema(regno, passwordController.text, true);
        Map<String, dynamic> data = s1.toJson();

        String body1 = json.encode(data);
        print(body1);
        var client = http.Client();
        print(client.hashCode);
        try {
          var uriResponse = await client.post(
            Uri.parse('SERVER TOKEN ENDPOINT'), // Reemplaza con tu URL real
            headers: {"Content-Type": "application/json;charset=UTF-8"},
            body: body1,
          );
          print('sent');
          Map _response = json.decode(uriResponse.body);
          if (_response.containsKey("access_token")) {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => ScanPage(regno)),
            );
          } else {
            print(_response['detail']);
            Fluttertoast.showToast(
                msg: _response['detail'],
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.SNACKBAR,
                fontSize: 12.0);
          }
        } catch (Error) {
          print(Error);
        } finally {
          client.close();
        }
      },
      child: Text(
        text,
        style: TextStyle(
            color: Color(0xffF7F7FC),
            fontFamily: "Poppins",
            fontWeight: FontWeight.w600),
      ),
    );
  }
}
