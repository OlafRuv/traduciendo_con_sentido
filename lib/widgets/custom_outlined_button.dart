import 'package:flutter/material.dart';

// Este es un widget sencillo de un Boton con estilo de outlined
class CustomOutlinedButton extends StatelessWidget {
  final String textContent;
  final double textSize;
  final String route;
  // EL botno recibe estos parametros forzosamente requeridos
  const CustomOutlinedButton({
    Key? key, 
    required this.textContent, 
    required this.textSize, 
    required this.route
  }) : super(key: key);

  @override
  Widget build(BuildContext context){
    //Aqui se contruye y regresa el boton
    return OutlinedButton(
      onPressed: (){
        Navigator.pushNamed(context, route);
      }, 
      child: Text(
        textContent,
        style: TextStyle(
          fontSize: textSize),
      )
    );
  }
}