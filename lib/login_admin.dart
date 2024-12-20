// login_admin.dart
// Este archivo contiene la implementación de la página de inicio de sesión para administradores en una aplicación de asistencia QR.
// Autor: Walter Stefano
// Fecha de modificación: 09 de octubre de 2024

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qr_attendance_app/classdetails.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';

// Clase que define el esquema de inicio de sesión para el facultativo
class FacultyLoginSchema {
  final String email; // Email del usuario
  final String password; // Contraseña del usuario
  final bool isStudent; // Indica si el usuario es un estudiante

  // Constructor para inicializar los campos
  FacultyLoginSchema(this.email, this.password, this.isStudent);

  // Método que convierte el objeto en un mapa JSON
  Map toJson() => {
        'username': email,
        'password': password,
        'isStudent': isStudent,
      };
}

// Página de inicio de sesión para administradores
class LoginAdminPage extends StatefulWidget {
  @override
  _LoginAdminPageState createState() => _LoginAdminPageState();
}

class _LoginAdminPageState extends State<LoginAdminPage> {
  final passwordController =
      TextEditingController(); // Controlador para el campo de contraseña
  final emailController =
      TextEditingController(); // Controlador para el campo de email
  late String
      id; // Campo para almacenar el ID (token) del usuario, ahora marcado como 'late' para inicializarlo más tarde

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
        title: Text("",
            style:
                TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.bold)),
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
              SvgPicture.asset(
                "assets/admin_login.svg",
                height: 200,
                width: 181,
              ),
              Padding(padding: const EdgeInsets.only(top: 20)),
              Center(
                child: Text('LOGIN',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 32,
                        fontWeight: FontWeight.w700)),
              ),
              Padding(padding: const EdgeInsets.only(top: 20)),
              // Campo de entrada para el email del profesor
              Container(
                height: 64,
                width: 325,
                decoration: BoxDecoration(
                  color: Color(0xffEFF0F6),
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.mail_outline),
                    labelText: 'Teacher Email',
                  ),
                ),
              ),
              Padding(padding: const EdgeInsets.only(top: 40)),
              // Campo de entrada para la contraseña
              Container(
                height: 64,
                width: 325,
                decoration: BoxDecoration(
                  color: Color(0xffFCFCFC),
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  border: Border.all(color: Colors.purple, width: 0.7),
                ),
                child: TextField(
                  obscureText: true,
                  controller: passwordController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.remove_red_eye),
                    labelText: 'Password',
                    suffixIcon: Icon(Icons.clear),
                  ),
                ),
              ),
              Padding(padding: const EdgeInsets.only(top: 30)),
              // Botón para iniciar sesión
              elevatedButton("Login", ClassDetailsPage(id)),
            ],
          ),
        ),
      ),
    );
  }

  // Método que crea un botón estilizado
  Widget elevatedButton(String text, Widget widget) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.all(15.0),
        backgroundColor: Color(0xff5F2EEA), // Color de fondo del botón
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
      onPressed: () async {
        FacultyLoginSchema s1 = FacultyLoginSchema(
            emailController.text, passwordController.text, false);
        Map data = s1.toJson(); // Convierte el esquema a JSON
        String body1 = json.encode(data); // Codifica el JSON a un string
        print(body1);
        var client = http.Client();
        try {
          // Realiza la solicitud POST al servidor
          var uriResponse = await client.post(
            Uri.parse(
                'SERVER TOKEN ENDPOINT'), // Aquí debes colocar el endpoint correcto
            headers: {"Content-Type": "application/json;charset=UTF-8"},
            body: body1,
          );
          print('sent');
          Map _response =
              json.decode(uriResponse.body); // Decodifica la respuesta JSON
          // Verifica si se recibió un token de acceso
          if (_response.containsKey("access_token")) {
            id = _response["access_token"]; // Guarda el token de acceso
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => ClassDetailsPage(id)),
            );
          } else {
            print(_response['detail']);
            Fluttertoast.showToast(
              msg: _response['detail'],
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.SNACKBAR,
              fontSize: 12.0,
            );
          }
        } catch (Error) {
          print(Error); // Maneja el error
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
    );
  }
}
