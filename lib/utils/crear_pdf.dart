import 'dart:io';
import 'dart:math' as math;

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';

import 'package:TCS/models/braille_rules.dart'; 

// * Funcion que guarda y muestra el PDF
Future<void> guardarMostrarPdf(List<int> bytes, String nombrePdf) async{
  final path = (await getExternalStorageDirectory())?.path;
  final archivo = File('$path/$nombrePdf');

  await archivo.writeAsBytes(bytes, flush: true);
  OpenFile.open('$path/$nombrePdf'); 
}

// * Funcion para crear un PDF 
Future<void> crearPDF(String tituloPDF, String textoPdf) async {
  final  font = await rootBundle.load("assets/fonts/Braille6-ANSI.ttf");
  final  ttf = pw.Font.ttf(font);
  final pdf = pw.Document();
  textoPdf = aplicarReglas(textoPdf);
  
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
  // Llama a la funcion de guardar y mostrar un pdf
  guardarMostrarPdf(await pdf.save(), tituloPDF);
}

// * Funcion para crear un PDF en espejo
Future<void> crearPDF2(String tituloPDF, String textoPdf) async {
  final  font = await rootBundle.load("assets/fonts/Braille6-ANSI.ttf");
  final  ttf = pw.Font.ttf(font);
  final pdf = pw.Document();
  textoPdf = aplicarReglas(textoPdf);
  pdf.addPage(
    pw.Page(
      build: (pw.Context context) => 
      pw.Transform(
        // Aqui sucede el espejo
        alignment: pw.Alignment.center,
        transform: Matrix4.rotationY(math.pi),
        child: pw.Text(textoPdf,
        style: pw.TextStyle(
        font: ttf,)
        )
      ),
    ),
  );

  // Llama a la funcion de guardar y mostrar un pdf
  guardarMostrarPdf(await pdf.save(), tituloPDF);
}