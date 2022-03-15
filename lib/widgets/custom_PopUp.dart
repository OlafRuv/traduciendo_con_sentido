// ignore: file_names
import 'package:flutter/material.dart';
import 'package:tcs/theme/app_theme.dart';

// Este es un widget sencillo que nos ayuda a estandarizar los popups con los que se cuenta en la aplicacion
class CustomPopUp extends StatelessWidget {
  final String title;
  final String message;
  final String buttonText;
  final Function()? onPressedFunction;

  // El popup recibe como parametros el titulo el mensaje y el texto del boton del popup
  const CustomPopUp({
    Key? key, 
    required this.title, 
    required this.message, 
    required this.buttonText, 
    this.onPressedFunction
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog( //  Se construye el popup y se regresa como un alert dialog
    title: Text(title),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(message),
      ],
    ),
    actions: [
      TextButton(
        // Cuando se presiona se ejecuta la funcion que nos manda el usuario como parametro
        onPressed: onPressedFunction,
        child: Text(
          buttonText,
          style: TextStyle(
            color: 
            AppTheme.primary),
        ),
      ),
    ],
  );
  }
}