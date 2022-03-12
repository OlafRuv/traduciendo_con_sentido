import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:tcs/src/pages/scroll_section/scroll_page.dart';
import 'package:tcs/src/pages/settings_section/politicas_uso_page.dart';
import 'package:tcs/src/pages/settings_section/politicas_privacidad_page.dart';
import 'package:tcs/widgets/widgets.dart';


class ConfiguracionPage extends StatefulWidget {
  const ConfiguracionPage({Key? key}) : super(key: key);

  @override
  _ConfiguracionPageState createState() => _ConfiguracionPageState();
}

class _ConfiguracionPageState extends State<ConfiguracionPage> {
  @override
  Widget build(BuildContext context) { 
    User? usuario = FirebaseAuth.instance.currentUser; //INSTANCIA QUE SE USARA PARA SABER SI EL USUARIO SE ENCUENTRA EN SESION
    
    return Scaffold(
      appBar: AppBar(
        title: Text('CONFIGURACIÓN'),
        backgroundColor: Colors.green[800],
      ),

      
      body: Stack(
        children: [
          _fondoApp(),

          SingleChildScrollView( //SIMILAR A LISTVIEW, LA DIFERENCIA ES QUE ABARCA TODA LA PANTALLA
              child: Column(
                children: [
                  _tituloDescripcion(),
                  Text('Usuario: ' + (usuario == null ? 'Usuario no registrado' : FirebaseAuth.instance.currentUser!.email.toString()), style: TextStyle(fontSize: 20.0),), //SI EL USUARIO SE ENCUENTRA EN SESION MOSTRARA EL CORREO DEL USUARIO Y SI ESTA EN NULL MOSTRARA QUE EL USUARIO NO ESTA REGISTRADO
                  SizedBox(height: 30.0,),
                  _botonPoliticasDePrivacidad(),
                  SizedBox(height: 30.0,),
                  _botonPoliticasDeUso(),
                  SizedBox(height: 60.0,),
                  _botonSalir(context)
                ],
              ),
            )
        ],
      ),
      bottomNavigationBar: const CustomBottomNavigation(botonBarraActual: 2),
    );
  }



  Widget _fondoApp(){
    final fondo = Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
    );
    
    return Stack(
      children: [
        fondo,
      ],
    );
  }

  //SECCION DE TEXTO DE INICIO
  Widget _tituloDescripcion(){
    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Configuración e información de usuario', style:TextStyle( color: Colors.black87, fontSize: 30.0, fontWeight: FontWeight.bold),),
              SizedBox( height: 10.0),
            ],
          )
      ),
    );
  }



  Widget _botonPoliticasDePrivacidad(){
    return OutlinedButton(
      onPressed: (){
        final rutaPoliticasDePrivacidad = MaterialPageRoute(
                builder: (context){
                  return PoliticasDePrivacidadPage();
                }
              );
            Navigator.push( context, rutaPoliticasDePrivacidad);
      },
      child: Container(
        //padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
        child: Text('Politicas de privacidad', style: TextStyle(fontSize: 20.0),),
      ),
      style: OutlinedButton.styleFrom(
        primary: Colors.black87,
        side: BorderSide(color: Colors.black87, width: 3.0),
        shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(5.0) ),
      ),
    );
  }



  Widget _botonPoliticasDeUso(){
    return OutlinedButton(
      onPressed: (){
        final rutaPoliticasDeUso = MaterialPageRoute(
                builder: (context){
                  return PoliticasDeUsoPage();
                }
              );
            Navigator.push( context, rutaPoliticasDeUso);
      },
      child: Container(
        //padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
        child: Text('Politicas de uso', style: TextStyle(fontSize: 20.0),),
      ),
      style: OutlinedButton.styleFrom(
        primary: Colors.black87,
        side: BorderSide(color: Colors.black87, width: 3.0),
        shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(5.0) ),
      ),
    );
  }


  Widget _botonSalir(BuildContext context){
    return MaterialButton(
          shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(30.0) ),
          color: Colors.redAccent[700],
          textColor: Colors.white,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
            child: Text('Salir', style: TextStyle(fontSize: 20.0),),
          ),
          onPressed: () async { 
            await FirebaseAuth.instance.signOut(); //METODO PARA QUE EL USUARIO SALGA DE LA SESION DE FIREBASE
            setState(() {});
            final rutaScrollPage = MaterialPageRoute(
                builder: (context){
                  return ScrollPage();
                }
              );
            Navigator.push( context, rutaScrollPage);
          },
        );
  }

}