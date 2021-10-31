import 'package:tcs/src/pages/home/menu/menu_page.dart';
import 'package:flutter/material.dart';

class CrearSesionPasswordPage extends StatelessWidget {
  const CrearSesionPasswordPage({Key? key}) : super(key: key);

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
                _botonIngresar(context)
              ],
            ),
          ),
        ],
      ),
    );
  }


  Widget _crearPassword() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        obscureText: true,
        decoration: InputDecoration(
          icon: Icon(Icons.lock_outline, color: Colors.green[800], ),
          labelText: 'Contraseña',
        ),
      ),
    );
  }


  Widget _botonIngresar(BuildContext context){

    return MaterialButton(
      onPressed: (){
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
  }
}