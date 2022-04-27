import 'package:cloud_firestore/cloud_firestore.dart';

// * Modelo de Traducciones Guardadas
// ! Pruebas
class MostrarTraduccionesGuardadasClass {
  final CollectionReference profileList = FirebaseFirestore.instance.collection('usuarios');

  // Funcion asincrona para obtener los usuarios
  Future getUserList() async {
    List itemsList = [];
    try{
      await profileList.get().then((querySnapshot){
        for (var element in querySnapshot.docs) {
          itemsList.add(element.data);
        }
      });
      return itemsList;
    } catch(e) {
      return null;
    }
  }
}