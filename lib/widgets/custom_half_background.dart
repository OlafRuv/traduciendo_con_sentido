import 'package:flutter/material.dart';
import 'package:TCS/theme/app_theme.dart';

// Creamos el widget decustom half backgorund que se usa en la mayoria de formularios para el inicio de sesion, recuperacion de credenciales y creacion de una nueva cuenta
class CustomHalfBackground extends StatelessWidget {
  final String title;
  const CustomHalfBackground({
    Key? key, 
    required this.title
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size; // Sacamos el tamanio de la pantalla
    final colorFondo = Container( // Creamos un contenedor
      height: size.height * 0.4, // Se usa el 40% de tamanio de la pantalla
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.grad1,
            AppTheme.grad2,
          ] // Se aplica un degradadod para el fondo
        )
      ),
    );

    // Creamos el widget de circulo, el cual consiste en un container que tiene forma de circulo u algo de opacidad
    final circuloFondo = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        color: const Color.fromRGBO(255, 255, 255, 0.05)
      )
    );

    return Stack(
      // Para crear el fondo agrupamos en un Stack el fondo de degradado que creamos y varios circulos, además del titulo de la página que al ser un widget puede se un logo o algun texto con formato, o cualquier elemento que desee poner como titulo el usuario
      children: [
        colorFondo,
        Positioned( top: 90.0, left: 30.0, child: circuloFondo ),
        Positioned( top: -40.0, right: -30.0, child: circuloFondo ),
        Positioned( bottom: -50.0, left: -10.0, child: circuloFondo ),
        
        Container(
          padding: const EdgeInsets.only(top: 80.0),
          child: Column(
            children: [
              const Icon( // Insertamos un icono propio de estos screens
                Icons.person_pin_circle, 
                color: Colors.white, 
                size: 100.0,
              ),
              const SizedBox(
                height: 10.0, 
                width: double.infinity
              ),
              Text(
                title, 
                style: const TextStyle(
                  color: Colors.white, 
                  fontSize: 25.0
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}