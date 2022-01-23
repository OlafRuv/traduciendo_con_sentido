import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class TraducirTextoPage extends StatefulWidget {
  const TraducirTextoPage({Key? key}) : super(key: key);

  @override
  _TraducirTextoPageState createState() => _TraducirTextoPageState();
}

class _TraducirTextoPageState extends State<TraducirTextoPage> {
  final guardarTextoController = TextEditingController();
  final guardarTituloControllerPopUp = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TRADUCIR TEXTO'),
        backgroundColor: Colors.green[800],
      ),
      body: Stack(
        children: [
          _fondoApp(),
          SingleChildScrollView(
            child: Column(
              children: [
                _tituloDescripcion(),
                _ingresoCuadroTexto(),
                SizedBox(height: 20.0,),
                _botones(),
                SizedBox(height: 60.0,),
                SizedBox(height: 60.0,),
                _salidaCuadroTexto()
              ],
            ),
          )
        ],
      ),

      bottomNavigationBar: _bottomNavigationBar(context)
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


  

Widget _tituloDescripcion(){
    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Haga click en el cuadro de texto para teclear su texto deseado y usar los botones para traducir o guardar traduccion', style:TextStyle( color: Colors.black87, fontSize: 20.0, fontWeight: FontWeight.bold),),
              SizedBox( height: 10.0),
            ],
          )
      ),
    );
  }





  Widget _ingresoCuadroTexto(){
    String textoIngresado = "";

    return Container(
      child: TextFormField(
        onChanged: (texto) {
          textoIngresado = texto;
        },
        decoration: InputDecoration(
          hintText: 'Ingresar',
          contentPadding: EdgeInsets.all(20),
        ),
        controller: guardarTextoController,
      ),
    );
  }



  Widget _botones(){

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MaterialButton(
          shape: StadiumBorder(),
          color: Colors.green[800],
          textColor: Colors.white,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: Text('Traducir', style: TextStyle(fontSize: 20.0),),
          ),
          onPressed: (){
            //navegar
          },
        ),
        SizedBox(width: 10.0,),
        MaterialButton(
          shape: StadiumBorder(),
          color: Colors.green[800],
          textColor: Colors.white,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
            child: Text('Guardar', style: TextStyle(fontSize: 20.0),),
          ),
          onPressed: (){           
            showDialog( //ALERTA DIALOG QUE NOS SERVIRA PARA ALERTAR AL USUARIO QUE SE GUARDO CON EXITO SU TEXTO
              context: context, 
              builder: (BuildContext context) => _popUpTextoGuardado(context)
            );
            //navegar
          },
        ),
      ],
    );
  }



  Widget _salidaCuadroTexto(){
    String textoIngresado = "";

    return Container(
      child: TextField(
        onChanged: (texto) {
          textoIngresado = texto;
        },
        decoration: InputDecoration(
          hintText: 'Traducción',
          contentPadding: EdgeInsets.all(20),
        ),
      ),
    );
  }



  Future<void> escrituraFirestore( String guardarTextoFirestore, String guardarTituloFirestore) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    String identificadorCorreo = auth.currentUser!.email.toString();
    String identificadorUid = auth.currentUser!.uid.toString();

    CollectionReference coleccionUsuarios = FirebaseFirestore.instance.collection('usuarios');
    
    coleccionUsuarios.add({
      'Titulo' : guardarTituloFirestore,
      'Texto_guardado' : guardarTextoFirestore, //INGRESA EN EL CAMPO TEXTO GUARDADO NUESTRO TEXTO A GUARDAR
      'Nombre_usuario': identificadorCorreo, //INGRESA EN EL CAMPO NOMBRE USUARIO NUESTRO USUARIO (CORREO)
      'Uid' : identificadorUid, //INGRESA EN EL CAMPO UID NUESTRO IDENTIFICADOR DE USUARIO
    });


    return;
  }


//POPUP QUE APARECERA CUANDO SE GUARDE EL TEXTO
  Widget _popUpTextoGuardado(BuildContext context) {
  String textoIngresadoPopUp = "";
  return AlertDialog(
    title: const Text('Ingrese un titulo para su traducción'),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextFormField(
        onChanged: (texto) {
          textoIngresadoPopUp = texto;
        },
        decoration: InputDecoration(
          hintText: 'Ingresa tu titulo deseado',
          contentPadding: EdgeInsets.all(20),
        ),
        controller: guardarTituloControllerPopUp,
      ),
        Text("Usted podra consultar su texto guardado en la opción de Traducciones guardadas"),
      ],
    ),
    actions: <Widget>[
      MaterialButton(
        onPressed: () {
          escrituraFirestore(guardarTextoController.text, guardarTituloControllerPopUp.text);
          final rutaTraducirTexto = MaterialPageRoute(
                builder: (context){
                  return TraducirTextoPage();
                }
              );
            Navigator.push( context, rutaTraducirTexto);
        },
        textColor: Theme.of(context).primaryColor,
        child: const Text('Continuar'),
      ),
    ],
  );
}



  Widget _bottomNavigationBar( BuildContext context){ 
  int _botonBarraActual = 0;
  
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