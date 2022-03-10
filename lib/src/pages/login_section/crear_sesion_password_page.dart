import 'package:firebase_auth/firebase_auth.dart';
import 'package:tcs/src/pages/menu_section/menu_page.dart';
import 'package:flutter/material.dart';

class CrearSesionPasswordPage extends StatefulWidget {
  //const CrearSesionPasswordPage({Key? key}) : super(key: key);

  

  String correo; //Editado
  CrearSesionPasswordPage(this.correo); //Editado

  @override
  State<CrearSesionPasswordPage> createState() => _CrearSesionPasswordPageState();
}

class _CrearSesionPasswordPageState extends State<CrearSesionPasswordPage> {

  final contraseniaController = TextEditingController(); //Editado
  final GlobalKey<FormState> _key = GlobalKey<FormState>(); //Editado
  String errorMensajeFirebase = '';

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
              Text('Hora de crear su contraseña', style: TextStyle(color: Colors.white, fontSize: 25.0),)
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
            child: Column
            (children: [
                Text('Ingrese su contraseña', style: TextStyle(fontSize: 20.0),),
                SizedBox(height: 30.0,),
                _crearPassword(),
                SizedBox(height: 30.0,),
                //_botonIngresar(context),
                Container(child: Text('Usuario -> ' + widget.correo))//Editado
              ],
            ),
          ),
        ],
      ),
    );
  }

  
  Widget _crearPassword() {
    return Form(
      key: _key, //Editado
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: TextFormField(
              obscureText: true,
              decoration: InputDecoration(
                icon: Icon(Icons.lock_outline, color: Colors.green[800], ),
                labelText: 'Contraseña',
              ),
              controller: contraseniaController,
              validator: validarPassword,
            ),
          ),
          MaterialButton(
            onPressed: () async { //Editado
            if (_key.currentState!.validate()){ //Editado
              try{ //Editado
                await FirebaseAuth.instance.createUserWithEmailAndPassword( //METODO QUE CREA UNA NUEVA CUENTA EN EL PROYECTO DE FIREBASE Y LO LOGEA EN SEGUIDA
                  email: widget.correo, //Editado
                  password: contraseniaController.text //Editado
                );

                final rutaMenu = MaterialPageRoute(
                        builder: (context){
                          return MenuPage();
                        }
                      );
                    Navigator.push( context, rutaMenu);


                errorMensajeFirebase = '';
              } on FirebaseAuthException catch (error){
                errorMensajeFirebase = error.message!;
              }
              

              setState(() {});//Editado


                
            }
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
              child: Text('Ingresar'),
            ),
            shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(30.0), ),
            elevation: 0.0,
            color: Colors.green[800],
            textColor: Colors.white,
          ),

          Center(child: Text(errorMensajeFirebase),), //Editado
        ],
      ),
    );
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

  
  
  
  
  
  /*Widget _crearPassword() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        obscureText: true,
        decoration: InputDecoration(
          icon: Icon(Icons.lock_outline, color: Colors.green[800], ),
          labelText: 'Contraseña',
        ),
        controller: contraseniaController,
      ),
    );
  }

  Widget _botonIngresar(BuildContext context){

    return MaterialButton(
      onPressed: () async { //Editado
      await FirebaseAuth.instance.createUserWithEmailAndPassword( //Editado
        email: widget.correo, //Editado
        password: contraseniaController.text //Editado
      );
        final rutaMenu = MaterialPageRoute(
                builder: (context){
                  return MenuPage();
                }
              );
            Navigator.push( context, rutaMenu);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
        child: Text('Ingresar'),
      ),
      shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(30.0), ),
      elevation: 0.0,
      color: Colors.green[800],
      textColor: Colors.white,
    );
  }*/
}