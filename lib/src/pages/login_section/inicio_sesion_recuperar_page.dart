import 'package:flutter/material.dart';

import 'package:tcs/src/pages/login_section/inicio_sesion_page.dart';
//import 'package:diseno_inicial/src/pages/home/menu/menu_page.dart';

class InicioSesionRecuperarPage extends StatelessWidget {
  const InicioSesionRecuperarPage({Key? key}) : super(key: key);

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
              Text('Recupere su sesión por correo', style: TextStyle(color: Colors.white, fontSize: 25.0),)
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
                Text('Ingrese su correo electronico', style: TextStyle(fontSize: 20.0),),
                SizedBox(height: 30.0,),
                _crearEmail(),
                SizedBox(height: 30.0,),
                _botonRecuperarCredenciales(context)
              ],
            ),
          ),
        ],
      ),
    );
  }


  Widget _crearEmail() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          icon: Icon(Icons.alternate_email, color: Colors.green[800], ),
          hintText: 'nombre@correo.com',
          labelText: 'Correo electronico',

        ),
      ),
    );
  }


  Widget _botonRecuperarCredenciales(BuildContext context){
    return MaterialButton(
      onPressed: (){
        showDialog(
          context: context, 
          builder: (BuildContext context) => _popUpRecuperarCredenciales(context));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
        child: Text('Recuperar credenciales'),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0), 
      ),
      elevation: 0.0,
      color: Colors.green[800],
      textColor: Colors.white,
    );
  }


  Widget _popUpRecuperarCredenciales(BuildContext context) {
  return AlertDialog(
    title: const Text('Se envio la contraseña a su correo'),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("Una vez consultada su contraseña por favor ingresela en el inicio de sesión"),
      ],
    ),
    actions: <Widget>[
      FlatButton(
        onPressed: () {
          final rutaInicioSesion = MaterialPageRoute(
                builder: (context){
                  return InicioSesionPage();
                }
              );
            Navigator.push( context, rutaInicioSesion);
        },
        textColor: Theme.of(context).primaryColor,
        child: const Text('Continuar'),
      ),
    ],
  );
}
}