import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:file_picker/file_picker.dart';
import 'package:pdf_text/pdf_text.dart';

import 'package:TCS/models/models.dart';
import 'package:TCS/utils/utils.dart';
import 'package:TCS/theme/app_theme.dart';
import 'package:TCS/widgets/widgets.dart';

class TraducirDocumentosPage extends StatefulWidget {
  const TraducirDocumentosPage({Key? key}) : super(key: key);
  @override
  _TraducirDocumentosPageState createState() => _TraducirDocumentosPageState();
}

// * Pagina de traduccion de documentos
class _TraducirDocumentosPageState extends State<TraducirDocumentosPage> {
  // controladores
  final guardarTituloController = TextEditingController();
  final guardarDescripcionController = TextEditingController();

  // key
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  // variables que se usaran en la pagina
  String _texto = "";
  String _textoCortado = "";
  String _textoDescripcion = "";
  int _tamanio = 0;
  PDFDoc? _pdfDoc;
  bool _activo = false;

  @override
  void initState() {
    super.initState();
    Future(_showDialog);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Barra de encabezado de la pagina de traducir documentos
      appBar: AppBar(
        title: const Text('TRADUCIR DOCUMENTOS'),
      ),
      body: Stack(
        children: [
          // Singelchildscrollview es para el scroll en la pagina
          SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  // Boton de seleccionar archivo
                  child: _botonSeleccionarArchivo(),
                ),
                Text(
                  'TEXTO DE EJEMPLO TRADUCIDO',
                  style: TextStyle(color: AppTheme.primary, fontSize: 20.0),
                ),
                Padding(
                  // En este padding mostraremos cosas diferentes abtes y despues del scaneo de texto
                  child: Text(
                    // Este ignore solo evita un warning
                    // ignore: prefer_is_empty
                    _texto.length == 0
                      ? "Seleccione su PDF y espere a que cargue..."
                      : "PDF cargado, $_tamanio página\n",
                    style: const TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                  padding: const EdgeInsets.only(top: 10.0)
                ),
                // Semantics hace que el cuadro se pueda leer por el lector de pantalla
                Semantics( 
                  // Cuadro de salida de muestra de texto traducido
                  child: _salidaTexto(true),
                  label: "Vista de texto traducido en braille",
                ),
                _botones(),
              ],
            ),
          ),
        ],
      ),
    );
  }
  

  // *                                        FUNCIONES DE SELECCION DE PDF
  // Funcion para tomar el pdf de los archivos del celular
  Future _pickPDFText() async {
    try {
      // Variable que almacena el resultado del filepicker
      var filePickerResult = await FilePicker.platform.pickFiles();
      if (filePickerResult != null) {
        // Si si se logra recoger un resultado se recoge un pdf de esa direccion
        _pdfDoc = await PDFDoc.fromPath(filePickerResult.files.single.path!);
        setState(() {});
      }
      if (_pdfDoc == null) {
        return;
      }
      // Le sacamos el texto a ese pdf
      _texto = await _pdfDoc!.text;
      // Le sacamos el tamanio de hojas 
      _tamanio = _pdfDoc!.length;
      // Procesamos el texto para mostrarlo y le aplicamos las reglas del braille
      _textoCortado = _texto.replaceAll("\n", " ");
      _textoCortado = aplicarReglas(_textoCortado);
      setState(() {});
      // Mostrar el resultado del texto en popup
      _showResult(_texto);
    } catch (e) {
      _textoCortado = "Ocurrió un Error al Escanear";
      setState(() {});
    }
  }

  // Funcion que abre un pop up con el texto que le pasamos
  void _showResult(String text) {
    showDialog(
      context: context, 
      builder: (BuildContext context) => 
      CustomPopUp(
        title: 'Texto Extraído',
        buttonText: 'Ok',
        onPressedFunction: (){ 
          _activo = true;
          Navigator.pop(context); 
        },
        content: Text(text),
      ),
    );
  }
  // *                                        FUNCIONES DE SELECCION DE PDF

  // *                                        FUNCIONES DE INTERFAZ
  // Funcion que muestra las instrucciones de uso de la interfaz de traduccion de documentos
  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) => CustomPopUp(
        title: 'Traduccion de Documentos',
        content: const Text(
          'Haga click en el botón de seleccionar archivo para seleccionar un PDF de su dispositivo.\nSe abrirá un cuadro de alerta con el texto extraído.\nUna vez cerrado el cuadro de alerta observará una sección de su texto ya traducido.\nHaga click en el botón de guardar, para guardar el texto en sus registros o haga click en el botón de imprimir para seleccinar la opción de descarga que más le convenga. \n(Esta opción también creará el registro)',
          textAlign: TextAlign.justify,
          style: TextStyle(fontSize: 20),
        ),
        buttonText: 'Continuar',
        onPressedFunction: () {
          Navigator.pop(context);
        }
      )
    );
  }

  // Funcion que despliega el boton de seleccion de archivo
  _botonSeleccionarArchivo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center, 
      children: [
        CustomButton(
          buttontext: 'Seleccionar Archivo',
          onPressedFunction: _pickPDFText, // LLama a la funcion de tomar un pdf
          padHButton: 20,
          padVButton: 20,
          iconData: Icons.folder_open_rounded,
          iconSize: 30,
        ),
      ]
    );
  }

  // Funcion que despliega los botones de guardado de traduccion y de descarga de traduccion
  Widget _botones() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomButton(
          buttontext: 'Guardar',
          onPressedFunction: (){
            if (_activo){
              // Llamamos al pop up de guardado de texto
              _popUpGuardarTexto(true);
            }
          },
          padHButton: 20,
          padVButton: 20,
          iconData: Icons.save_rounded,
          iconSize: 30,
        ),
        const SizedBox(width: 10),
        CustomButton(
          buttontext: 'Descargar',
          onPressedFunction: (){
            if (_activo){
              // Llamammos al popup de guardado de texto
              // el parametro false modifica su comportamiento para que tambien se descargue el documento
              _popUpGuardarTexto(false);
            }
          },
          padHButton: 20,
          padVButton: 20,
          iconData: Icons.download_for_offline_rounded,
          iconSize: 30,
        ),
      ],
    );
  }

  // Funcion que despliega la salida de texto traducido
  Widget _salidaTexto(bool braile) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextField(
        maxLines: 5,
        autocorrect: true,
        enabled: false,
        style: 
          braile
          ? const TextStyle(
            // Usamos el estandar de Braille6-ANSI que propone ONCE para el braille
            fontFamily: 'Braille6-ANSI', fontSize: 20, height: 1.5)
          : const TextStyle(fontSize: 20, height: 1.5),
        decoration: InputDecoration(
          hintStyle: const TextStyle(color: Colors.black),
          hintText: _textoCortado, // Mostramos el texto cortado
          border: const OutlineInputBorder(),
          focusedBorder: const OutlineInputBorder(),
          disabledBorder: const OutlineInputBorder(),
          enabledBorder: const OutlineInputBorder(),
        ),
      ),
    );
  }
  // *                                        FUNCIONES DE INTERFAZ

  // *                                        FUNCIONES DE FUNCIONALIDAD SOLUCION
  // Funcion de descargar traduccion
  void _descargar(String titulo, String contenido){
    showDialog(
      context: context, 
      builder: (BuildContext context) => 
      CustomPopUp(
        // Elementos del PopUp
        title: 'Seleccione una opción',
        buttonText: 'Cancelar',
        onPressedFunction: (){
          Navigator.pop(context);
        },
        content: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(             // * Opcion de descarga de PDF
              onPressed: (){
                Navigator.pop(context);
                crearPDF(titulo, contenido); // Se llama a esta funcion de CrearPDF
              }, 
              child: const Text('Descargar PDF',
              style: TextStyle(
                fontSize: AppTheme.size18,
                color: Colors.black,)
                )
              ),
            const Divider(),
            TextButton(             // * Opcion de descarga de PDF espejo
              onPressed: (){
                Navigator.pop(context);
                crearPDF2(titulo, contenido); // Se llama a esta funcion de CrearPDF2
              },  
              child: const Text('Descargar PDF espejo',
              style: TextStyle(
                fontSize: AppTheme.size18,
                color: Colors.black,),
              ),
            ),
            const Divider(), 
            TextButton(             // * Opcion de descarga de archivo de .BRF
              onPressed: (){
                Navigator.pop(context);
                crearMostrarBrf(contenido,titulo); // Se llama a esta funcion de CrearMostrarBRF
              }, 
              child: const Text('Descargar .brf',
              style:  TextStyle(
                fontSize: AppTheme.size18,
                color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Funcion que abre el PopUp de guardar texto, el booleano que recibe cambia su comportamiento
  void _popUpGuardarTexto(bool opc) {
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
                maxLengthEnforcement: MaxLengthEnforcement.enforced, // forzamos el tamaño del ingreso de texto
                autocorrect: true,
                controller: guardarDescripcionController, // controlador
                decoration: InputDecoration(
                  hintText: 'Introduzca su descripcion\nMáximo 100 palabras',
                  counterText: '${_textoDescripcion.length.toString()}/100 Carácteres',
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
        // Cuando se guarda se tiene que validar el formulario, despues de eso en base al bolleano hay 2 comportamientos
        onPressedFunction: () { 
          if (_key.currentState!.validate()) {
            if(opc){
              // Se guarda el texto y nos pasamos a la pagina de traducciones guardadas
              escrituraFirestore(_texto,guardarTituloController.text, guardarDescripcionController.text);
              Navigator.pushNamed(context, 'traducciones_guardadas');
            } else{
              // Se guarda el texto, se hace pop del popup, nos pasamos a la parte de traducciones guardadas y ejecutamos la funcion de descargar la traduccion
              escrituraFirestore(_texto,guardarTituloController.text, guardarDescripcionController.text);
              Navigator.pop(context); 
              Navigator.pushNamed(context, 'traducciones_guardadas');
              _descargar(guardarTituloController.text,_texto);
            }
          }
        }
      )
    );
  }
  // *                                        FUNCIONES DE FUNCIONALIDAD SOLUCION

}
