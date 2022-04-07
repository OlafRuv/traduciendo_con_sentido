import 'package:flutter/material.dart';

// * ARCHIVO DEL TEMA DE LA APLICACION
// Creamos un tema para la aplicacion

class AppTheme{
  // Variables generales
  static Color? primary = Colors.green[800];
  static const Color primaryDarker = Colors.green;
  static const Color bgColor = Colors.white;

  // Variables del titulo
  static const Color titleColor = Colors.black;
  static const double titleSize = 30.0;

  // Variables de bottom nav bar
  static const double iconSize = 30.0;

  // Variables de botones
  static const Color buttonTextColor = Colors.white;
  static Color? buttonColorv1 = primary;
  static Color? buttonColorv2 = Colors.redAccent[700];
  static const double size20 = 20.0;
  static const double size18 = 18.0;
  static const double size15 = 15.0;

  // Gradiente de Colores
  static Color grad1 = Colors.lightGreen;
  static Color grad2 = const Color.fromRGBO(0, 150, 28, 1.0);

  // Definimos todo el tema de la aplicacion dentro del LightTheme de la misma
  static final ThemeData lightTheme = ThemeData.light().copyWith(
    primaryColor: Colors.green[800],
    
    // Scaffold background Color
    scaffoldBackgroundColor: bgColor, 

    // AppbarTheme
    appBarTheme: AppBarTheme(
      backgroundColor: primary,
      elevation: 10
    ),

    //OverscrollColor
    colorScheme: ColorScheme.fromSwatch(
      accentColor: primary,
    ),

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      elevation: 30,
      unselectedItemColor: Colors.grey,
      backgroundColor: bgColor,
      selectedItemColor: primary,
    ),

    // TextButtonTheme
    textButtonTheme:  TextButtonThemeData(
      style: TextButton.styleFrom(primary: primary),
    ),

    // // FloatingActionButtonTheme
    // floatingActionButtonTheme: const FloatingActionButtonThemeData(
    //   backgroundColor: primary,
    // ),

    // OutlinedButtonTheme
    outlinedButtonTheme:  OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        primary: Colors.black,
        side: const BorderSide(color: Colors.black, width: 1.0),
        shape: const StadiumBorder(),
      )  
    ),

    // ElevatedButtonTheme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        primary: buttonColorv1,
        shape: const StadiumBorder(),
        elevation: 10,
        padding: const EdgeInsets.symmetric(
          horizontal: 80,
          vertical: 20,
          ),
        textStyle: const TextStyle(
          color: Colors.white
        ),
      ),
    ),

    // Text Selection Theme
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: primary,
      selectionColor: primary,
      selectionHandleColor: primary,
    ),

    // Input Decoration Theme
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: TextStyle(color: primary),
      floatingLabelStyle: TextStyle( color: primary),
      enabledBorder: UnderlineInputBorder(      
        borderSide: BorderSide(color: primary!),  
      ),  
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: primary!),
      ),
      disabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: buttonColorv2!),
      ),
      border: UnderlineInputBorder(
        borderSide: BorderSide(color: primary!),
      ),
    )

  );

  // * Mas adelante se pretende que en esta parte se definan mas temas de la aplicacion
  // ? Tema de alto contraste
  static final ThemeData darkTheme = ThemeData.dark().copyWith(
    // primaryColor: primary,
    // appBarTheme: const AppBarTheme(
    //   color: primary,
    //   elevation:0
    // ),
    // scaffoldBackgroundColor: Colors.black
  );







}