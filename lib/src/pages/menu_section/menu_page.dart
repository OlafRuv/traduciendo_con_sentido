import 'package:flutter/material.dart';
import 'package:TCS/widgets/widgets.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);
  @override
  _MenuPageState createState() => _MenuPageState();
}

// * Pagina de menu principal
class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        // Widget para que la pantalla sea scrolleable
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Semantics( 
                // Semantics es un widget que nos ayuda a que el widget hijo se puede leer por el lector de pantalla
                label: "Traduciendo con Sentido logo",
                // Este es el texto que se leera
                child: Container(
                  // Imagen de encabezado
                  child: const Image(
                    image: AssetImage('assets/TraduciendoConSentidoSml.png'),
                    height:220.0
                  ),
                    padding: const EdgeInsets.only(top: 0,bottom:0),
                    width:MediaQuery.of(context).size.width * 1,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.green[400]!,
                        Colors.green[800]!,
                      ]
                    ),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(80), 
                      bottomRight: Radius.circular(80)
                    ),
                  ),
                ),
              ),
                // height: 100.0,
              const SizedBox(height: 20,),
              // Botones del menu
              _botonesMenu()
            ],
          ),
        ),
      ),
      // Barra de navegacion de la parte de abajo
      bottomNavigationBar: const CustomBottomNavigation(botonBarraActual: 0),
    );
  }

  //SECCION DONDE SE LLAMARAN A LAS FUNCIONES DE LOS BOTONES
  Widget _botonesMenu() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          // ****************************** Boton #1 ******************************
          ElevatedButton(
            // Funcion al presionarlo
            onPressed: (){
              Navigator.pushNamed(context, 'traducir_texto');
            },
            // Puro estilo
            style: ElevatedButton.styleFrom(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50), 
                  bottomLeft: Radius.circular(50), 
                  topRight: Radius.circular(50),
                  bottomRight: Radius.circular(10)),
              ),
              primary: Colors.green[800],
              elevation: 10.0,
              padding: const EdgeInsets.only(
                right: 40.0,
                // vertical: 40.0
              ),
            ), 
            // Estilo del icono y texto de adentro
            child: Row(
              children:[
                CircleAvatar(
                  backgroundColor:
                      Colors.white, 
                  radius: 50.0,
                  child: Icon(
                    Icons.text_fields_rounded,
                    color: Colors.green[800],
                    size: 40.0,
                  ),
                ),
                const SizedBox(width: 30),
                const Text('Traducir Texto\n Plano',
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold), 
                  textAlign: TextAlign.center,
                ),
              ] 
            ),
          ),
          // ****************************** Boton #1 ******************************
          
          // ****************************** Boton #2 ******************************
          // *** Misma configuracion que el de arriba pero diferente orientacion ***
          ElevatedButton(
            onPressed: (){
              Navigator.pushNamed(context, 'traducir_documentos');
            },
            style: ElevatedButton.styleFrom(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(50), 
                  bottomRight: Radius.circular(50), 
                  topLeft: Radius.circular(50),
                  bottomLeft: Radius.circular(10)),
              ),
              primary: Colors.green[600],
              elevation: 10.0,
              padding: const EdgeInsets.only(
                left: 40.0,
                // vertical: 40.0
              ),
            ), 
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children:[
                const Text('Traducir Texto\n Documento',
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold), 
                  textAlign: TextAlign.center,
                ),
                const SizedBox(width: 30),
                CircleAvatar(
                  backgroundColor:
                      Colors.white, 
                  radius: 50.0,
                  child: Icon(
                    Icons.document_scanner_rounded,
                    color: Colors.green[800],
                    size: 40.0,
                  ),
                ),
              ] 
            ),
          ),
          // ****************************** Boton #2 ******************************

          // ****************************** Boton #3 ******************************
          ElevatedButton(
            onPressed: (){
              Navigator.pushNamed(context, 'traducir_imagenes');
            },
            style: ElevatedButton.styleFrom(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50), 
                  bottomLeft: Radius.circular(50), 
                  topRight: Radius.circular(50),
                  bottomRight: Radius.circular(10)),
              ),
              primary: Colors.green[400],
              elevation: 10.0,
              padding: const EdgeInsets.only(
                right: 40.0,
                // vertical: 40.0
              ),
            ), 
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children:[
                CircleAvatar(
                  backgroundColor:
                      Colors.white, 
                  radius: 50.0,
                  child: Icon(
                    Icons.image_search_rounded,
                    color: Colors.green[800],
                    size: 40.0,
                  ),
                ),
                const SizedBox(width: 30),
                const Text('Traducir Texto\n Imagen',
                  style: TextStyle(fontSize: 24.0,fontWeight: FontWeight.bold), 
                  textAlign: TextAlign.center,
                ),
              ] 
            ),
          // ****************************** Boton #3 ******************************

          ),
        ]
      ),
    );

  }

}
