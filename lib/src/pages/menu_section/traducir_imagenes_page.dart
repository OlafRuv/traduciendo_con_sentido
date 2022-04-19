import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tcs/theme/app_theme.dart';
import 'package:tcs/utils/validators.dart';
import 'package:tcs/widgets/widgets.dart';

class TraducirImagenesPage extends StatefulWidget {
  const TraducirImagenesPage({Key? key}) : super(key: key);

  @override
  _TraducirImagenesPageState createState() => _TraducirImagenesPageState();
}

class _TraducirImagenesPageState extends State<TraducirImagenesPage> {
  bool textScanning = false;
  XFile? imageFile;
  String _scannedText = "";
  final guardarTextoController = TextEditingController();
  final guardarTituloControllerPopUp = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  String _descriptionText = '';

  @override
  void initState() {
    super.initState(); 
    Future(_showDialog);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TRADUCIR IMAGENES'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (!textScanning && imageFile == null)
                  Container(width: 300,height: 300,color: Colors.grey[300]!,),
                if (imageFile != null) Image.file(File(imageFile!.path)),
                const SizedBox(height: 20),
                _botonesSeleccionarImg(),
                const SizedBox(height: 20),
                if (textScanning) CircularProgressIndicator(color: AppTheme.primary,),
                // Text(scannedText, style: const TextStyle(fontSize: 20),),
                _salidaTexto(false),
                const Divider(),
                _salidaTexto(true),
                _guardarTraduccion(),
              ],
            )
          ),
        )
      ),

      // bottomNavigationBar: const CustomBottomNavigation(botonBarraActual: 0),
    );
  }

  void _showDialog(){
    showDialog(
      context: context, 
      builder: (BuildContext context) => 
      CustomPopUp(
        title: 'Traduccion de Imagenes', 
        content: const Text('Haga click en el boton de seleccionar para poder traducir su foto o imagen al cuadro de texto o mandar a imprimir',
          textAlign: TextAlign.justify,
          style: TextStyle(fontSize: 20)
        ), 
        buttonText: 'Continuar',
        onPressedFunction: () {
          Navigator.pop(context);
        }
      )
    );
  }

  Widget _botonesSeleccionarImg(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [ 
        CustomButton(
        buttontext: 'Galeria', 
        onPressedFunction: () {
            _getImage(ImageSource.gallery);
          },
          padHButton: 20, 
          padVButton: 20,
          iconData: Icons.image_rounded,
          iconSize: 30,
        ),
        const SizedBox(
          width: 20,
        ),
        CustomButton(
          buttontext: 'Cámara', 
          onPressedFunction: () {
            _getImage(ImageSource.camera);
          },
          padHButton: 20, 
          padVButton: 20,
          iconData: Icons.camera_alt_rounded,
          iconSize: 30,
        ),
      ]
    );
  }

  Widget _guardarTraduccion(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomButton(
          buttontext: 'Guardar', 
          onPressedFunction: () {
            _popUpGuardarTexto();
          },
          padHButton: 20, 
          padVButton: 20,
          iconData: Icons.save_rounded,
          iconSize: 30,
        ),
      ]
    );
  }
  
  Widget _salidaTexto(bool braile) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextField(
        maxLines: 5,
        autocorrect: true,
        enabled: false,
        style: braile ? 
        const TextStyle(fontFamily: 'braile_font', fontSize: 20, height: 1.5) : 
        const TextStyle(fontSize: 20, height: 1.5),
        decoration: InputDecoration(
          hintStyle: const TextStyle(color: Colors.black),
          hintText: _scannedText,
          border: const OutlineInputBorder(),
          focusedBorder: const OutlineInputBorder(),
          disabledBorder: const OutlineInputBorder(),
          enabledBorder: const OutlineInputBorder(),
        ),
      ),
    );
  }

  void _getImage(ImageSource source) async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: source);
      if (pickedImage != null) {
        textScanning = true;
        imageFile = pickedImage;
        setState(() {});
        _getRecognisedText(pickedImage);
      }
    } catch (e) {
      textScanning = false;
      imageFile = null;
      _scannedText = "Error occured while scanning";
      setState(() {});
    }
  }

  void _getRecognisedText(XFile image) async {
    final inputImage = InputImage.fromFilePath(image.path);
    final textDetector = GoogleMlKit.vision.textDetector();
    RecognisedText recognisedText = await textDetector.processImage(inputImage);
    await textDetector.close();
    _scannedText = "";
    for (TextBlock block in recognisedText.blocks) {
      for (TextLine line in block.lines) {
        _scannedText = _scannedText + line.text + "\n";
      }
    }
    textScanning = false;
    setState(() {});
  }

  void _popUpGuardarTexto() {
    showDialog(
        context: context,
        builder: (BuildContext context) => CustomPopUp(
            title: 'Guardar Traducción',
            content: Form(
              key: _key,
              child: Column(
                children: [
                  TextFieldForm(
                    labelText: 'Nombre Traduccion',
                    hintText: 'Ingrese el nombre',
                    icon: Icons.app_registration_rounded,
                    obscureText: false,
                    validator: validarVacio,
                    hasNextFocus: true,
                    controller: guardarTituloControllerPopUp,
                  ),
                  TextFormField(
                    maxLines: 3,
                    maxLength: 100,
                    validator: validarVacio,
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    autocorrect: true,
                    // controller: controllerDescripcion,
                    decoration: InputDecoration(
                      hintText: 'Introduzca su descripcion\nMáximo 100 palabras',
                      counterText:
                          '${_descriptionText.length.toString()}/100 Carácteres',
                      border: const OutlineInputBorder(),
                      focusedBorder: const OutlineInputBorder(),
                      disabledBorder: const OutlineInputBorder(),
                      enabledBorder: const OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _descriptionText = value;
                      });
                    },
                  ),
                ],
              ),
            ),
            buttonText: 'Guardar',
            onPressedFunction: () {
              if (_key.currentState!.validate()){
                Navigator.pushNamed(context, 'traducciones_guardadas');
              }
            }));
  }
  
}