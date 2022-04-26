import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tcs/models/braille_rules.dart';
import 'package:tcs/utils/guardar_traduccion.dart';
import 'package:tcs/utils/validators.dart';
import 'package:tcs/widgets/widgets.dart';

class TraducirTextoPage extends StatefulWidget {
  const TraducirTextoPage({Key? key}) : super(key: key);

  @override
  _TraducirTextoPageState createState() => _TraducirTextoPageState();
}

class _TraducirTextoPageState extends State<TraducirTextoPage> {
  final guardarTextoController = TextEditingController();
  final guardarTituloController = TextEditingController();
  final guardarDescripcionController = TextEditingController();

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

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
        title: const Text('TRADUCIR TEXTO'),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                _entradaTexto(),
                const Divider(),

                Semantics(
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
  Padding _salidaBraile() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextField(
        maxLines: 5,
        autocorrect: true,
        enabled: false,
        style: const TextStyle(
            // fontFamily: 'braile_font', fontSize: 20, height: 1.5),
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

  Padding _entradaTexto() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextField(
        maxLines: 5,
        maxLength: 500,
        maxLengthEnforcement: MaxLengthEnforcement.enforced,
        autocorrect: true,
        controller: guardarTextoController,
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
            _enteredText = value;
          });
        },
      ),
    );
  }

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

  Widget _botones() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomButton(
          buttontext: 'Traducir',
          onPressedFunction: () {
            _brailleText = aplicarReglas(_enteredText);
            setState(() {});
          },
          padHButton: 20,
          padVButton: 20
        ),
        const SizedBox(
          width: 10.0,
        ),
        CustomButton(
          buttontext: 'Guardar',
          onPressedFunction: () {
            if(_enteredText.isNotEmpty){
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
  void popUpGuardarTexto() {
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
              TextField(
                maxLines: 3,
                maxLength: 100,
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
                autocorrect: true,
                controller:guardarDescripcionController,
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
        onPressedFunction: () {
          if (_key.currentState!.validate()){
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