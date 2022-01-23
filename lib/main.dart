import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tcs/src/pages/home/menu/menu_page.dart';
import 'package:tcs/src/pages/home/menu/traducir_documentos_page.dart';
import 'package:tcs/src/pages/home/menu/traducir_imagenes_page.dart';
import 'package:tcs/src/pages/home/menu/traducir_texto_page.dart';
import 'package:tcs/src/pages/home/saved_documents/traducciones_guardadas_page.dart';
import 'package:tcs/src/pages/home/settings/configuracion_page.dart';
import 'package:tcs/src/pages/login/crear_sesion_page.dart';
import 'package:tcs/src/pages/login/inicio_sesion_page.dart';
import 'package:tcs/src/pages/scroll/scroll_page.dart';

void main() {

  WidgetsFlutterBinding.ensureInitialized(); //VA A ASEGURAR QUE TODAS LAS DEPENDENCIAS ESTEN INICIALIZADAS ANTES DE COMENZAR A LANZAR LOS WIDGETS
  Firebase.initializeApp().then((value) {
    runApp(const MyApp());
  }); //VA A NUESTRA CARPETA DE ANDROID PARA VERIFICAR QUE SE ENCUENTRE EL ARCHIVO DE GOOGLE-SERVICES.JSON
  //runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Traduciendo Con Sentido',
      /*theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),*/

      initialRoute: 'scroll',
      routes: {
        //SECCION DE BIENVENIDA
        'scroll' : (BuildContext context) => ScrollPage(),
        //SECCION SCROLL DE INICIO/CREAR SESION
        'iniciar-sesion' : (BuildContext context) => InicioSesionPage(),
        'crear-sesion' : (BuildContext context) => CrearSesionPage(),
        //SECCION PRINCIPAL DE TRADUCCIONES
        'traducir-texto' : (BuildContext context) => TraducirTextoPage(),
        'traducir-documentos' : (BuildContext context) => TraducirDocumentosPage(),
        'traducir-imagenes' : (BuildContext context) => TraducirImagenesPage(),
        //SECCION DE LA BARRA INFERIOR DE LA APLICACION
        'menu' : (BuildContext context) => MenuPage(),
        'traducciones-guardadas' : (BuildContext context) => TraduccionesGuardadasPage(),
        'configuracion' : (BuildContext context) => ConfiguracionPage(),

      }
    );
  }
}





/*
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

//-------------------
  @override
  void initState() {
    super.initState();
    obtenerUsuarios();
  }

  void obtenerUsuarios() async {
    CollectionReference referenciaColeccion = FirebaseFirestore.instance.collection("usuarios");
    QuerySnapshot users = await referenciaColeccion.get();//CONSULTA A ESA COLECCION
    
    if (users.docs.length != 0){ //SI HAY VALORES
      for (var doc in users.docs) {
        print(doc.data());
        
      }
    }
  }

  //------------------
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}*/
