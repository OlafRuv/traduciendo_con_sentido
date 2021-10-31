import 'package:flutter/material.dart';

import 'package:tcs/src/pages/scroll/scroll_page.dart';
import 'package:tcs/src/pages/home/settings/politicas_uso_page.dart';
import 'package:tcs/src/pages/home/settings/politicas_privacidad_page.dart';


class ConfiguracionPage extends StatefulWidget {
  const ConfiguracionPage({Key? key}) : super(key: key);

  @override
  _ConfiguracionPageState createState() => _ConfiguracionPageState();
}

class _ConfiguracionPageState extends State<ConfiguracionPage> {
  @override
  Widget build(BuildContext context) {
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
                  Text('pepe_el_toro_es_inocente@gmail.com', style: TextStyle(fontSize: 20.0),),
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
      bottomNavigationBar: _bottomNavigationBar(context),
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
          onPressed: (){
            final rutaScrollPage = MaterialPageRoute(
                builder: (context){
                  return ScrollPage();
                }
              );
            Navigator.push( context, rutaScrollPage);
          },
        );
  }


  Widget _bottomNavigationBar( BuildContext context){ 
  int _botonBarraActual = 2;
  
  List _listaPaginas = [ //Se usara para tomar la posicion del string y usarlo en el navigator
    'menu',
    'traducciones-guardadas',
    'configuracion',
  ];

    return Theme( //LA UNICA FORMA DE CAMBIAR LAS PROPIEDADES DEL BOTTOMNAVIGATIONBAR IMPLICA CAMBIAR EL THEME
      data: Theme.of(context).copyWith(
        canvasColor: Colors.white,
        unselectedWidgetColor: Colors.grey,
      ),
      
      child: BottomNavigationBar(
        fixedColor: Colors.green[800],
        onTap: (index){ //Al hacer tap obtendra el index de la barra y se ira a la pagina requerida
          setState(() {
            _botonBarraActual = index;
            Navigator.pushNamed(context, _listaPaginas[_botonBarraActual]);
          });
        },

        currentIndex: _botonBarraActual, //se toma el indice actual

        items: [ //Todos los items de la barra de navegacion
          BottomNavigationBarItem(
            icon: Icon( Icons.home, size: 30.0,),
            title: Text('Inicio'),
          ),
          BottomNavigationBarItem(
            icon: Icon( Icons.list_alt, size: 30.0,),
            title: Text('Trad. Guardadas'),
          ),
          BottomNavigationBarItem(
            icon: Icon( Icons.supervised_user_circle, size: 30.0,),
            title: Text('Configuracion'),
          )
        ],
        
      )
    );
  } 
}