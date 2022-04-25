import 'dart:io';
import 'package:open_file/open_file.dart';

Future<void> crearMostrarBrf(String texto, String nombreBrf) async{
  final archivo = File('/storage/emulated/0/Download/$nombreBrf.brf');
  archivo.writeAsString(texto);
  
  try {
    OpenFile.open('/storage/emulated/0/Download/$nombreBrf.brf'); 
  } on Exception catch (e) {
    print(e);
  }
}