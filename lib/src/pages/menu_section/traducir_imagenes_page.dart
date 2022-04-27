import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';

import 'package:TCS/models/models.dart';
import 'package:TCS/utils/utils.dart';
import 'package:TCS/theme/app_theme.dart';
import 'package:TCS/widgets/widgets.dart';

class TraducirImagenesPage extends StatefulWidget {
  const TraducirImagenesPage({Key? key}) : super(key: key);
  @override
  _TraducirImagenesPageState createState() => _TraducirImagenesPageState();
}

// * Pagina de traduccion de imagenes 
class _TraducirImagenesPageState extends State<TraducirImagenesPage> {
  // controladores
  final guardarTituloController = TextEditingController();
  final guardarDescripcionController = TextEditingController();
  // formkey
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  // variables de uso dentro de la interfaz
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
        // Encabezado de la pagina
        title: const Text('TRADUCIR IMAGENES'),
      ),
      body: Center(
        child: SingleChildScrollView(
          // Singlechildscrollview hace la pagina scrolleable
          child: Container(
            margin: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // La interfaz muestra un cuadro gris si un escaneo no se ha efectuado, sin embargo si este se realiza se muestra la imagen que se escaneo
                if (!escaneoTexto && archivoImagen == null)
                  Container(width: 300,height: 300,color: Colors.grey[300]!,),
                // Semantics para que el lector de pantalla puede leer la imagen con la etiqueta label que le asignamos
                if (archivoImagen != null)  Semantics(child: Image.file(File(archivoImagen!.path)),label: "Imagen a traducir",),
                const SizedBox(height: 20),
                // Funcion que regresa los widgets de la seleccion de imagen
                _botonesSeleccionarImg(),
                const SizedBox(height: 20),
                // Si se esta realizando un escaneo, en el momento mostramos un indicador circular de progreso
                if (escaneoTexto) CircularProgressIndicator(color: AppTheme.primary,),
                // Semantics para que el lector de pantalla puede leer la imagen con la etiqueta label
                Semantics(child: _salidaTexto(false),label: "Texto recuperado de imagen",),
                const Divider(),
                // Semantics para que el lector de pantalla puede leer la imagen con la etiqueta label
                Semantics(child: _salidaTexto(true),label: "Sección de texto en Braille",),
                // Boton de gusrdar traduccion
                _guardarTraduccion(),
              ],
            )
          ),
        )
      ),
    );
  }

  // *                                        FUNCIONES DE INTERFAZ
  // Funcion que muestra las instrucciones de uso de la interfaz de traduccion de imagenes
  void _mostrarDialogo(){
    showDialog(
      context: context, 
      builder: (BuildContext context) => 
      CustomPopUp(
        title: 'Traduccion de Imagenes', 
        content: const Text('Haga click en el botón de galería para seleccionar una imagen de su dispositivo.\nHaga click en el botón de cámara para abrirla y tomar foto de su texto a traducir.\nPodrá ver una sección de su texto extraído en la parte de abajo, así como del texto ya traducido.\nHaga click en el botón de guardar, para guardar el texto en sus registros.',
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

  // Funcion que despliega los botones de Galeria y Camara
  Widget _botonesSeleccionarImg(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [ 
        // Boton customizable de Galeria
        CustomButton(
        buttontext: 'Galería', 
        onPressedFunction: () {
          // Llamamos a la funcion de obtener una imagen de la galeria
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
        // Boton customizable de Camara
        CustomButton(
          buttontext: 'Cámara', 
          onPressedFunction: () {
            // Llamamos a la funcion de obtener una imagen haciendo uso de la camara
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

  // Funcion que regresa el boton de guardado de traduccion
  Widget _guardarTraduccion(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomButton(
          buttontext: 'Guardar', 
          onPressedFunction: () {
            if(_textoEscaneado.isNotEmpty) {
              // Llamamos al popup que guarda la traduccion
              _popUpGuardarTexto();
            }
          },
          padHButton: 20, 
          padVButton: 20,
          iconData: Icons.save_rounded,
          iconSize: 30,
        ),
      ]
    );
  }
  
  // Funcion de salida de texto que recibe un booleano para modificar su comportamiento
  Widget _salidaTexto(bool braile) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextField(
        maxLines: 5,
        autocorrect: true,
        enabled: false,
        // Si el booleano es verdadero se despliega el texto en braille
        style: braile ? 
        const TextStyle(fontFamily: 'Braille6-ANSI', fontSize: 20, height: 1.5): 
        // Si el booleano es falaso se despliega el texto con la fuente normal
        const TextStyle(fontSize: 20, height: 1.5),
        decoration: InputDecoration(
          hintStyle: const TextStyle(color: Colors.black),
          hintText: 
          // Si el booleano es verdadero se aplican las reglas del braille para mostrar asi el texto
          braile ?
          aplicarReglas(_textoEscaneado):
          // Si el booleano es falso solo de despliega el texto normal
          _textoEscaneado,
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
  // Funcion para obtener la imagen de la camara o de la galeria
  void _obtenerImagen(ImageSource source) async {
    try {
      // Se selecciona la imagen 
      final imagenSeleccionada = await ImagePicker().pickImage(source: source);
      if (imagenSeleccionada != null) {
        escaneoTexto = true;
        archivoImagen = imagenSeleccionada;
        setState(() {});
        // se llama la funcion del escaneo de texto y se le pasa la imagen
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
  // Funcion para obtener el texto reconocido
  void _obtenerTextoReconocido(XFile imagen) async {
    // La imagen se convierte en un input image que requiere el detector del google ml kit
    final imagenEntrada = InputImage.fromFilePath(imagen.path);
    // Creamos una instancia del detector de texto de google
    final detectorTexto = GoogleMlKit.vision.textDetector();
    // Procesamos la imagen de entrafa y reconocemos el texto
    RecognisedText textoReconocido = await detectorTexto.processImage(imagenEntrada);
    // cerramos el detector de texto
    await detectorTexto.close();

    // Limpiamos la variable del texto escaneado y lo comenzamos a procesar para sacar los bloques de texto y las lineas que lo componen
    _textoEscaneado = "";
    for (TextBlock bloque in textoReconocido.blocks) {
      for (TextLine linea in bloque.lines) {
        _textoEscaneado = _textoEscaneado + linea.text + "\n";
      }
    }
    escaneoTexto = false;
    setState(() {});
    // paramos el escaneo del booleano y actualizamos el estado del widget
  }
  // *                                        FUNCIONES DE ESCANEO DE TEXTO


  // *                                        FUNCIONES DE FUNCIONALIDAD SOLUCION
  
  // Funcion que abre el PopUp de guardar texto
  void _popUpGuardarTexto() {
    showDialog(
      context: context,
      builder: (BuildContext context) => CustomPopUp(
        title: 'Guardar Traducción',
        content: Form(
          key: _key,
          child: Column(
            children: [
              // Campo de captura del nombre de la traduccion
              TextFieldForm(
                labelText: 'Nombre Traduccion',
                hintText: 'Ingrese el nombre',
                icon: Icons.app_registration_rounded,
                obscureText: false,
                validator: validarVacio, // validador
                hasNextFocus: true,
                controller: guardarTituloController, // controlador
              ),
              // Campo de captura de la descrripcion de la traduccion
              TextFormField(
                maxLines: 3, // maximo lineas
                maxLength: 100, // maximo caracteres
                validator: validarVacio, // validador
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
                autocorrect: true,
                controller: guardarDescripcionController, // controlador
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
        // Cuando se guarda se tiene que validar el formulario y verificamos que si haya un texto escaneado, de esta manera bloqueamos el boton si no hay un escaneo previo
        onPressedFunction: () {
          if (_textoEscaneado.isNotEmpty) {
            if (_key.currentState!.validate()){
              // Se guarda el texto y nos pasamos a la pagina de traducciones guardadas
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