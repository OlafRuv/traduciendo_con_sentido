import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tcs/theme/app_theme.dart';
import 'package:tcs/utils/crear_brf.dart';
import 'package:tcs/utils/crear_pdf.dart';
import 'package:tcs/utils/guardar_traduccion.dart';
import 'package:tcs/utils/validators.dart';
import 'package:tcs/widgets/widgets.dart';
import 'package:file_picker/file_picker.dart';
import 'package:pdf_text/pdf_text.dart';

class TraducirDocumentosPage extends StatefulWidget {
  const TraducirDocumentosPage({Key? key}) : super(key: key);

  @override
  _TraducirDocumentosPageState createState() => _TraducirDocumentosPageState();
}

class _TraducirDocumentosPageState extends State<TraducirDocumentosPage> {
  final guardarTituloController = TextEditingController();
  final guardarDescripcionController = TextEditingController();

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

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
      appBar: AppBar(
        // textDirection: TextDirection.rtl,
        title: const Text('TRADUCIR DOCUMENTOS'),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: _botonSeleccionarArchivo(),
                ),
                Text(
                  'TEXTO DE EJEMPLO TRADUCIDO',
                  style: TextStyle(color: AppTheme.primary, fontSize: 20.0),
                ),
                Padding(
                  child: Text(
                    // ignore: prefer_is_empty
                    _texto.length == 0
                      ? "Seleccione su PDF y espere a que cargue..."
                      : "PDF cargado, $_tamanio página\n",
                    style: const TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                  padding: const EdgeInsets.only(top: 10.0)
                ),
                _salidaTexto(true),
                _botones(),
              ],
            ),
          ),
        ],
      ),
    );
  }
  

  // *                                        FUNCIONES DE SELECCION DE PDF
  Future _pickPDFText() async {
    try {
      var filePickerResult = await FilePicker.platform.pickFiles();
      if (filePickerResult != null) {
        _pdfDoc = await PDFDoc.fromPath(filePickerResult.files.single.path!);
        setState(() {});
      }
      if (_pdfDoc == null) {
        return;
      }
      _texto = await _pdfDoc!.text;
      _tamanio = _pdfDoc!.length;
      _textoCortado = _texto.replaceAll("\n", " ");
      setState(() {});
      _showResult(_texto);
    } catch (e) {
      _textoCortado = "Ocurrió un Error al Escanear";
      setState(() {});
    }
  }

  void _showResult(String text) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
            child: Text('Texto Extraido',
              textAlign: TextAlign.center, 
              style: TextStyle(
                fontSize: 24,
                color: AppTheme.primary,
              )
            ),
          ),
          content: Scrollbar(
            child: SingleChildScrollView(
              child: Text(text),
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
            ),
          ),
          actions: [
            Center(
              child: TextButton(
                child: Text('Ok',  
                  style: TextStyle(
                    color: AppTheme.primary,
                    fontSize: 20,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  _activo = true;
                },
              ),
            )
          ],
        );
      }
    );
  }
  // *                                        FUNCIONES DE SELECCION DE PDF

  // *                                        FUNCIONES DE INTERFAZ
  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) => CustomPopUp(
        title: 'Traduccion de Documentos',
        content: const Text(
          'Haga click en el boton de seleccionar para poder traducir su documento al cuadro de texto o mandar a imprimir',
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

  _botonSeleccionarArchivo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center, 
      children: [
        CustomButton(
          buttontext: 'Seleccionar Archivo',
          onPressedFunction: _pickPDFText,
          padHButton: 20,
          padVButton: 20,
          iconData: Icons.folder_open_rounded,
          iconSize: 30,
        ),
      ]
    );
  }

  Widget _botones() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomButton(
          buttontext: 'Guardar',
          onPressedFunction: (){
            if (_activo){
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
            fontFamily: 'braile_font', fontSize: 20, height: 1.5)
          : const TextStyle(fontSize: 20, height: 1.5),
        decoration: InputDecoration(
          hintStyle: const TextStyle(color: Colors.black),
          hintText: _textoCortado,
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
  void _descargar(String titulo, String contenido){
    showDialog(
      context: context, 
      builder: (BuildContext context) => 
      CustomPopUp(
        title: 'Seleccione una opción',
        buttonText: 'Cancelar',
        onPressedFunction: (){
          Navigator.pop(context);
        },
        content: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: (){
                Navigator.pop(context);
                crearPDF(titulo, contenido);
              }, 
              child: const Text('Descargar PDF',
              style: TextStyle(
                fontSize: AppTheme.size18,
                color: Colors.black,)
                )
              ),
            const Divider(),
            TextButton(
              onPressed: (){
                Navigator.pop(context);
                crearPDF2(titulo, contenido);
              },  
              child: const Text('Descargar PDF espejo',
              style: TextStyle(
                fontSize: AppTheme.size18,
                color: Colors.black,),
              ),
            ),
            const Divider(), 
            TextButton(
              onPressed: (){
                Navigator.pop(context);
                crearMostrarBrf(contenido,titulo);
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

  void _popUpGuardarTexto(bool opc) {
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
        onPressedFunction: () {
          if (_key.currentState!.validate()) {
            if(opc){
              escrituraFirestore(_texto,guardarTituloController.text, guardarDescripcionController.text);
              Navigator.pushNamed(context, 'traducciones_guardadas');
            } else{
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
