import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tcs/utils/validators.dart';
import 'package:tcs/widgets/widgets.dart';

class TraducirTextoPage extends StatefulWidget {
  const TraducirTextoPage({Key? key}) : super(key: key);

  @override
  _TraducirTextoPageState createState() => _TraducirTextoPageState();
}

class _TraducirTextoPageState extends State<TraducirTextoPage> {
  final guardarTextoController = TextEditingController();
  final guardarTituloControllerPopUp = TextEditingController();
  final guardarDescripcionController = TextEditingController();

  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  String _enteredText = '';
  String _brailleText = '';
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
        title: const Text('TRADUCIR TEXTO'),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                _entradaTexto(),
                const Divider(),
                _salidaBraile(),
                _botones(),
              ],
            ),
          )
        ],
      ),

      // bottomNavigationBar: const CustomBottomNavigation(botonBarraActual: 0),
    );
  }

  Padding _salidaBraile() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextField(
        maxLines: 5,
        autocorrect: true,
        enabled: false,
        style: const TextStyle(
            fontFamily: 'braile_font', fontSize: 20, height: 1.5),
            // fontFamily: 'Braille6-ANSI', fontSize: 20, height: 1.5),
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
        // style: TextStyle(fontFamily: 'braile_font'),
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

  void _showDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) => CustomPopUp(
            title: 'Traduccion de Texto Plano',
            content: const Text(
                'Haga click en el cuadro de texto para teclear su texto deseado y usar los botones para traducir o guardar traduccion',
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 20)),
            buttonText: 'Continuar',
            onPressedFunction: () {
              Navigator.pop(context);
            }));
  }

  Widget _botones() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomButton(
            buttontext: 'Traducir',
            onPressedFunction: () {
              _brailleText = _enteredText;
              setState(() {});
            },
            padHButton: 20,
            padVButton: 20),
        const SizedBox(
          width: 10.0,
        ),
        CustomButton(
          buttontext: 'Guardar',
          onPressedFunction: () {
            // showDialog( //ALERTA DIALOG QUE NOS SERVIRA PARA ALERTAR AL USUARIO QUE SE GUARDO CON EXITO SU TEXTO
            popUpGuardarTexto();
          },
          padHButton: 20,
          padVButton: 20,
        ),
      ],
    );
  }

  // TODO: Integrar la descripcion al registro de FIREBASE
  Future<void> escrituraFirestore(
      String guardarTextoFirestore, String guardarTituloFirestore, String guardarDescripcionFirestore) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    String identificadorCorreo = auth.currentUser!.email.toString();
    String identificadorUid = auth.currentUser!.uid.toString();
    CollectionReference coleccionUsuarios =
        FirebaseFirestore.instance.collection('usuarios');

    coleccionUsuarios.add({
      'Titulo': 
          guardarTituloFirestore,
      'Texto_guardado':
          guardarTextoFirestore, //INGRESA EN EL CAMPO TEXTO GUARDADO NUESTRO TEXTO A GUARDAR
      'Descripción':  
          guardarDescripcionFirestore,
      'Nombre_usuario': 
          identificadorCorreo, //INGRESA EN EL CAMPO NOMBRE USUARIO NUESTRO USUARIO (CORREO)
      'Uid':
          identificadorUid, //INGRESA EN EL CAMPO UID NUESTRO IDENTIFICADOR DE USUARIO
    });

    return;
  }

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
                    controller: guardarTituloControllerPopUp,
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
                      setState(() {
                        //guardarDescripcionController.text = value;
                      });
                    },
                  ),
                ],
              ),
            ),
            buttonText: 'Guardar',
            onPressedFunction: () {
              if (_key.currentState!.validate()){
                escrituraFirestore(guardarTextoController.text,
                  guardarTituloControllerPopUp.text, guardarDescripcionController.text);
                Navigator.pushNamed(context, 'traducciones_guardadas');
              }
            }));
  }
}