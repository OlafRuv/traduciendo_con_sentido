import 'package:tcs/models/models.dart';
import 'package:tcs/src/pages/alert_screen.dart';
import 'package:tcs/src/pages/pages.dart';
import 'package:flutter/material.dart';

// * Clase manejadora de rutas en el proyecto
// Esta clase hace uso del modelo de opciones de menu el cual nos forza a mandar el nombre de la ruta, 
// el icono que se usará en el caso de la implementacion de un menu con iconos, el nombre de la ruta y la pantalla a la que 
// apuntará la ruta, todo esto se define en una lista dentro de la clase
class AppRoutes{

  static const initialRoute = 'scroll';
  static final menuOptions = <MenuOption>[
    MenuOption(route: 'iniciar_sesion',         icon: Icons.account_box_rounded,        name: 'Inicio Sesion',          screen: const InicioSesionPage()),
    MenuOption(route: 'crear_sesion',           icon: Icons.add_circle_outline_rounded, name: 'Crear Sesion',           screen: CrearSesionPage()),
    MenuOption(route: 'traducir_texto',         icon: Icons.translate_rounded,          name: 'Traduccion Texto',       screen: const TraducirTextoPage()),
    MenuOption(route: 'traducir_documentos',    icon: Icons.document_scanner_rounded,   name: 'Traduccion Documentos',  screen: const TraducirDocumentosPage()),
    MenuOption(route: 'traducir_imagenes',      icon: Icons.image_rounded,              name: 'Traduccion Imagenes',    screen: const TraducirImagenesPage()),
    MenuOption(route: 'menu',                   icon: Icons.menu_book_rounded,          name: 'Menu',                   screen: const MenuPage()),
    MenuOption(route: 'traducciones_guardadas', icon: Icons.save_alt_rounded,           name: 'Traducciones Guardadas', screen: const TraduccionesGuardadasPage()),
    MenuOption(route: 'configuracion',          icon: Icons.settings_rounded,           name: 'Configuracion',          screen: const ConfiguracionPage()),
  ];

// * Funcion que regresa todas las rutas disponibles
// En base a la lista de rutas definidas
  static Map<String, Widget Function(BuildContext)> getAppRoutes() {
    Map<String, Widget Function(BuildContext)> appRoutes = {};
    appRoutes.addAll({'scroll':(BuildContext context) => const ScrollPage()});
    
    for (final option in menuOptions) {
        appRoutes.addAll({option.route:(BuildContext context) => option.screen});
    }

    return appRoutes;
  }

// * Esta es la funcion de generar ruta
// Esta función se usará para cuando la ruta a la que nos dirijamoes no este creada 
  static Route<dynamic> onGenerateRoute (RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => const AlertScreen(),
    );
  }

}