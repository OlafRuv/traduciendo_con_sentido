import 'package:flutter/material.dart';
import 'package:TCS/theme/app_theme.dart';


// Este es el widget de nuestro boton personalizado, este widget es nuestra platilla para algunos de los botones de la aplicacion
class CustomButton extends StatefulWidget {
  final String buttontext;
  final double? textSize;
  final Function()? onPressedFunction;
  final Color? colorButton;
  final double? elevationButton;
  final double padHButton;
  final double padVButton;
  final IconData? iconData;
  final double? iconSize;
  // Tenemos paramtros que sreá forzoso recibirlos y un par de otros que seran opcionales

 // Algunos de los parametros opcionales, se inicializan en el constructor del mismo widget
  const CustomButton({
    Key? key, 
    required this.buttontext, 
    required this.onPressedFunction, 
    this.colorButton, 
    this.elevationButton, 
    required this.padHButton, 
    required this.padVButton, 
    this.iconData, 
    this.iconSize = 0, 
    this.textSize = AppTheme.size20,
  }) : super(key: key);

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      // Creamos el boton a partir de las caracteristicas recibidas en la plantilla
      style: ElevatedButton.styleFrom(
        primary: widget.colorButton,
        elevation: widget.elevationButton,
        padding: EdgeInsets.symmetric(
          horizontal: widget.padHButton,
           vertical: widget.padVButton),
      ),
      child: _hasAnIcon(widget.iconData),
      // Revisamos en una funcion propia de la clase si se le mando icono al boton, dado a que este cambia la estructura del boton
      onPressed: widget.onPressedFunction,
      // Cuando se presiona se ejecuta la funcion que nos mandan
    );
  }

// Funcion que revisa si tiene un icono 
  Widget? _hasAnIcon(IconData? icon){
    // Si tiene icono se crea una fila y se aniade el icono a la derecha
    if (icon != null){
      return Row(
        children: [ 
          Icon(widget.iconData,
            size:widget.iconSize
          ),
          const SizedBox(width: 10.0,),
          Text(
          widget.buttontext, 
          style: TextStyle(
            fontSize: widget.textSize),
          ),
        ]
      );
    } // si no hay icono solo se inseta el texto del boton
    else{
      return Text(
        widget.buttontext, 
        style: const TextStyle(
          fontSize: AppTheme.size20
        ),
      );
    }
  }
}