import 'package:flutter/material.dart';
import 'package:tcs/widgets/widgets.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // TODO: Revisar que es lo que hace el fondo app
          _fondoApp(),
          SingleChildScrollView(
            //SIMILAR A LISTVIEW, LA DIFERENCIA ES QUE ABARCA TODA LA PANTALLA
            child: Column(
              children: [_tituloDescripcion(), _botonesMenu(context)],
            ),
          )
        ],
      ),
      bottomNavigationBar: const CustomBottomNavigation(),
    );
  }

  //ESTILO Y FORMA DEL FONDO DE LA PANTALLA
  Widget _fondoApp() {
    final fondo = Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(color: Colors.white),
    );

    return Stack(
      children: [
        fondo,
      ],
    );
  }

  //SECCION DE TEXTO DE INICIO
  Widget _tituloDescripcion() {
    return SafeArea(
      child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Menú de opciones',
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10.0),
              //Text('Classify this transaccion into a particular category', style:TextStyle( color: Colors.white, fontSize: 18.0, )),
            ],
          )),
    );
  }

  //SECCION DONDE SE LLAMARAN A LAS FUNCIONES DE LOS BOTONES
  Widget _botonesMenu(BuildContext context) {
    return Table(
      children: [
        TableRow(children: [
          _crearBotonMenu(context, Colors.white, Icons.text_fields,
              'Traducir texto plano', 'traducir_texto'),
        ]),
        TableRow(children: [
          _crearBotonMenu(context, Colors.white, Icons.folder,
              'Traducir documentos', 'traducir_documentos'),
        ]),
        TableRow(children: [
          _crearBotonMenu(context, Colors.white, Icons.image,
              'Traducir texto en imagenes', 'traducir_imagenes'),
        ]),
      ],
    );
  }

  //CREACION DE CONTAINERS EN FORMA DE BOTONES EN LA SECCION DEL CUERPO DE LA APLICACION
  Widget _crearBotonMenu(BuildContext context, Color color, IconData icono,
      String texto, String ruta) {
    return //BackdropFilter( // hace que todo lo que quede atras quede como borroso
        //filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0), //EL BLUR CONSUME RECURSOS, (POSIBLE ELIMINACION)
        //child:
        InkWell(
      onTap: () {
        Navigator.pushNamed(context, ruta);
      },
      child: Container(
        height: 160.0,
        margin: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
            color: Colors.green[800],
            borderRadius: BorderRadius.circular(20.0)),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(height: 5.0),
            CircleAvatar(
              backgroundColor:
                  color, //SE PONE EL COLOR QUE ESTAMOS RECIBIENDO EN EL PARAMETRO
              radius: 40.0,
              child: Icon(
                icono,
                color: Colors.black87,
                size: 40.0,
              ), //SE PONE EL ICONO QUE ESTAMOS RECIBIENDO EN EL PARAMETRO
            ),
            Text(
              texto,
              style: TextStyle(color: color, fontSize: 20),
            ), //SE PONE EL TEXTO Y COLOR QUE ESTAMOS RECIBIENDO EN EL PARAMETRO
            SizedBox(height: 5.0)
          ],
        ),

        //),
      ),
    );
  }

  // TODO: Revisar que el codigo creado de la custom navigation aplique correctamente en todas sus implementaciones para borrar este codigo comentado
  // //BARRA INFERIOR DE NAVEGACION
  // Widget _bottomNavigationBar(BuildContext context) {
  //   int _botonBarraActual = 0;

  //   List _listaPaginas = [
  //     //Se usara para tomar la posicion del string y usarlo en el navigator
  //     'menu',
  //     'traducciones_guardadas',
  //     'configuracion',
  //   ];

  //   return Theme(
  //       //LA UNICA FORMA DE CAMBIAR LAS PROPIEDADES DEL BOTTOMNAVIGATIONBAR IMPLICA CAMBIAR EL THEME
  //       data: Theme.of(context).copyWith(
  //         canvasColor: Colors.white,
  //         unselectedWidgetColor: Colors.grey,
  //         //splashColor: Colors.red //Efecto color del tap
  //       ),
  //       child: BottomNavigationBar(
  //         //PONER COLOR EN EL ITEM SELECCIONADO
  //         fixedColor: Colors.green[800],
  //         onTap: (index) {
  //           //Al hacer tap obtendra el index de la barra y se ira a la pagina requerida
  //           setState(() {
  //             _botonBarraActual = index;
  //             Navigator.pushNamed(context, _listaPaginas[_botonBarraActual]);
  //           });
  //         },
  //         currentIndex: _botonBarraActual, //se toma el indice actual
  //         items: const [
  //           // Todos los items de la barra de navegacion
  //           BottomNavigationBarItem(
  //             icon: Icon(
  //               Icons.home,
  //               size: 30.0,
  //             ),
  //             label: 'Inicio',
  //           ),
  //           BottomNavigationBarItem(
  //             icon: Icon(
  //               Icons.list_alt,
  //               size: 30.0,
  //             ),
  //             label: 'Trad. Guardadas',
  //           ),
  //           BottomNavigationBarItem(
  //             icon: Icon(
  //               Icons.supervised_user_circle,
  //               size: 30.0,
  //             ),
  //             label: 'Configuracion',
  //           )
  //         ],
  //       ));
  // }
}
