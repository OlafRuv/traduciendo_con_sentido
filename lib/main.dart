import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tcs/router/app_routes.dart';
import 'package:tcs/theme/app_theme.dart';

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


// TODO:Revisar que es este codigo debajo del main y eliminarlo si no es de utilidad 


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
