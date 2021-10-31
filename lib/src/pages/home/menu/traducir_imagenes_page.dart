import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class TraducirImagenesPage extends StatefulWidget {
  const TraducirImagenesPage({Key? key}) : super(key: key);

  @override
  _TraducirImagenesPageState createState() => _TraducirImagenesPageState();
}

class _TraducirImagenesPageState extends State<TraducirImagenesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TRADUCIR IMAGENES'),
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
                _tomarFoto(),
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

      bottomNavigationBar: _bottomNavigationBar(context)
    );
  }


  Widget _fondoApp(){
    final fondo = Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white
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
              Text('Haga click en el boton de seleccionar para poder traducir su foto o imagen al cuadro de texto o mandar a imprimir', style:TextStyle( color: Colors.black87, fontSize: 20.0, fontWeight: FontWeight.bold),),
              SizedBox( height: 10.0),
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
            child: Text('Seleccionar Imagen', style: TextStyle(fontSize: 20.0),),
          ),
          onPressed: (){
            //navegar
          },
        );
  }


  Widget _tomarFoto(){
    return InkWell(
      onTap: () async{
          final ImagePicker _picker = ImagePicker();
          final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
          },
      child: Container(
          height: 150.0,
          width: 150.0,
          margin: EdgeInsets.all(15.0),
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(20.0)
          ),         
          child: Column( 
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(height: 5.0),
              CircleAvatar(
                backgroundColor: Colors.white,
                radius: 40.0,
                child: Icon(Icons.camera_alt, color: Colors.black87, size: 60.0,), //SE PONE EL ICONO QUE ESTAMOS RECIBIENDO EN EL PARAMETRO
              ),
              Text('Tomar Foto', style: TextStyle(color: Colors.black87, fontSize: 20),), //SE PONE EL TEXTO Y COLOR QUE ESTAMOS RECIBIENDO EN EL PARAMETRO
              SizedBox(height: 5.0)
            ],
          ),
          
        //),
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