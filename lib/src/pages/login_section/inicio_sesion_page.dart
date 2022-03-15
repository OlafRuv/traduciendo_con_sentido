import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:tcs/theme/app_theme.dart';
import 'package:tcs/utils/validators.dart';
import 'package:tcs/widgets/widgets.dart';

// TODO: Separar funcionamiento de llamadas a la base de datos en un nivel más de abstracción

class InicioSesionPage extends StatefulWidget {
  const InicioSesionPage({Key? key}) : super(key: key);

  @override
  State<InicioSesionPage> createState() => _InicioSesionPageState();
}

class _InicioSesionPageState extends State<InicioSesionPage> {

  // Creamos los controladores del correo y la contraseña
  final correoController = TextEditingController(); //Editado
  final contraseniaController = TextEditingController(); //Editado

  final GlobalKey<FormState> _key = GlobalKey<FormState>(); //Editado
  String errorMensajeFirebase = '';

  bool banderaCorreoValidado = false;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Agregamos el background que creamos como widget
          const CustomHalfBackground(title: 'Bienvenido de nuevo'),
          // Agregamos la credential card que creamos como widget 
          CredentialCard(
            cardTitle: 'Ingrese sus credenciales', 
            cardForm: _buildForm(), // Llamamos como el cuerpo de la tarjeta el BuildForm
            cardExtra: const CustomOutlinedButton( // Agregamos el boton al final de nuestra tarjeta
              textContent: 'Recuperar contraseña', 
              textSize: AppTheme.size15, 
              route: 'recuperar_credenciales',
            ),
          ),
        ],
      ),
    );
  }

  // Creamos nuestro Form 
  Widget _buildForm() {
    return Form(
      key: _key,
      child: Column(
        children: [
          // Aniadimos un texfield form personalizado
          TextFieldForm(
            keyboardType: TextInputType.emailAddress,
            icon: Icons.alternate_email,
            hintText: 'nombre@correo.com',
            labelText: 'Correo Electronico',
            controller: correoController,
            validator: validarEmail, 
            hasNextFocus: true, 
            obscureText: false,
          ),
          // Aniadimos un texfield form personalizado
          TextFieldForm(
            icon: Icons.lock_outline,
            labelText: 'Contraseña',
            controller: contraseniaController, 
            obscureText: true, 
            validator: validarPassword, 
            hasNextFocus: false
          ),
          // Aniadimos un sizeb box que nos de espacio
          const SizedBox(height: 30),
          // Aniadimos un boton personalizado
          CustomButton(
            buttontext: 'Ingresar', 
            elevationButton: 0,
            padHButton: 80.0,
            padVButton: 20.0,
            // El boton personalizado al ser presionado hace validaciones con la bd y nos redirige 
            // a la pagina de menu principal de la aplicacion
            onPressedFunction: () async {
              if (_key.currentState!.validate()){ 
                try{
                  await FirebaseAuth.instance.signInWithEmailAndPassword( //INICIA SESION EN UNA CUENTA EXISTENTE DENTRO DEL PROYECTO DE FIREBASE
                    email: correoController.text, 
                    password: contraseniaController.text
                  );
                  // Navegamos a la ruta del menu principal
                  Navigator.pushNamed(context, 'menu');
                  errorMensajeFirebase = '';
                }on FirebaseAuthException catch (error){
                  errorMensajeFirebase = error.message!;
                }
                setState(() {}); //Editado
              }
            },
          ),
        ],
      ),
    );
  }

}