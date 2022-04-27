import 'package:flutter/material.dart' show IconData, Widget;

// * Modelo de opciones de menu
// Se usa en el enrutador, se creo así por el uso de los iconos en la navegación
class MenuOption {
  final String route;
  final IconData icon;
  final String name;
  final Widget screen;

  MenuOption( {
    required this.route, 
    required this.icon, 
    required this.name, 
    required this.screen
    });

}







