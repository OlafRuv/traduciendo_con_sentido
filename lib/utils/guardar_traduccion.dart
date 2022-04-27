import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// * Funcion asincrona para la escritura en firestore de una traduccion
Future<void> escrituraFirestore(String guardarTextoFirestore, String guardarTituloFirestore, String guardarDescripcionFirestore) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  String identificadorCorreo = auth.currentUser!.email.toString();
  String identificadorUid = auth.currentUser!.uid.toString();
  CollectionReference coleccionUsuarios =
      FirebaseFirestore.instance.collection('usuarios');

  coleccionUsuarios.add({
    'Titulo': 
        guardarTituloFirestore,
    'Texto_guardado':
        guardarTextoFirestore, //INGRESA EN EL CAMPO TEXTO GUARDADO NUESTRO TEXTO A GUARDAR
    'Descripción':  
        guardarDescripcionFirestore,
    'Nombre_usuario': 
        identificadorCorreo, //INGRESA EN EL CAMPO NOMBRE USUARIO NUESTRO USUARIO (CORREO)
    'Uid':
        identificadorUid, //INGRESA EN EL CAMPO UID NUESTRO IDENTIFICADOR DE USUARIO
  });

  return;
}