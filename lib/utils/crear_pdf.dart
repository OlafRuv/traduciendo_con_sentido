import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:pdf/widgets.dart' as pw;
import 'dart:math' as math; 

Future<void> guardarMostrarPdf(List<int> bytes, String nombrePdf) async{
  final path = (await getExternalStorageDirectory())?.path;
  final archivo = File('$path/$nombrePdf');

  await archivo.writeAsBytes(bytes, flush: true);
  OpenFile.open('$path/$nombrePdf'); 
}

Future<void> crearPDF(String tituloPDF, String textoPdf) async {
  final  font = await rootBundle.load("assets/fonts/BRAILLE1.ttf");
  final  ttf = pw.Font.ttf(font);
  final pdf = pw.Document();
  
  pdf.addPage(
    pw.Page(
      build: (pw.Context context) => 
      pw.Text(
        textoPdf,
        style: pw.TextStyle(
        font: ttf,)
      ),
    ),
  );

  guardarMostrarPdf(await pdf.save(), tituloPDF);
}

Future<void> crearPDF2(String tituloPDF, String textoPdf) async {
  final  font = await rootBundle.load("assets/fonts/BRAILLE1.ttf");
  final  ttf = pw.Font.ttf(font);
  final pdf = pw.Document();
  
  pdf.addPage(
    pw.Page(
      build: (pw.Context context) => 
      pw.Transform(
        alignment: pw.Alignment.center,
        transform: Matrix4.rotationY(math.pi),
        child: pw.Text(textoPdf,
        style: pw.TextStyle(
        font: ttf,)
        )
      ),
    ),
  );


  guardarMostrarPdf(await pdf.save(), tituloPDF);
}