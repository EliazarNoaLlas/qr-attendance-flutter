// homePage.dart
// Propósito: Página principal de la aplicación QR Attendance que permite a los usuarios iniciar sesión como estudiantes o administradores.
// Autor: Walter Stefano
// Fecha de modificación: 09/10/2024

import 'package:flutter/material.dart'; // Importar material design para el uso de widgets
import 'package:qr_attendance_app/login_student.dart'; // Importar la página de inicio de sesión para estudiantes
import 'package:qr_attendance_app/login_admin.dart'; // Importar la página de inicio de sesión para administradores
import 'package:http/http.dart'
    as http; // Importar la librería http para realizar solicitudes

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft, // Comienzo del gradiente
              end: Alignment.centerRight, // Final del gradiente
              stops: [0.5, 1], // Puntos de parada del gradiente
              colors: [
                Color(0xff661EFF),
                Color(0xffFFA3FD)
              ], // Colores del gradiente
            ),
          ),
        ),
        title: Text(
          "QR ATTENDANCE SYSTEM", // Título de la AppBar
          style: TextStyle(
            fontFamily: "Poppins", // Fuente utilizada
            fontWeight: FontWeight.bold, // Estilo de fuente
          ),
        ),
        centerTitle: true, // Centra el título en la AppBar
      ),
      body: SingleChildScrollView(
        // Permite el desplazamiento en la pantalla
        child: Container(
          //padding: EdgeInsets.all(20.0), // Descomentar si se quiere agregar padding al contenedor
          child: Column(
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.only(top: 15)), // Espacio superior
              Image.asset("assets/home.png",
                  height: 340, width: 181), // Imagen de fondo
              Padding(
                  padding: const EdgeInsets.only(top: 30)), // Espacio superior
              Container(
                padding:
                    const EdgeInsets.all(50), // Padding dentro del contenedor
                child: Column(
                  mainAxisAlignment: MainAxisAlignment
                      .center, // Centra los elementos verticalmente
                  crossAxisAlignment: CrossAxisAlignment
                      .stretch, // Estira los elementos horizontalmente
                  children: <Widget>[
                    flatButton("Login for Student",
                        LoginStudentPage()), // Botón de inicio de sesión para estudiantes
                    Padding(
                        padding:
                            const EdgeInsets.only(top: 50)), // Espacio superior
                    Divider(
                      height: 10,
                      thickness: 1.0,
                      color: Color(0xff6C63FF), // Color del divisor
                      indent: 80,
                      endIndent: 80,
                    ),
                    Padding(
                        padding:
                            const EdgeInsets.only(top: 50)), // Espacio superior
                    flatButton("Login for Teacher",
                        LoginAdminPage()), // Botón de inicio de sesión para administradores
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // Método para crear un botón personalizado
  Widget flatButton(String text, Widget widget) {
    return TextButton(
      // Cambié FlatButton a TextButton, que es la versión recomendada
      style: TextButton.styleFrom(
        padding: EdgeInsets.all(15.0), // Padding del botón
        backgroundColor: Color(0xff5F2EEA), // Color de fondo del botón
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40.0), // Bordes redondeados
        ),
      ),
      onPressed: () async {
        var client = http.Client(); // Crear cliente HTTP

        try {
          await client.get(
            Uri.parse(
                'SERVER ENDPOINT'), // Aquí deberías especificar la URL de tu servidor
          );
        } finally {
          client.close(); // Cerrar el cliente HTTP
          Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) =>
                    widget), // Navegar a la página correspondiente
          );
        }
      },
      child: Text(
        text,
        style: TextStyle(
          color: Color(0xffF7F7FC), // Color del texto
          fontFamily: "Poppins", // Fuente utilizada
          fontWeight: FontWeight.w600, // Estilo de fuente
        ),
      ),
    );
  }
}
