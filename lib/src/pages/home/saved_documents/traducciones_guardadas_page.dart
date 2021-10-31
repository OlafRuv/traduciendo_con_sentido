import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'dart:math';


class TraduccionesGuardadasPage extends StatefulWidget {
  const TraduccionesGuardadasPage({Key? key}) : super(key: key);

  @override
  _TraduccionesGuardadasPageState createState() => _TraduccionesGuardadasPageState();
}

class _TraduccionesGuardadasPageState extends State<TraduccionesGuardadasPage> {
  
  //PARTE DONDE SE CONSULTARA A LA BD----------------------------------------------------------
  @override
  void initState() {
    super.initState();
    obtenerUsuarios();
  }

  void obtenerUsuarios() async {
    CollectionReference referenciaColeccion = FirebaseFirestore.instance.collection("usuarios");
    QuerySnapshot users = await referenciaColeccion.get();//CONSULTA A ESA COLECCION
    
    if (users.docs.length != 0){ //SI HAY VALORES
      for (var doc in users.docs) {
        print(doc.data());
        
      }
    }
  }
  //------------------------------------------------------------------------------
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TRADUCIONES GUARDADAS'),
        backgroundColor: Colors.green[800],
      ),
      body: Stack(
        children: [
          _fondoApp(),

          SingleChildScrollView( //SIMILAR A LISTVIEW, LA DIFERENCIA ES QUE ABARCA TODA LA PANTALLA
              child: Column(
                children: [
                  _tituloDescripcion(),
                  //_botonesRedondeados(context)
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
              Text('Documentos de traducciones guardadas', style:TextStyle( color: Colors.black87, fontSize: 30.0, fontWeight: FontWeight.bold),),
              SizedBox( height: 10.0),
            ],
          )
      ),
    );
  }







  Widget _bottomNavigationBar( BuildContext context){ 

  int _botonBarraActual = 1;
  
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