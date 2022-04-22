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
      body: SingleChildScrollView(
        //SIMILAR A LISTVIEW, LA DIFERENCIA ES QUE ABARCA TODA LA PANTALLA
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // const SizedBox(height: 50,),
              // _tituloDescripcion(), 
              Container(
                child: const Image(image: AssetImage('assets/TraduciendoConSentidoSml.png'),height:220.0),
                  padding: const EdgeInsets.only(top: 0,bottom:0),
                  width:MediaQuery.of(context).size.width * 1,
                decoration: BoxDecoration(
                  // color: Colors.green[400],
                  gradient: LinearGradient(
                    colors: [
                      // AppTheme.grad1,
                      // AppTheme.grad2,
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
                // height: 100.0,
              const SizedBox(height: 20,),
              _botonesMenu()
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavigation(botonBarraActual: 0),
    );
  }

  //SECCION DONDE SE LLAMARAN A LAS FUNCIONES DE LOS BOTONES
  Widget _botonesMenu() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          ElevatedButton(
            onPressed: (){
              Navigator.pushNamed(context, 'traducir_texto');
            },
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
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
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
          ),
        ]
      ),
    );

  }

}
