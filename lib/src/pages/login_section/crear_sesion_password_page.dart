import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:TCS/theme/app_theme.dart';
import 'package:TCS/utils/validators.dart';
import 'package:TCS/widgets/widgets.dart';

class CrearSesionPasswordPage extends StatefulWidget {
  final String correo;
  const CrearSesionPasswordPage(
    this.correo, 
    {Key? key
  }) : super(key: key); 

  @override
  State<CrearSesionPasswordPage> createState() => _CrearSesionPasswordPageState();
}

class _CrearSesionPasswordPageState extends State<CrearSesionPasswordPage> {
  // Creamos el controlador de la contraseña
  final contraseniaController = TextEditingController();

  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  
  String errorMensajeFirebase = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [ 
          // Agregamos el background que creamos como widget
          const CustomHalfBackground(title: 'Crear Contraseña'),
          // Agregamos la credential card que creamos como widget 
          CredentialCard(
            cardTitle: 'Ingrese su contraseña', 
            cardForm: _buildForm(), // Llamamos como el cuerpo de la tarjeta el BuildForm
            // Agregamos a nuestra tarjeta la etiqueta del correo de la cuenta que estamos creando
            cardExtra: Column(
              children: [
                Text(
                  'Usuario:',
                  style: TextStyle(
                    color: AppTheme.primary,
                    fontSize: AppTheme.size20
                  ),
                ),
                Text(
                  widget.correo,
                  style: const TextStyle(
                    fontSize: AppTheme.size18
                  ),
                ),
              ],
            ),
            )
          // _loginForm(context),
        ],
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _key,
      child: Column(
        children: [
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
            onPressedFunction: () async { //Editado
              if (_key.currentState!.validate()){ //Editado
                try{ //Editado
                  await FirebaseAuth.instance.createUserWithEmailAndPassword( //METODO QUE CREA UNA NUEVA CUENTA EN EL PROYECTO DE FIREBASE Y LO LOGEA EN SEGUIDA
                    email: widget.correo, //Editado
                    password: contraseniaController.text //Editado
                  );
                  Navigator.pushNamed( context, 'Menu');
                  errorMensajeFirebase = '';
                } on FirebaseAuthException catch (error){
                  errorMensajeFirebase = error.message!;
                }
                setState(() {});//Editado 
              }
            },
          ),
        ],
      ),
    );
  }
  
}