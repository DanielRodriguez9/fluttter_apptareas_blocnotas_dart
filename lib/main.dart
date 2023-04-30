import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tareas1/screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //esto es para que el app bar inicial en donde va la hora fecha y demas se combine con nuestro color del app bar y se vea mas cool

    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));

    return MaterialApp(
      //eto es para quitar el dexto de debug que aparece en la aplicacion, es molesto
      debugShowCheckedModeBanner: false,
      title: 'My Tasks',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(), //gome es la conexion con gome.dart
    );
  }
}
