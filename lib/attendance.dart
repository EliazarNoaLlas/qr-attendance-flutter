// attendance.dart
// Propósito: Página de asistencia que muestra los porcentajes de asistencia en una lista
// Autor: German
// Fecha de modificación: 09-10-2024

import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class AttendancePage extends StatefulWidget {
  final Map attendance; // Mapa que contiene los datos de asistencia

  AttendancePage(
      this.attendance); // Constructor que inicializa el mapa de asistencia

  @override
  _AttendancePageState createState() => _AttendancePageState(attendance);
}

class _AttendancePageState extends State<AttendancePage> {
  Map attendance; // Mapa que contendrá los datos de asistencia
  Color bg = Colors
      .white; // Color de fondo inicializado para evitar el error de no inicialización

  // Constructor que recibe el mapa de asistencia
  _AttendancePageState(this.attendance);

  @override
  Widget build(BuildContext context) {
    print(attendance); // Imprime los datos de asistencia en la consola
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
          "Attendance",
          style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                // Eliminar el texto de encabezado
                Expanded(
                  child: ListView.builder(
                    itemCount: attendance
                        .length, // Número de elementos en el mapa de asistencia
                    itemBuilder: (BuildContext context, int index) {
                      String key1 = attendance.keys.elementAt(
                          index); // Obtiene la clave del mapa de asistencia

                      // Función para determinar el color basado en el porcentaje de asistencia
                      Color returner(int a) {
                        if (a >= 75 && a <= 100) {
                          return Colors
                              .green; // Color verde para asistencia alta
                        }
                        if (a >= 40 && a <= 74) {
                          return Colors
                              .amber; // Color ámbar para asistencia moderada
                        } else {
                          return Colors.red; // Color rojo para asistencia baja
                        }
                      }

                      return Center(
                        child: Row(
                          children: <Widget>[
                            Padding(padding: const EdgeInsets.all(7)),
                            Container(
                              height: 75,
                              width: 140,
                              decoration: BoxDecoration(
                                color: Color(
                                    0xff661EFF), // Color de fondo de la celda
                                borderRadius: BorderRadius.all(
                                    Radius.circular(16)), // Bordes redondeados
                              ),
                              child: Center(
                                child: Text(
                                  key1 +
                                      ' :', // Muestra la clave del mapa (nombre)
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 24,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            Padding(padding: const EdgeInsets.only(top: 30)),
                            Container(
                              padding: EdgeInsets.only(left: 15),
                              height: 130,
                              width: 198,
                              child: Center(
                                child: CircularPercentIndicator(
                                  radius: 100,
                                  lineWidth: 10.0,
                                  percent: (attendance[key1].toDouble()) /
                                      100, // Porcentaje de asistencia
                                  backgroundColor: Colors
                                      .grey, // Color de fondo del indicador
                                  progressColor: returner(attendance[
                                      key1]), // Color del progreso basado en el porcentaje
                                  center: Text(
                                    attendance[key1].toStringAsFixed(2) +
                                        '%', // Muestra el porcentaje con dos decimales
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
