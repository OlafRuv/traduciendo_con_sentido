import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:TCS/utils/utils.dart';
import 'package:TCS/theme/app_theme.dart';
import 'package:TCS/widgets/widgets.dart';

class TraduccionesGuardadasPage extends StatefulWidget {
  const TraduccionesGuardadasPage({Key? key}) : super(key: key);
  @override
  _TraduccionesGuardadasPageState createState() => _TraduccionesGuardadasPageState();
}

class _TraduccionesGuardadasPageState extends State<TraduccionesGuardadasPage> {
  // Hacemos un QuerySnapshot de los usuarios registrados y tomamos los registros de nuestro usuario
  CollectionReference firebaseFirestore = FirebaseFirestore.instance.collection("usuarios");
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('usuarios').where('Nombre_usuario',
   isEqualTo: FirebaseAuth.instance.currentUser!.email.toString()).snapshots();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Encabezado de la pagina
        title: const Text("TRADUCIONES GUARDADAS"),
      ),
      body: Stack(
        children: [
          // Widget que nos devuelve las traducciones guardadas
          mostrarTraduccionesGuardadas()
        ] 
      ),
      // Barra de navegacion de parte de abajo de la pantalla
      bottomNavigationBar: const CustomBottomNavigation(botonBarraActual: 1),
    );
  }

  // Este widget toma nuestro QuerySnapshot y construye nuestras tarjetas
  Widget mostrarTraduccionesGuardadas(){
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          // Mostramos un texto si algo sale mal
          return const Text('Algo malio sal');
        }
        // Mientras se hace el QuerySnapshot mostramos un indicador circular de progreso animado
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center( 
              child: CircularProgressIndicator(color: AppTheme.primary,)),
          );
        }
        // Si si se realiza bien el query snapshot construimos una lista de tarjetas
        return ListView(
          // Mapeamos el resultado del querysnapshot y en base a la informacion creamos las tarjetas
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
            return Column(
              children: <Widget>[
                // Nuestro widget Tarjeta recibe la informacion para construirse
                tarjeta(data['Titulo'], data['Descripción'], data['Texto_guardado'], document),
                Divider(color: AppTheme.primary, height: 5, indent: 10, endIndent: 10,),
              ]
            );
          }).toList(),
        );
      },
    );
  }

  // Esta funcion construye las tarjetas
  Widget tarjeta(String titulo, String descripcion, String contenido, DocumentSnapshot document){
    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0)
        )
      ),
      child: Container(
        alignment: Alignment.topLeft,
        child: Column(
          children: [
            // Ponemos la informacion
            ListTile(
              title: Text(titulo),
              subtitle: Text(descripcion),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Cda uno de los botnes tiene funcionalidades diferentes 
                TextButton(
                  child: const Text("Ver"),
                  onPressed: ()
                  {
                    // Con este botn vemos el contenido del texto guardado, el cual se puede leer con el lector de pantalla
                    _showResult(contenido);
                  },
                ),
                const SizedBox(width: 8,),
                TextButton(
                  child: const Text("Descargar"),
                  onPressed: (){
                    // Este boton despliega el pop up de descarga de traduccion para la cual tenemos 3 opciones
                    _descargar(titulo,contenido);
                  },
                ),
                const SizedBox(width: 8,),
                TextButton(
                  child: const Text("Eliminar"),
                  onPressed: (){
                    // Este boton nos ayuda a eliminar el registro de la traduccion 
                    _popUpEliminarRegistro(document);
                  },
                ),
                const SizedBox(width: 8,),
              ],
            )
          ],
        ),
      ),
      elevation: 8,
      margin: const EdgeInsets.all(10),
    );
  }
  
  // Funcion para eliminar el registro
  // Recibimos el documento para poder eliminarlo
  void _popUpEliminarRegistro(DocumentSnapshot document) {
    showDialog(
      barrierDismissible: false,
      context: context, 
      builder: (BuildContext context) => 
      CustomPopUp(
        // titulo del popup
        title: 'Eliminar Traducción',
        buttonText: 'Cancelar',
        onPressedFunction: (){ Navigator.pop(context); },
        content: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            // Mensaje dentro del popup
            const Text('¿Seguro que desea eliminar la traducción?',
              textAlign: TextAlign.center, 
              style: TextStyle(fontSize: AppTheme.size18),
            ),
            const Divider(), 
            TextButton(
              onPressed: () {
                FirebaseFirestore.instance.collection('usuarios').doc(document.id).delete(); //GRACIAS A QUE ACCEDEMOS MEDIANTE EL ID DEL DOCUMENTO, LA ELIMINACION ES MAS SENCILLA
                Navigator.pushNamed( context, 'traducciones_guardadas');
              },
              child: const Text('Confirmar',
              style:  TextStyle(
                fontSize: AppTheme.size20,
                color: Colors.red,
                ),
              ),
            ),
          ],
        )
      ),
    );
  }

  // Funcion para mostrar el contenido de la traduccion almacenada, recibe el texto del documento
  void _showResult(String text) {
    showDialog(
      context: context, 
      builder: (BuildContext context) => 
      CustomPopUp(
        title: 'Texto Guardado',
        buttonText: 'Ok',
        onPressedFunction: (){ Navigator.pop(context); },
        content: Text(text),
      ),
    );
  }

// Funcion para descargar el documento que nos da 3 opciones de descarga 
  void _descargar(String titulo, String contenido){
    showDialog(
      context: context, 
      builder: (BuildContext context) => 
      CustomPopUp(
        title: 'Seleccione una opción',
        buttonText: 'Cancelar',
        onPressedFunction: (){
          Navigator.pop(context);
        },
        content: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: (){
                // Descarga de pdf llama a la utilidad de crear pdf
                Navigator.pop(context);
                crearPDF(titulo, contenido);
              }, 
              child: const Text('Descargar PDF',
              style: TextStyle(
                fontSize: AppTheme.size18,
                color: Colors.black,)
                )
              ),
            const Divider(),
            TextButton(
              onPressed: (){
                // Descarga de pdf llama a la utilidad de crearpdf2
                Navigator.pop(context);
                crearPDF2(titulo, contenido);
              },  
              child: const Text('Descargar PDF espejo',
              style: TextStyle(
                fontSize: AppTheme.size18,
                color: Colors.black,),
              ),
            ),
            const Divider(), 
            TextButton(
              onPressed: (){
                // Descarga de brf llama a la utilidad de crearymostrar brf
                Navigator.pop(context);
                crearMostrarBrf(contenido,titulo);
              }, 
              child: const Text('Descargar .brf',
              style:  TextStyle(
                fontSize: AppTheme.size18,
                color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}