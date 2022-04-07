import 'package:flutter/material.dart';
import 'package:tcs/theme/app_theme.dart';

// Este widget nos sirve como plantilla para todos los campos de captura de credenciales con los que cuenta la aplicacion
class TextFieldForm extends StatelessWidget {
  final TextEditingController? controller;
  final IconData? icon;
  final Widget? suffixicon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final String? hintText;
  final String? labelText;
  final String? Function(String?) validator;
  final TextInputAction? action;
  final bool hasNextFocus;
  // Se reciben muchos parametros, los cuales foman los campos de entrada de texto del usuario, estos campos pueden ser oblogatorios u opcionales

  const TextFieldForm({ // Se construye el campo de texto 
    Key? key, 
    this.controller, 
    this.icon, 
    this.suffixicon, 
    required this.obscureText, 
    this.keyboardType, 
    this.hintText, 
    this.labelText, 
    required this.validator, 
    this.action, 
    required this.hasNextFocus
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container( // El text form field va dentro de un container
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0
      ),
      child: TextFormField( // Se le asignan las caracteristicas que pueden o no venir como parametros
        focusNode: FocusNode(canRequestFocus: false),
        keyboardType: keyboardType,
        controller: controller,
        style: const TextStyle(color: Colors.black),
        obscureText: obscureText,
        onEditingComplete: () {
          if (hasNextFocus) {
            FocusScope.of(context).nextFocus();
          } else {
            FocusScope.of(context).unfocus();
          }
        },
        textInputAction: action,
        validator: validator,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          hintText: hintText,
          labelText: labelText,
          suffixIcon: suffixicon,
          icon: Icon(icon, color: AppTheme.primary,),
        ),
      ),
    );
  }
}