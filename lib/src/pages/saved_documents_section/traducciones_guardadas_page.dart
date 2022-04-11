import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tcs/widgets/widgets.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

import 'guardar_pdf.dart';

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
            return const Text("Cargando ...");
          }
          
          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
              return Column(
                children: <Widget>[
                  Container(height: 1, color: Colors.green), //ESTE CONTAINER LE DARA ESA LINEA DE SEPARACION A CADA ELEMENTO DE LA LISTA
                  ListTile(
                    title: Text(data['Titulo']), //MOSTRARA EL TITULO DE CADA ELEMENTO GUARDADO DE FIRESTORE
                    subtitle: Text(data['Descripción']), //MOSTRARA LA DESCRIPCION DE CADA ELEMENTO GUARDADO DE FIRESTORE
                    trailing: Wrap(
                      children: [ 
                        MaterialButton(
                            onPressed: (){
                              showDialog( 
                                context: context, 
                                builder: (BuildContext context) => 
                                AlertDialog(
                                title: const Text('Texto de traducción'),
                                content: Container(
                                  child: SingleChildScrollView(
                                    child: Text(data['Texto_guardado'], style: const TextStyle(fontFamily: 'braile_font',fontSize: 20, height: 1.5)), //MOSTRARA EL TEXTO DE NUESTRO ELEMENTO SELECCIONADO DE FIRESTORE
                                  )
                                ),
                                actions: [
                                  MaterialButton(
                                    onPressed: () {
                                      _crearPDF(data['Titulo'], data['Texto_guardado']); //FUNCION QUE TOMARA LOS VALORES A MOSTRAR EN EL PDF (TITULO Y TEXTO)
                                      Navigator.pushNamed( context, 'traducciones_guardadas');
                                    },
                                    textColor: Theme.of(context).primaryColor,
                                    child: const Text('Descargar PDF'),
                                  ),
                                  MaterialButton(
                                    onPressed: () {
                                        Navigator.pushNamed( context, 'traducciones_guardadas');
                                    },
                                    textColor: Theme.of(context).primaryColor,
                                    child: const Text('Regresar'),
                                  ),
                                ],
                                
                              )
                              );
                            },
                            child: const Text('Traducción'),
                          ),
                        MaterialButton(
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
                            },
                            child: const Text('Eliminar'),
                          ),                      
                      ]
                    ),
                  )
                ]
              );
            }).toList(),
          );
        },
        
    );
  }

  //APARTADO DONDE SE CREA EL PDF A DESCARGAR
  Future<void> _crearPDF(String tituloPDF, String textoPdf) async {
    PdfDocument documentoPDF = PdfDocument();
    final pagina = documentoPDF.pages.add();

    pagina.graphics.drawString(textoPdf, PdfStandardFont(PdfFontFamily.helvetica, 30));
    

    List<int> bytes = documentoPDF.save();
    documentoPDF.dispose();

    guardarMostrarPdf(bytes, tituloPDF);
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