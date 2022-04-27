import 'dart:io';

import 'package:open_file/open_file.dart';

import 'package:TCS/models/braille_rules.dart';

// * Funcion asincrona que crea en nuestras descargas el documento .brf y lo abre en el navegador
Future<void> crearMostrarBrf(String texto, String nombreBrf) async{
  final archivo = File('/storage/emulated/0/Download/$nombreBrf.brf');
  texto = aplicarReglas(texto);
  archivo.writeAsString(texto);
  try {
    OpenFile.open('/storage/emulated/0/Download/$nombreBrf.brf'); 
  // ignore: empty_catches
  } on Exception {}
}