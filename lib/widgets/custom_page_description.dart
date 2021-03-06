import 'package:flutter/material.dart';
import 'package:TCS/theme/app_theme.dart';

//Este es un breve widget que sirve para estandarizar las descripciones de todas las paginas dentro del funcionamiento principal de la aplicacion 
class CustomPageDescription extends StatelessWidget {
  final String title;
  const CustomPageDescription({
    Key? key, 
    required this.title
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Se construye un safe area en el cual se inserta un titulo estilizado y listo
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title, 
                textAlign: TextAlign.center,
                style: const TextStyle( 
                  color: AppTheme.titleColor, 
                  fontSize: AppTheme.titleSize, 
                  fontWeight: FontWeight.bold,
                  ),
              ),
              const SizedBox( height: 10.0),
            ],
          )
      ),
    );
  }
}