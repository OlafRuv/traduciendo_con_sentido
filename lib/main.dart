import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';

import 'package:TCS/router/app_routes.dart';
import 'package:TCS/theme/app_theme.dart';

void main() {
// Nos aseguramos que todas las dependencias esten inicializadas antes de comenzar a lanzar los widgets
  WidgetsFlutterBinding.ensureInitialized(); 
// Va a nuestra carpeta de android para verificar que se encuentre el archivo de google-services.json
  Firebase.initializeApp().then((value) {
    runApp(const MyApp());
  }); 
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

// Este widget es la raiz de la Aplicación
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Retiramos el banner de debug
      debugShowCheckedModeBanner: false,
      // Titulo de la aplicacion
      title: 'Traduciendo Con Sentido',
      // Ruta Inicial
      initialRoute: AppRoutes.initialRoute,
      // Funcion generadora de rutas
      routes: AppRoutes.getAppRoutes(),
      // Rua default
      onGenerateRoute: AppRoutes.onGenerateRoute,
      theme: AppTheme.lightTheme,
    );
  }
}
