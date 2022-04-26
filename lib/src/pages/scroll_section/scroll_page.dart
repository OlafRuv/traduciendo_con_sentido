import 'package:flutter/material.dart';
import 'package:tcs/widgets/custom_background.dart';
import 'package:tcs/widgets/widgets.dart';

// Widget de sliders previos al ingreso a la aplicacion 
class ScrollPage extends StatelessWidget {
  const ScrollPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView( // En total son 3 paginas y cada una se crea en su propia funcion
        children: [
          _pagina1(context),
          _pagina2(context),
          _pagina3(context)
        ],
      )
    );
  }

  //PAGINA 1
  Widget _pagina1(BuildContext context){
    return Stack( // Un stack que almacena nuestro custom background que usa un logo como titulo y que al mismo tiempo recibe el texto que despiega la pagina
      children: [
        CustomBackground(
          title: Semantics(
            label: "Traduciendo Con Sentido logo" ,
            child: const Image(
              image: AssetImage('assets/TraduciendoConSentido.png'),
              height:280.0
            )
          )
        ),
        _contenidoPagina1v2(
          context: context, 
          texto: 'La misión y visión de TCS es permitir al público general y a personas con alguna discapacidad visual traducir lenguaje convencional a lenguaje braille de una manera simple y accesible. Además, buscamos facilitar e incrementar el acceso a información escrita para las personas con discapacidades visuales, tal y como lo gozan las personas sin estas condiciones.',
          ),
      ],
    );
  }
  // 'La misión y visión de TCS es permitir al público general y a personas con alguna discapacidad visual traducir lenguaje convencional a lenguaje braille, aplicandolo de una manera simple y accesible. Ademas, se pretende facilitar que las personas con discapacidades visuales puedan tener acceso a información escrita, tal y como lo gozan las personas sin estas condiciones.'

  Widget _pagina2(BuildContext context) {
    return Stack(// Un stack que almacena nuestro custom background que usa un logo como titulo y que al mismo tiempo recibe el texto que despiega la pagina
      children: [
        const CustomBackground(
          reversed: true,
          title: Image(image: AssetImage('assets/TraduciendoConSentido.png'),height:280.0)
        ),
        _contenidoPagina1v2(
          context: context, 
          texto: 'En esta aplicación podrás traducir Texto Convencional a Braille, así como procesar texto de Documentos PDF y texto de Imágenes para su traducción al Braille.\nAl registrarte podrás hacer uso de estas herramientas, así como del almacenamiento de tus traducciones en la nube, para su acceso y descarga al momento que lo necesites.',
          // extra: const Image(
          //   height: 100,
          //   image: AssetImage('assets/braille.png')
          // )
        ),
      ],
    );
  }
  // En esta aplicación podras traducir texto convencional a braille, procesar texto de documentos para su traducción al braille y procesar texto de imágenes para su traducción al braille. Al registrarse tambien podra hacer uso del acceso de sus documentos en linea

  Widget _pagina3(BuildContext context) {
    return Stack(// Un stack que almacena nuestro custom background que usa un logo como titulo y que al mismo tiempo llama a la funcion que contruye los botnes y la seccion de esta pagina
      children: [
        const CustomBackground(
          title: Image(image: AssetImage('assets/TraduciendoConSentido.png'),height:400.0)
        ),
        _contenidoPagina3(context:context),
      ],
    );
  }
 
  // Esta es la composicion de las primeras 2 paginas 
  Widget _contenidoPagina1v2({
    required BuildContext context, 
    required String texto, 
    Widget? extra
    }){
    final size = MediaQuery.of(context).size;
    const estiloTexto = TextStyle(
      color: Colors.black, 
      fontSize: 20.0
    ); //estilo para el texto 
    return SingleChildScrollView( //ME VA A PERMITIR HACER SCROLL DEPENDIENDO DEL TAMAÑO DEL HIJO
      child: Column(
        children: [
          SafeArea(
            child: Container(
              height: 150.0,
            ),
          ),
          Container( // ESTO ES PURO ESTILO DE LAS TAJETAS DE INFORMACUON
            width: size.width * 0.85,
            margin: const EdgeInsets.symmetric(vertical: 30.0),
            alignment:  Alignment.center,          
            padding: const EdgeInsets.only(
              bottom: 10.0,
              top: 30.0,
              left: 20.0,
              right: 20.0,
              ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30.0),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 3.0,
                  offset: Offset(0.0, 5.0),
                  spreadRadius: 3.0,
                )
              ]
            ),
            child: Column(
              children:  [ // ESTE TEXTO Y EL WIDGET EXTRA SON LOS ELEMENTOS DENTRO DE LA TARJETA DE INFORMACION 
                Text(
                  texto, 
                  style: estiloTexto, 
                  textAlign: TextAlign.center,
                ),
                if (extra == null) ... [
                   const SizedBox(height: 20.0,),
                ]
                else ... [
                  extra,
                  const SizedBox(height: 20.0,),
                ]
                ,
                const Text('Desliza a la izquierda', style: estiloTexto,), // GIF PARA MOSTRAR HACIA DONDE DESLIZAR
                // const Text('Desliza a la izquierda', style: TextStyle(fontFamily: 'BRAILLE1')), // GIF PARA MOSTRAR HACIA DONDE DESLIZAR
                const Image(
                  image: AssetImage('assets/Swipe_Left.gif'),
                  height:100.0
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget _contenidoPagina3({
    required BuildContext context,
    }){
    final size = MediaQuery.of(context).size;//estilo para el texto 
    return SingleChildScrollView( //ME VA A PERMITIR HACER SCROLL DEPENDIENDO DEL TAMAÑO DEL HIJO
      child: Column(
        children: [
          SafeArea(
            child: Container(
              height: 280.0,
            ),
          ),
          Container(  // ESTO ES PURO ESTILO DE LAS TAJETAS DE INFORMACUON
            width: size.width * 0.9,
            margin: const EdgeInsets.symmetric(vertical: 30.0),
            alignment:  Alignment.center,          
            padding: const EdgeInsets.only(
              bottom: 30.0,
              top: 30.0,
              left: 20.0,
              right: 20.0,
              ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30.0),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 3.0,
                  offset: Offset(0.0, 5.0),
                  spreadRadius: 3.0,
                )
              ]
            ),
            child: Column(
              children:  [  // Lat tarjeta tiene 2 botnes, el de INICIAR SESION y el de CREAR SESION, estos se construyen en base al widget previamente definido de Custom Button
                const SizedBox(height: 20),
                CustomButton(
                  buttontext: 'Iniciar Sesión', 
                  padHButton: 40, 
                  padVButton: 30,
                  elevationButton: 20,
                  iconData: Icons.supervised_user_circle_rounded,
                  iconSize: 30,
                  textSize: 24,
                  onPressedFunction: (){
                    Navigator.pushNamed(context, 'iniciar_sesion');
                  }, 
                ),
                // estiloBotones(context, Icons.account_box, 'Iniciar sesión', 'iniciar_sesion'),
                const SizedBox(height: 30),
                const Divider(height: 20, thickness: 3, indent: 20, endIndent: 20),
                const SizedBox(height:30),
                CustomButton(
                  buttontext: 'Crear Sesión', 
                  padHButton: 40, 
                  padVButton: 30,
                  elevationButton: 20,
                  iconData: Icons.create,
                  iconSize: 30,
                  textSize: 24,
                  onPressedFunction: (){
                    Navigator.pushNamed(context, 'crear_sesion');
                  }, 
                ),
                const SizedBox(height:30),
              ],
            ),
          ),
        ],
      ),
    );
  }


}