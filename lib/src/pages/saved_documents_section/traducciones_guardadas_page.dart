import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tcs/theme/app_theme.dart';
import 'package:tcs/widgets/widgets.dart';

class TraduccionesGuardadasPage extends StatefulWidget {
  const TraduccionesGuardadasPage({Key? key}) : super(key: key);

  @override
  _TraduccionesGuardadasPageState createState() => _TraduccionesGuardadasPageState();
}

class _TraduccionesGuardadasPageState extends State<TraduccionesGuardadasPage> {
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
        title: const Text('TRADUCIONES GUARDADAS'),
      ),
      body: Stack(
        children: [
          mostrarTraduccionesGuardadas()
        ] 
      ),
      bottomNavigationBar: const CustomBottomNavigation(botonBarraActual: 1),
    );
  }

  Widget mostrarTraduccionesGuardadas(){
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Algo salio mal');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(color: AppTheme.primary,);
        }
        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
            return Column(
              children: <Widget>[
                tarjeta(data['Titulo'], data['Descripción'], data['Texto_guardado'], document),
                Divider(color: AppTheme.primary, height: 5, indent: 10, endIndent: 10,),
              ]
            );
          }).toList(),
        );
      },
    );
  }

  Widget tarjeta(String titulo, String descripcion, String contenido, DocumentSnapshot document){
    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0)
        )
      ),
      child:Container(
        height: 100,
        color: Colors.white,
        child: Expanded(
          child:Container(
            alignment: Alignment.topLeft,
            child: Column(
              children: [
                Expanded(
                  flex: 5,
                  child: ListTile(
                    title: Text(titulo),
                    subtitle: Text(descripcion),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        child: const Text("Ver"),
                        onPressed: ()
                        {
                          _showResult(contenido);
                        },
                      ),
                      const SizedBox(width: 8,),
                      TextButton(
                        child: const Text("Descargar"),
                        onPressed: _descargar,
                      ),
                      const SizedBox(width: 8,),
                      TextButton(
                        child: const Text("Eliminar"),
                        onPressed: (){
                          _popUpEliminarRegistro(document);
                        },
                      ),
                      const SizedBox(width: 8,),
                    ],
                  ),
                )
              ],
            ),
          ),
          // flex:8 ,
        ),
      ),
      elevation: 8,
      margin: const EdgeInsets.all(10),
    );
  }
  
  void _popUpEliminarRegistro(DocumentSnapshot document) {
    showDialog(
      barrierDismissible: false,
      context: context, 
      builder: (BuildContext context) => 
      CustomPopUp(
        title: 'Eliminar Traducción',
        buttonText: 'Cancelar',
        onPressedFunction: (){ Navigator.pop(context); },
        content: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
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

  void _descargar(){
    showDialog(
      context: context, 
      builder: (BuildContext context) => 
      CustomPopUp(
        title: 'Seleccione una opción',
        buttonText: 'Cancelar',
        onPressedFunction: (){Navigator.pop(context);},
        content: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: (){Navigator.pop(context);}, 
              child: const Text('Descargar PDF',
              style: TextStyle(
                fontSize: AppTheme.size18,
                color: Colors.black,)
                )
              ),
            const Divider(),
            TextButton(
              onPressed: (){}, 
              child: const Text('Descargar PDF espejo',
              style: TextStyle(
                fontSize: AppTheme.size18,
                color: Colors.black,),
              ),
            ),
            const Divider(), 
            TextButton(
              onPressed: (){}, 
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