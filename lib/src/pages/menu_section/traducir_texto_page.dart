import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:TCS/utils/utils.dart';
import 'package:TCS/models/models.dart';
import 'package:TCS/widgets/widgets.dart';

class TraducirTextoPage extends StatefulWidget {
  const TraducirTextoPage({Key? key}) : super(key: key);

  @override
  _TraducirTextoPageState createState() => _TraducirTextoPageState();
}

// * Pagina de traduccion de texto plano
class _TraducirTextoPageState extends State<TraducirTextoPage> {
  //controladores
  final guardarTextoController = TextEditingController();
  final guardarTituloController = TextEditingController();
  final guardarDescripcionController = TextEditingController();
  // formkey
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  //  variables dentro de la interfaz
  String _enteredText = "";
  String _brailleText = "";

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
        title: const Text('TRADUCIR TEXTO'),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            // Singlechildscrollview hace la pagina scrolleable
            child: Column(
              children: [
                // Funcion que regresa widget de etrada de texto
                _entradaTexto(),
                const Divider(),
                // Semantics para que el lector de pantalla puede leer la imagen con la etiqueta label que le asignamos
                Semantics(
                  // Funcion que regresa widget de salida de texto traducido
                  child: _salidaBraile(),
                  label: "Vista de texto traducido en braille",
                ),
                _botones(),
              ],
            ),
          )
        ],
      ),
    );
  }

  // *                                        FUNCIONES DE INTERFAZ
  // Funcion que regresa widget de salida de teto traducido
  Padding _salidaBraile() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextField(
        maxLines: 5,
        autocorrect: true,
        enabled: false,
        style: const TextStyle(
            fontFamily: 'Braille6-ANSI', fontSize: 20, height: 1.5),
        decoration: InputDecoration(
          hintStyle: const TextStyle(color: Colors.black),
          hintText: _brailleText,
          border: const OutlineInputBorder(),
          focusedBorder: const OutlineInputBorder(),
          disabledBorder: const OutlineInputBorder(),
          enabledBorder: const OutlineInputBorder(),
        ),
      ),
    );
  }

  // Funcion que regresa widget de entrada de texto
  Padding _entradaTexto() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextField(
        // forzamos lineas de texto y caracteres maximos
        maxLines: 5,
        maxLength: 500,
        maxLengthEnforcement: MaxLengthEnforcement.enforced,
        autocorrect: true,
        controller: guardarTextoController, // controlador
        decoration: InputDecoration(
          hintText: 'Introduzca su texto\nMáximo 500 palabras',
          helperText: 'Cuando termine puede\nTraducir o Guardar',
          counterText: '${_enteredText.length.toString()}/500 Carácteres',
          border: const OutlineInputBorder(),
          focusedBorder: const OutlineInputBorder(),
          disabledBorder: const OutlineInputBorder(),
          enabledBorder: const OutlineInputBorder(),
        ),
        onChanged: (value) {
          setState(() {
            // el valor se guarda en esta variable
            _enteredText = value;
          });
        },
      ),
    );
  }

  // Funcion que muestra las instrucciones de uso de la interfaz de traduccion de texto
  void _mostrarDialogo() {
    showDialog(
      context: context,
      builder: (BuildContext context) => CustomPopUp(
        title: 'Traduccion de Texto Plano',
        content: const Text(
          'Haga click en el cuadro para ingresar su texto a traducir, use los botones para traducir o guardar la traducción.\nEn el segundo cuadro se mostrará la traducción efectuada.',
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

  // Funcion que muestra los botones de la interfaz
  Widget _botones() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Boton cutomizable de traduccion de texto
        CustomButton(
          buttontext: 'Traducir',
          onPressedFunction: () {
            // Este boton aplica las reglas del braile
            _brailleText = aplicarReglas(_enteredText);
            //actualiza el estado
            setState(() {});
          },
          padHButton: 20,
          padVButton: 20
        ),
        const SizedBox(
          width: 10.0,
        ),
        // Boton cutomizable de guardado de traduccion
        CustomButton(
          buttontext: 'Guardar',
          onPressedFunction: () {
            if(_enteredText.isNotEmpty){
              // Validamos que exista una traduccion y se llama el pop up de guardado de texto
              popUpGuardarTexto();
            }
          },
          padHButton: 20,
          padVButton: 20,
        ),
      ],
    );
  }
  // *                                        FUNCIONES DE INTERFAZ


  // *                                        FUNCIONES DE FUNCIONALIDAD SOLUCION
  // Funcion que abre el PopUp de guardar texto
  void popUpGuardarTexto() {
    showDialog(
      context: context,
      builder: (BuildContext context) => CustomPopUp(
        title: 'Guardar Traducción',
        content: Form(
          // Key del form
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
              TextField(
                // Validamos maximo de lineas, tamanio de caraccteres y los forzamos
                maxLines: 3,
                maxLength: 100,
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
                autocorrect: true,
                controller:guardarDescripcionController, // controlador
                decoration: InputDecoration(
                  hintText: 'Introduzca su descripcion\nMáximo 100 palabras',
                  counterText:
                    '${guardarDescripcionController.text.length.toString()}/100 Carácteres',
                  border: const OutlineInputBorder(),
                  focusedBorder: const OutlineInputBorder(),
                  disabledBorder: const OutlineInputBorder(),
                  enabledBorder: const OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {});
                },
              ),
            ],
          ),
        ),
        buttonText: 'Guardar',
        // Cuando se guarda se tiene que validar el formulario y verificamos que si haya un texto escaneado, de esta manera bloqueamos el boton si no hay un escaneo previo
        onPressedFunction: () {
          if (_key.currentState!.validate()){
            // Se guarda el texto y nos pasamos a la pagina de traducciones guardadas
            escrituraFirestore(guardarTextoController.text,
              guardarTituloController.text, guardarDescripcionController.text);
            Navigator.pushNamed(context, 'traducciones_guardadas');
          }
        }
      )
    );
  }
  // *                                        FUNCIONES DE FUNCIONALIDAD SOLUCION
}