import 'package:flutter/material.dart';

class CustomBottomNavigation extends StatefulWidget {
  final int botonBarraActual;
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
      unselectedItemColor: Colors.grey,
      backgroundColor: Colors.white,
      selectedItemColor: Colors.green[800],
      onTap: (index){
        setState(() {
          // TODO: Hacer que la ruta no se se
          Navigator.pushNamed(context, listaPaginas[index]);
        });
      },
      items: const [
      BottomNavigationBarItem(
        icon: Icon(
          Icons.home,
          size: 30.0,
        ),
        label: 'Inicio',
      ),
      BottomNavigationBarItem(
        icon: Icon(
          Icons.list_alt,
          size: 30.0,
        ),
        label: 'Trad. Guardadas',
      ),
      BottomNavigationBarItem(
        icon: Icon(
          Icons.supervised_user_circle,
          size: 30.0,
        ),
        label: 'Configuracion',
      )
    ]);
  }
}