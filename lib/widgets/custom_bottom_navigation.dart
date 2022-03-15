import 'package:flutter/material.dart';
import 'package:tcs/theme/app_theme.dart';

//Este es nuestro widget de los botones de navegacion al pie de página personalizados
class CustomBottomNavigation extends StatefulWidget {
  final int botonBarraActual;
  // Definimos el boton actual en el que nos encontramos
  const CustomBottomNavigation(
    {Key? key, required this.botonBarraActual}) : super(key: key);

  @override
  State<CustomBottomNavigation> createState() => _CustomBottomNavigationState();
}

class _CustomBottomNavigationState extends State<CustomBottomNavigation> {
  List listaPaginas = [
    //Se usara para tomar la posicion del string y usarlo en el navigator
    'menu',
    'traducciones_guardadas',
    'configuracion',
  ];

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: widget.botonBarraActual,
      onTap: (index){
        setState(() {
          // TODO: Hacer que la ruta no sea de esta manera, buscar solución
          Navigator.pushNamed(context, listaPaginas[index]);
        });
      },
      items: [
        // Creamos los items que tendremos en nuestra barra de navegación, los cualesllevan Icono etiqueta y ruta a la qie te redirigen
      _item(ico: Icons.home_filled , labelItem:  'Inicio'),
      _item(ico: Icons.list_alt , labelItem:  'Trad. Guardadas'),
      _item(ico: Icons.supervised_user_circle , labelItem:  'Configuracion'),
    ]);
  }

  // Definimos la estructura de los items que tendremos en nuestra barra de navegación
  BottomNavigationBarItem _item({required IconData ico, required String labelItem}) {
    return BottomNavigationBarItem(
      icon: Icon(
        ico,
        size: AppTheme.iconSize,
      ),
      label: labelItem,
    );
  }
}