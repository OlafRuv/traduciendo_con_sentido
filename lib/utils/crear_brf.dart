import 'dart:io';
import 'package:open_file/open_file.dart';
import 'package:tcs/models/braille_rules.dart';

Future<void> crearMostrarBrf(String texto, String nombreBrf) async{
  final archivo = File('/storage/emulated/0/Download/$nombreBrf.brf');
  texto = aplicarReglas(texto);
  archivo.writeAsString(texto);
  try {
    OpenFile.open('/storage/emulated/0/Download/$nombreBrf.brf'); 
  } on Exception catch (e) {
    print(e);
  }
}