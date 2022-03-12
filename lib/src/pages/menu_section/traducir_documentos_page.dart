import 'package:flutter/material.dart';
import 'package:tcs/widgets/widgets.dart';


class TraducirDocumentosPage extends StatefulWidget {
  const TraducirDocumentosPage({Key? key}) : super(key: key);

  @override
  _TraducirDocumentosPageState createState() => _TraducirDocumentosPageState();
}

class _TraducirDocumentosPageState extends State<TraducirDocumentosPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TRADUCIR DOCUMENTOS'),
        backgroundColor: Colors.green[800],
      ),
      body: Stack(
        children: [
          _fondoApp(),
          SingleChildScrollView(
            child: Column(
              children: [
                _tituloDescripcion(),
                _botonSeleccionarArchivo(),
                SizedBox(height: 60.0,),
                _botones(),
                SizedBox(height: 60.0,),
                SizedBox(height: 60.0,),
                _salidaCuadroTexto()
              ],
            ),
          ),
        ],
      ),
      
      bottomNavigationBar: const CustomBottomNavigation(botonBarraActual: 0),
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
              Text('Haga click en el boton de seleccionar para poder traducir su documento al cuadro de texto o mandar a imprimir', style:TextStyle( color: Colors.black87, fontSize: 20.0, fontWeight: FontWeight.bold),),
              SizedBox( height: 10.0),
              //Text('Classify this transaccion into a particular category', style:TextStyle( color: Colors.white, fontSize: 18.0, )),
            ],
          )
      ),
    );
  }



  _botonSeleccionarArchivo(){
    return MaterialButton(
          shape: StadiumBorder(),
          color: Colors.green[800],
          textColor: Colors.white,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: Text('Seleccionar Archivo', style: TextStyle(fontSize: 20.0),),
          ),
          onPressed: (){
            //navegar
          },
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
            child: Text('Imprimir', style: TextStyle(fontSize: 20.0),),
          ),
          onPressed: (){
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
  
}