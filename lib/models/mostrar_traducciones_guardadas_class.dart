import 'package:cloud_firestore/cloud_firestore.dart';

class MostrarTraduccionesGuardadasClass {
  final CollectionReference profileList = FirebaseFirestore.instance.collection('usuarios');


  Future getUserList() async {
    List itemsList = [];
    try{
      await profileList.get().then((querySnapshot){
        // querySnapshot.docs.forEach((element){
        //   itemsList.add(element.data);
        // });
        for (var element in querySnapshot.docs) {
          itemsList.add(element.data);
        }
      });
      return itemsList;
    } catch(e) {
      // print(e.toString());
      return null;
    }
  }
}