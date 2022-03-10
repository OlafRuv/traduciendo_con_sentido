import 'package:flutter/material.dart';


class ScrollPage extends StatelessWidget {
  const ScrollPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView( //PAGEVIEW DONDE SE HACE EL SCROLL
        children: [
          _pagina1(),
          _pagina2(),
          _pagina3(context)
        ],
      )
    );
  }


  //COLOR DE FONDO EXTERIOR
  Widget _colorFondoExterior(){
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.green[400],
    );
  }


  //PAGINA 1
  Widget _pagina1() {
    return Stack(
      children: [
        _colorFondoExterior(),
        _contenidoPagina1(),
      ],
    );
  }

  /* PONER ESTE CODIGO EN CUANTO SE ENCUENTRE ALGUNA FOTO BUENA PARA EL FONDO
  Widget _imagenFondo(){
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Image(
        image: AssetImage('assets/scroll-1.png'),
        fit: BoxFit.cover// sive para que pueda llenar los espacios que no se pudieron llenar
      )
    );
  }
  */

  //CONTENIDO DEL CUERPO DE LA PAGINA 1
  Widget _contenidoPagina1(){
    final estiloTexto = TextStyle(color: Colors.white, fontSize: 20.0); //estilo para el texto 
    return SafeArea(
      child: Center(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          padding: EdgeInsets.all(20.0),
          //color: Colors.green[800],
          decoration: BoxDecoration(
            color: Colors.green[800],
            borderRadius: BorderRadius.circular(20.0)
          ),
          child: Column(
            children: [
              
              Expanded(child: Container()),
              Text('Bienvenido a Traduciendo Con Sentido.', style: estiloTexto, textAlign: TextAlign.center,),
              SizedBox(height: 20.0),
              Text('La misión y visión de TCS es permitir al público general y a personas con alguna discapacidad visual traducir lenguaje convencional a lenguaje braille, aplicandolo de una manera simple y accesible. Ademas, se pretende facilitar que las personas con discapacidades visuales puedan tener acceso a información escrita, tal y como lo gozan las personas sin estas condiciones.', style: estiloTexto, textAlign: TextAlign.center,),
              Expanded(child: Container()),
              
              Text('Desliza a la derecha', style: estiloTexto,),

              Icon(Icons.keyboard_arrow_right, size: 70.0, color: Colors.white,)
            ],
          ),
        ),
      ),
    );
  }



  //PAGINA 2
  Widget _pagina2() {
    return Stack(
      children: [
        _colorFondoExterior(),
        _contenidoPagina2(),
      ],
    );
  }


  //CONTENIDO DEL CUERPO DE LA PAGINA 2
  Widget _contenidoPagina2(){
    final estiloTexto = TextStyle(color: Colors.white, fontSize: 20.0); //estilo para el texto 
    return SafeArea(
      child: Center(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
              color: Colors.green[800],
              borderRadius: BorderRadius.circular(20.0)
          ),
          child: Center(
            child: Column(
              children: [
                Expanded(child: Container()),
                Text('En esta aplicación podras traducir texto convencional a braille, procesar texto de documentos para su traducción al braille y procesar texto de imágenes para su traducción al braille. Al registrarse tambien podra hacer uso del acceso de sus documentos en linea', style: estiloTexto, textAlign: TextAlign.center),
                SizedBox(height: 50.0,),
                Icon(Icons.face_retouching_natural, size: 100.0, color: Colors.white,),
                Expanded(child: Container()),
                Text('Desliza a la derecha', style: estiloTexto,),
                Icon(Icons.keyboard_arrow_right, size: 70.0, color: Colors.white,)
              ],
            ),
          ),
        ),
      ),
    );
  }



  //PAGINA 3
  Widget _pagina3(BuildContext context) {
    return Stack(
      children: [
        _colorFondoExterior(),
        _contenidoPagina3(context),
      ],
    );
  }

  
  
  //CONTENIDO DEL CUERPO DE LA PAGINA 3
  Widget _contenidoPagina3(BuildContext context){
    return SafeArea(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
            color: Colors.green[800],
            borderRadius: BorderRadius.circular(20.0)
        ),
        child: Center(
          child: Column(
            children: [
              Image(image: AssetImage('assets/tcs_logo.png'), height: 200.0, width: 300.0),
              Expanded(child: Container()),
              estiloBotones(context, Icons.account_box, 'Iniciar sesión', 'iniciar_sesion'),
              Expanded(child: Container()),
              Divider(height: 20, thickness: 5, indent: 20, endIndent: 20),
              Expanded(child: Container()),
              estiloBotones(context, Icons.create, 'Crear sesión', 'crear_sesion'),
              Expanded(child: Container()),
            ],
          )
        ),
      )
    );
  }

  //DAR ESTILO A LOS BOTONES
  Widget estiloBotones(BuildContext context, IconData icono, String texto, String ruta){
    return MaterialButton(
      height: 40.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0), 
                ),
                color: Colors.white,
                textColor: Colors.black87,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(icono, size: 50.0),
                    SizedBox(width: 30.0,),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.0),                    
                      child: Text(texto, style: TextStyle(fontSize: 25.0),),
                    ),
                  ],
                ),
                onPressed: (){
                  Navigator.pushNamed(context, ruta);
                },
      );
  }

}