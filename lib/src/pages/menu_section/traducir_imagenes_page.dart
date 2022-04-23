import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tcs/theme/app_theme.dart';
import 'package:tcs/utils/guardar_traduccion.dart';
import 'package:tcs/utils/validators.dart';
import 'package:tcs/widgets/widgets.dart';

class TraducirImagenesPage extends StatefulWidget {
  const TraducirImagenesPage({Key? key}) : super(key: key);

  @override
  _TraducirImagenesPageState createState() => _TraducirImagenesPageState();
}

class _TraducirImagenesPageState extends State<TraducirImagenesPage> {
  final guardarTituloController = TextEditingController();
  final guardarDescripcionController = TextEditingController();

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  String _textoDescripcion = "";
  String _textoEscaneado = "";
  XFile? archivoImagen;
  bool escaneoTexto = false;

  @override
  void initState() {
    super.initState(); 
    Future(_mostrarDialogo);
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
                if (!escaneoTexto && archivoImagen == null)
                  Container(width: 300,height: 300,color: Colors.grey[300]!,),
                if (archivoImagen != null) Image.file(File(archivoImagen!.path)),
                const SizedBox(height: 20),
                _botonesSeleccionarImg(),
                const SizedBox(height: 20),
                if (escaneoTexto) CircularProgressIndicator(color: AppTheme.primary,),
                _salidaTexto(false),
                const Divider(),
                _salidaTexto(true),
                _guardarTraduccion(),
              ],
            )
          ),
        )
      ),
    );
  }

  // *                                        FUNCIONES DE INTERFAZ
  void _mostrarDialogo(){
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
            _obtenerImagen(ImageSource.gallery);
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
            _obtenerImagen(ImageSource.camera);
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
          hintText: _textoEscaneado,
          border: const OutlineInputBorder(),
          focusedBorder: const OutlineInputBorder(),
          disabledBorder: const OutlineInputBorder(),
          enabledBorder: const OutlineInputBorder(),
        ),
      ),
    );
  }
  // *                                        FUNCIONES DE INTERFAZ

  // *                                        FUNCIONES DE SELECCION DE IMAGEN
  void _obtenerImagen(ImageSource source) async {
    try {
      final imagenSeleccionada = await ImagePicker().pickImage(source: source);
      if (imagenSeleccionada != null) {
        escaneoTexto = true;
        archivoImagen = imagenSeleccionada;
        setState(() {});
        _obtenerTextoReconocido(imagenSeleccionada);
      }
    } catch (e) {
      escaneoTexto = false;
      archivoImagen = null;
      _textoEscaneado = "Ocurrió un error en el escaneo";
      setState(() {});
    }
  }
  // *                                        FUNCIONES DE SELECCION DE IMAGEN

  // *                                        FUNCIONES DE ESCANEO DE TEXTO
  void _obtenerTextoReconocido(XFile imagen) async {
    final imagenEntrada = InputImage.fromFilePath(imagen.path);
    final detectorTexto = GoogleMlKit.vision.textDetector();
    RecognisedText textoReconocido = await detectorTexto.processImage(imagenEntrada);
    await detectorTexto.close();
    _textoEscaneado = "";
    for (TextBlock bloque in textoReconocido.blocks) {
      for (TextLine linea in bloque.lines) {
        _textoEscaneado = _textoEscaneado + linea.text + "\n";
      }
    }
    escaneoTexto = false;
    setState(() {});
  }
  // *                                        FUNCIONES DE ESCANEO DE TEXTO


  // *                                        FUNCIONES DE FUNCIONALIDAD SOLUCION
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
                controller: guardarTituloController,
              ),
              TextFormField(
                maxLines: 3,
                maxLength: 100,
                validator: validarVacio,
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
                autocorrect: true,
                controller: guardarDescripcionController,
                decoration: InputDecoration(
                  hintText: 'Introduzca su descripcion\nMáximo 100 palabras',
                  counterText:
                      '${_textoDescripcion.length.toString()}/100 Carácteres',
                  border: const OutlineInputBorder(),
                  focusedBorder: const OutlineInputBorder(),
                  disabledBorder: const OutlineInputBorder(),
                  enabledBorder: const OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    _textoDescripcion = value;
                  });
                },
              ),
            ],
          ),
        ),
        buttonText: 'Guardar',
        onPressedFunction: () {
          if (_textoEscaneado.isNotEmpty) {
            if (_key.currentState!.validate()){
              escrituraFirestore(_textoEscaneado,guardarTituloController.text, guardarDescripcionController.text);
              Navigator.pushNamed(context, 'traducciones_guardadas');
            }
          }
        }
      )
    );
  }
  // *                                        FUNCIONES DE FUNCIONALIDAD SOLUCION
}