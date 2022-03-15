import 'package:flutter/material.dart';
import 'package:tcs/theme/app_theme.dart';

// Creamos el widget de custom background que se utilizara en la mayoria de screens del scroll y primera pantalla de botones de la app
class CustomBackground extends StatelessWidget {
  final Widget title;
  final bool? reversed;

  //Definimos todos los parametros que el Widget recibirá, desde los forzados hasta los opcionales
  const CustomBackground({ //Constructor del Widget
    Key? key, 
    required this.title, 
    this.reversed = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size; // Extraemos en la variable el tamaño de la pantalla
    final colorFondo = Container( // Creamos un contenedor
      height: size.height,
      width: double.infinity,
      decoration: _isReversedDecoration(reversed!), //La opcion de reversed nos define de que a que lado ira el degradado del fondo, esto para un estilo interesante de las scroll pages
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

    return Stack( // Para crear el fondo agrupamos en un Stack el fondo de degradado que creamos y varios circulos, además del titulo de la página que al ser un widget puede se un logo o algun texto con formato, o cualquier elemento que desee poner como titulo el usuario
      children: [
        colorFondo,
        Positioned( top: 90.0, left: 30.0, child: circuloFondo ),
        Positioned( top: -40.0, right: -30.0, child: circuloFondo ),
        Positioned( bottom: -50.0, left: -10.0, child: circuloFondo ),
        Positioned( top: 300.0, right: -10.0, child: circuloFondo ),
        Positioned( bottom: 1.0, left: 20.0, child: circuloFondo ),
        Positioned( top: 500, right: -50, child: circuloFondo ),
        
        Column(
          children: [
            title,
            const SizedBox(
              height: 10.0, 
              width: double.infinity
            ),
          ],
        )
      ],
    );
  }

  // Nuestra regla de reverse que especifica de donde a donde va el degradado del fondo 
  Decoration? _isReversedDecoration(bool reversed){
    if (reversed == true){
      return BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.grad2,
            AppTheme.grad1,
          ]
        )        
      );
    }
    else {
      return BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.grad1,
            AppTheme.grad2,
          ]
        )        
      );
    }
     
  }
}