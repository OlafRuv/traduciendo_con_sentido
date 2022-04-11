import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

Future<void> guardarMostrarPdf(List<int> bytes, String nombrePdf) async{
  final path = (await getExternalStorageDirectory())?.path;
  final archivo = File('$path/$nombrePdf');

  await archivo.writeAsBytes(bytes, flush: true);
  OpenFile.open('$path/$nombrePdf'); 
}