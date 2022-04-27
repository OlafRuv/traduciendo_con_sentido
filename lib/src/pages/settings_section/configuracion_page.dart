import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:TCS/theme/app_theme.dart';
import 'package:TCS/widgets/widgets.dart';

// * Seccion de configuracion del usuario, \
// Por el momento solo cuanta con la infomarcion del usuario mas basica, como su correo, y con los botones de politicas de uso y privacidad, ademas del boton de cerrar sesion
class ConfiguracionPage extends StatefulWidget {
  const ConfiguracionPage({Key? key}) : super(key: key);
  @override
  _ConfiguracionPageState createState() => _ConfiguracionPageState();
}

class _ConfiguracionPageState extends State<ConfiguracionPage> {
  @override
  Widget build(BuildContext context) { 
    User? usuario = FirebaseAuth.instance.currentUser; //instancia que se usara para saber si el usuario se encuentra en sesion
  
    return Scaffold(
      appBar: AppBar( // App bar de la pagina
        title: const Text('CONFIGURACIÓN'),
      ),

      body: Column(
        children: [
          const CustomPageDescription(title: 'Configuración e información de usuario'), // Titulo o descripcion de la pagina
          const Text('Usuario:',
            style: TextStyle(fontSize: AppTheme.size20),
          ),
          Text((usuario == null ? 'Usuario no registrado' : FirebaseAuth.instance.currentUser!.email.toString()), 
          style: const TextStyle(fontSize: AppTheme.size20),
          ), //si el usuario se encuentra en sesion mostrara el correo del usuario y si esta en null mostrara que el usuario no esta registrado
          // Politicas de uso y privacidad que se despliegan haciendo uso del widget de outlined button que creamos
          const SizedBox(height: 30.0,),
          const CustomOutlinedButton(textContent: 'Políticas de Privacidad',textSize: AppTheme.size20, route: 'politicas_privacidad'),
          const SizedBox(height: 30.0,),
          const CustomOutlinedButton(textContent: 'Políticas de uso',textSize: AppTheme.size20, route: 'politicas_uso'),
          Expanded(
            child: Container(
              width: 100,
            ),
          ),
          // _botonSalir(context),  
          CustomButton( // Para cerrar sesion contamos con uno de nuestros cutom button hasta el fondo de la pagina
            padHButton: 80.0,
            padVButton: 20.0,
            buttontext: 'Cerrar Sesión', 
            colorButton: AppTheme.buttonColorv2,
            onPressedFunction: () async { 
              await FirebaseAuth.instance.signOut(); //metodo para que el usuario salga de la sesion de firebase
              setState(() {});
              Navigator.pushNamedAndRemoveUntil(
                context, 'scroll', 
                (route) => false
              );
            }
          ),
          const SizedBox(height: 10),
        ],
      ),
      bottomNavigationBar: const CustomBottomNavigation(botonBarraActual: 2),
    );
  }

}