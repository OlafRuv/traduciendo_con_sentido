import 'package:flutter/material.dart';

// Creamos el widget de credential card el cual sirve como plantilla para las screens de toda la seccion de login
class CredentialCard extends StatelessWidget {
  final String cardTitle;
  final Widget cardForm;
  final Widget? cardExtra; 

  //Definimos todos los parametros que el Widget recibirá, desde los forzados hasta los opcionales
  const CredentialCard({ //Constructor del Widget
    Key? key, 
    required this.cardTitle, 
    required this.cardForm, 
    this.cardExtra,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView( // Lo creamos dentro de un single child scroll view, para que el teclado nos permita mover la sección
      child: Column(  // Creamos una columna
        children: [
          SafeArea(  // Creamos un safe Area
            child: Container(
              height: 180.0,
            ),
          ),
          Container( // Creamos un contenedor debajo de la safe area
            width: size.width * 0.85,
            margin: const EdgeInsets.symmetric(vertical: 30.0),
            padding: const EdgeInsets.symmetric(vertical: 50.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 3.0,
                  offset: Offset(0.0, 5.0),
                  spreadRadius: 3.0,
                )
              ]
            ),
            child: Column( // Creamos una columna dentro de nuestro contenedir
              children: [
                // La columna recibira el titulo de la tarjeta 
                // El formulario de la tarjeta
                // Y le damos la opcion de un extra debajo del formulario
                Text(
                  cardTitle, 
                  style: const TextStyle(
                    fontSize: 20.0),
                ),
                const SizedBox(height: 30.0,),
                cardForm,
                // Si el extra existe se inserta, si no existe se insertasolamente un sizedbox
                if (cardExtra == null) ... [
                  const SizedBox(height: 10.0,),
                ]
                else ... [
                  const SizedBox(height: 30.0,),
                  cardExtra!,
                ]
                
              ],
            ),
          ),
        ],
      ),
    );
  }
}
