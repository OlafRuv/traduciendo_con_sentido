import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tcs/widgets/widgets.dart';


class TraduccionesGuardadasPage extends StatefulWidget {
  const TraduccionesGuardadasPage({Key? key}) : super(key: key);

  @override
  _TraduccionesGuardadasPageState createState() => _TraduccionesGuardadasPageState();
}

class _TraduccionesGuardadasPageState extends State<TraduccionesGuardadasPage> {
CollectionReference firebaseFirestore = FirebaseFirestore.instance.collection("usuarios");

  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('usuarios').where('Nombre_usuario', isEqualTo: FirebaseAuth.instance.currentUser!.email.toString()).snapshots();



  //PARTE DONDE SE CONSULTARA A LA BD----------------------------------------------------------
  @override
  void initState() {
    super.initState();
    //obtenerUsuarios(); (//SE COMENTO TEMPORALMENTE PARA USO DE PRUEBAS)
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TRADUCIONES GUARDADAS'),
      ),
      body: Stack(
        children: [
          // _fondoApp(),
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
            return const Text('Something went wrong');
          }
      
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading");
          }
          
          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
              return ListTile(
                //title: Text(data['Nombre_usuario']),
                title: Text(data['Titulo']),
                subtitle: Text(data['Texto_guardado']),
                //trailing: Text(data['Uid']),
                trailing: MaterialButton(
                      onPressed: (){
                        showDialog( 
                          context: context, 
                          builder: (BuildContext context) => 
                          AlertDialog(
                          title: const Text('¿Está seguro en eliminar esta traducción?'),
                          actions: [
                            MaterialButton(
                              onPressed: () {
                                  Navigator.pushNamed( context, 'traducciones_guardadas');
                              },
                              textColor: Theme.of(context).primaryColor,
                              child: const Text('Cancelar'),
                            ),
                            MaterialButton(
                              onPressed: () {
                                print("DOCUMENTO ELIMINDADO: " + document.id);
                                FirebaseFirestore.instance.collection('usuarios').doc(document.id).delete(); //GRACIAS A QUE ACCEDEMOS MEDIANTE EL ID DEL DOCUMENTO, LA ELIMINACION ES MAS SENCILLA
                                  Navigator.pushNamed( context, 'traducciones_guardadas');
                              },
                              textColor: Theme.of(context).primaryColor,
                              child: const Text('Eliminar'),
                            ),
                          ],
                        )
                        );
                        
                        /*showDialog( //ALERTA DIALOG QUE NOS SERVIRA PARA ALERTAR AL USUARIO QUE SE GUARDO CON EXITO SU TEXTO
                          context: context, 
                          builder: (BuildContext context) => popUpEliminarRegistro(context)
                        );*/
                        //=============================================
                        //print("DOCUMENTO ELIMINDADO: " + document.id);
                        //FirebaseFirestore.instance.collection('usuarios').doc(document.id).delete(); //GRACIAS A QUE ACCEDEMOS MEDIANTE EL ID DEL DOCUMENTO, LA ELIMINACION ES MAS SENCILLA
                        //===========================================
                        
                      },
                      child: const Text('Eliminar'),
                    ),
                    
                /*onTap: (){
                  print("DOCUMENTO ELIMINDADO: " + document.id);
                  FirebaseFirestore.instance.collection('usuarios').doc(document.id).delete(); //GRACIAS A QUE ACCEDEMOS MEDIANTE EL ID DEL DOCUMENTO, LA ELIMINACION ES MAS SENCILLA
                },*/
                /*Row(
                  children: [
                    MaterialButton(
                      onPressed: (){},
                      child: const Text('Imprimir'),
                    ),
                    MaterialButton(
                      onPressed: (){},
                      child: const Text('Eliminar'),
                    )
                  ],
                ),*/

              );
            }).toList(),
          );
          
        },
          );
  }

  
 // TODO: Hacer widget de POPuP
  //POPUP QUE APARECERA CUANDO QUIERA ELIMINARSE EL REGISTRO DESEADO
  Widget popUpEliminarRegistro(BuildContext context) {
  return AlertDialog(
    title: const Text('¿Está seguro en eliminar esta traducción?'),
    actions: [
      MaterialButton(
        onPressed: () {
          final rutaTraduccionesGuardadas = MaterialPageRoute(
                builder: (context){
                  return const TraduccionesGuardadasPage();
                }
              );
            Navigator.push( context, rutaTraduccionesGuardadas);
        },
        textColor: Theme.of(context).primaryColor,
        child: const Text('Cancelar'),
      ),
      MaterialButton(
        onPressed: () {
          final rutaTraduccionesGuardadas = MaterialPageRoute(
                builder: (context){
                  return const TraduccionesGuardadasPage();
                }
              );
            Navigator.push( context, rutaTraduccionesGuardadas);
        },
        textColor: Theme.of(context).primaryColor,
        child: const Text('Eliminar'),
      ),
    ],
  );
}

}