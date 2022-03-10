import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tcs/router/app_routes.dart';

import 'package:tcs/src/pages/login_section/inicio_sesion_recuperar_page.dart';
import 'package:tcs/src/pages/menu_section/menu_page.dart';

// * Credenciales de ejemplo
// tercerCorreo@gmail.com
// 123aA.


class InicioSesionPage extends StatefulWidget {
  const InicioSesionPage({Key? key}) : super(key: key);

  @override
  State<InicioSesionPage> createState() => _InicioSesionPageState();
}

class _InicioSesionPageState extends State<InicioSesionPage> {

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
          _crearFondo(context),
          _loginForm(context),
        ],
      ),
    );
  }

  Widget _crearFondo(BuildContext context){

    final size = MediaQuery.of(context).size; //PARA OCUPAR EL 40% DE LA PANTALLA
    final colorFondo = Container(
      height: size.height * 0.4,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.lightGreen,
            Color.fromRGBO(0, 150, 28, 1.0),
          ]
        )
      ),
    );


    final circuloFondo = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        color: Color.fromRGBO(255, 255, 255, 0.05)
      )
    );


    return Stack(
      children: [
        colorFondo,
        Positioned( top: 90.0, left: 30.0, child: circuloFondo ),
        Positioned( top: -40.0, right: -30.0, child: circuloFondo ),
        Positioned( bottom: -50.0, left: -10.0, child: circuloFondo ),
        
        Container(
          padding: EdgeInsets.only(top: 80.0),
          child: Column(
            children: [
              Icon(Icons.person_pin_circle, color: Colors.white, size: 100.0,),
              SizedBox(height: 10.0, width: double.infinity),
              Text('Bienvenido de nuevo', style: TextStyle(color: Colors.white, fontSize: 25.0),)
            ],
          ),
        )
      ],
    );
  }

  Widget _loginForm(BuildContext context){

    final size = MediaQuery.of(context).size;//SACAR DIMESIONES DE LA PANTALLA

    return SingleChildScrollView( //ME VA A PERMITIR HACER SCROLL DEPENDIENDO DEL TAMAÑO DEL HIJO
      child: Column(
        children: [
          SafeArea(
            child: Container(
              height: 180.0,
            ),
          ),
          Container(
            width: size.width * 0.85,
            margin: EdgeInsets.symmetric(vertical: 30.0),
            padding: EdgeInsets.symmetric(vertical: 50.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 3.0,
                  offset: Offset(0.0, 5.0),
                  spreadRadius: 3.0,
                )
              ]

            ),
            child: Column(
              children: [
                Text('Ingreso', style: TextStyle(fontSize: 20.0),),
                SizedBox(height: 60.0,),
                _crearEmail(),
                SizedBox(height: 30.0,),
                //_crearPassword(),
                SizedBox(height: 30.0,),
                //_botonIngresar(context)
              ],
            ),
          ),

          _botonOlvidoPassword(context),
          SizedBox( height: 100.0,)
        ],
      ),
    );
  }



  Widget _crearEmail() {
    return Form(
      key: _key,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                icon: Icon(Icons.alternate_email, color: Colors.green[800], ),
                hintText: 'nombre@correo.com',
                labelText: 'Correo electronico',
    
              ),
              controller: correoController, //Editado
              validator: validarEmail,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: TextFormField(
              obscureText: true,
              decoration: InputDecoration(
                icon: Icon(Icons.lock_outline, color: Colors.green[800], ),
                labelText: 'Contraseña',
              ),
              controller: contraseniaController, //Editado
              validator: validarPassword,
            ),
          ),
          MaterialButton(
            onPressed: () async {
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
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
              child: Text('Ingresar'),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0), 
            ),
            elevation: 0.0,
            color: Colors.green[800],
            textColor: Colors.white,
            
          ),

        ],
      ),
    );
  }



  String? validarEmail(String? formularioEmail){ //Editado
    if(formularioEmail ==null || formularioEmail.isEmpty){
      return 'Correo electronico requerido';
    }

    String patron = r'\w+@\w+\.\w+';
    RegExp regex = RegExp(patron);
    if(!regex.hasMatch(formularioEmail)){
      return 'Formato de Correo Electronico invalido.';
    }
      return null;
  }



  String? validarPassword(String? formularioPassword){ //Editado
    if(formularioPassword ==null || formularioPassword.isEmpty){
      return 'Contraseña requerida';
    }

    String patron = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~.]).{6,}$';
    RegExp regex = RegExp(patron);
    if(!regex.hasMatch(formularioPassword)){
      return 'La contraseña debe de tener al menos 6 caracteres, incluyendo alguna letra mayuscula, minuscula, numero y simbolo';
    }
      return null;
  }


  Widget _botonOlvidoPassword(BuildContext context){
    return OutlinedButton(
      onPressed: (){
        // navegamos a la ruta de recuperar credenciales
        Navigator.pushNamed(context, 'recuperar_credenciales');
      },

      child: Container(
        //padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
        child: Text('Recuperar contraseña'),
      ),
      style: OutlinedButton.styleFrom(
        primary: Colors.black87,
        side: BorderSide(color: Colors.black87, width: 2.0),
        //shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
      ),
    );
  }
}