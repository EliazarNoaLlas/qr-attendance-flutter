# Aplicación QR Attendance

Esta es una aplicación Flutter para el control de asistencia mediante códigos QR. La aplicación permite a los profesores generar códigos QR dinámicos basados en los detalles de una clase y a los estudiantes escanearlos para confirmar su asistencia.

## Estructura del Proyecto

```
📦 qr-attendance
 ┣ 📂 .dart_tool           # Herramientas y configuración de Dart
 ┣ 📂 .idea                # Configuración del IDE
 ┣ 📂 android              # Configuración específica de Android
 ┣ 📂 assets               # Recursos estáticos
 ┣ 📂 build               # Archivos generados en la compilación
 ┣ 📂 lib                 # Código fuente principal
 ┃ ┣ 📜 attendance.dart    # Visualización de asistencia para estudiantes
 ┃ ┣ 📜 classdetails.dart  # Pantalla de detalles de clase
 ┃ ┣ 📜 generate.dart      # Generador de códigos QR
 ┃ ┣ 📜 homePage.dart      # Página principal y navegación
 ┃ ┣ 📜 login_admin.dart   # Autenticación de profesores
 ┃ ┣ 📜 login_student.dart # Autenticación de estudiantes
 ┃ ┣ 📜 main.dart          # Punto de entrada de la aplicación
 ┃ ┗ 📜 scan.dart          # Escáner de códigos QR
 ┣ 📜 .flutter-plugins
 ┣ 📜 .flutter-plugins-dependencies
 ┣ 📜 .gitignore
 ┣ 📜 pubspec.lock
 ┣ 📜 pubspec.yaml
 ┗ 📜 README.md
```

## Componentes Principales

### Módulos de Autenticación
- `homePage.dart`: Pantalla principal con opciones de inicio de sesión para estudiantes y profesores
- `login_admin.dart`: Gestión de autenticación para profesores
- `login_student.dart`: Gestión de autenticación para estudiantes

### Gestión de Clases
- `classdetails.dart`: Interfaz para que los profesores ingresen y visualicen detalles de la clase
- `generate.dart`: Generación de códigos QR basados en la información de la clase

### Sistema de Asistencia
- `scan.dart`: Funcionalidad de escaneo de códigos QR y comunicación con el servidor
- `attendance.dart`: Visualización del registro de asistencia para estudiantes

## Requisitos del Sistema
- Flutter SDK
- Dispositivo Android o iOS
- Cámara funcional para el escaneo de códigos QR

## Características
- Generación dinámica de códigos QR para cada clase
- Interfaz separada para profesores y estudiantes
- Registro de asistencia en tiempo real
- Consulta de historial de asistencia
- Sistema de autenticación seguro

## Demostración
Para ver la aplicación en funcionamiento, consulte nuestros videos demostrativos:
- [Vista del Profesor](https://drive.google.com/file/d/17H8-fRWq68B2SRs3XKslGKJgzIgY7PMK/view?usp=sharing)
- [Vista del Estudiante](https://drive.google.com/file/d/1JGjegN8_i_Oz10a1MTWeh-sZ2jhPUnvb/view?usp=sharing)

## Importante ⚠️
Este repositorio contiene únicamente el frontend de la aplicación. Las referencias a `SERVER ENDPOINT` son alias para la API original. Esta aplicación no puede ejecutarse de forma independiente sin el backend correspondiente. Para obtener acceso al servidor, por favor contacte a los contribuyentes del proyecto.

## Instalación y Configuración

1. Clone el repositorio:
```bash
git clone [URL_DEL_REPOSITORIO]
```

2. Instale las dependencias:
```bash
flutter pub get
```

3. Configure el endpoint del servidor en los archivos correspondientes

4. Execute la aplicación:
```bash
flutter run
```

## Contribución
Si desea contribuir al proyecto, por favor:
1. Haga fork del repositorio
2. Cree una nueva rama para su funcionalidad
3. Envíe un pull request con sus cambios

## Contacto
Para obtener acceso al servidor o realizar consultas sobre el proyecto, contacte a los contribuyentes del proyecto.
