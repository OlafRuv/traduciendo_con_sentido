import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class TraduccionesGuardadasPage extends StatefulWidget {
  const TraduccionesGuardadasPage({Key? key}) : super(key: key);

  @override
  _TraduccionesGuardadasPageState createState() => _TraduccionesGuardadasPageState();
}

class _TraduccionesGuardadasPageState extends State<TraduccionesGuardadasPage> {
CollectionReference firebaseFirestore = FirebaseFirestore.instance.collection("usuarios");

  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('usuarios').where('Nombre_usuario', isEqualTo: FirebaseAuth.instance.currentUser!.email.toString()).snapshots();



  //PARTE DONDE SE CONSULTARA A LA BD----------------------------------------------------------
  @override
  void initState() {
    super.initState();
    //obtenerUsuarios(); (//SE COMENTO TEMPORALMENTE PARA USO DE PRUEBAS)
    
  }



  Widget mostrarTraduccionesGuardadas(){
    return StreamBuilder<QuerySnapshot>(
        stream: _usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }
      
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }
          
          
          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
              return ListTile(
                //title: Text(data['Nombre_usuario']),
                title: Text(data['Titulo']),
                subtitle: Text(data['Texto_guardado']),
                //trailing: Text(data['Uid']),
                trailing: MaterialButton(
                      onPressed: (){
                        showDialog( 
                          context: context, 
                          builder: (BuildContext context) => 
                          AlertDialog(
                          title: const Text('¿Está seguro en eliminar esta traducción?'),
                          actions: [
                            MaterialButton(
                              onPressed: () {
                                final rutaTraduccionesGuardadas = MaterialPageRoute(
                                      builder: (context){
                                        return TraduccionesGuardadasPage();
                                      }
                                    );
                                  Navigator.push( context, rutaTraduccionesGuardadas);
                              },
                              textColor: Theme.of(context).primaryColor,
                              child: const Text('Cancelar'),
                            ),
                            MaterialButton(
                              onPressed: () {
                                print("DOCUMENTO ELIMINDADO: " + document.id);
                                FirebaseFirestore.instance.collection('usuarios').doc(document.id).delete(); //GRACIAS A QUE ACCEDEMOS MEDIANTE EL ID DEL DOCUMENTO, LA ELIMINACION ES MAS SENCILLA
                                final rutaTraduccionesGuardadas = MaterialPageRoute(
                                      builder: (context){
                                        return TraduccionesGuardadasPage();
                                      }
                                    );
                                  Navigator.push( context, rutaTraduccionesGuardadas);
                              },
                              textColor: Theme.of(context).primaryColor,
                              child: const Text('Eliminar'),
                            ),
                          ],
                        )
                        );
                        
                        /*showDialog( //ALERTA DIALOG QUE NOS SERVIRA PARA ALERTAR AL USUARIO QUE SE GUARDO CON EXITO SU TEXTO
                          context: context, 
                          builder: (BuildContext context) => popUpEliminarRegistro(context)
                        );*/
                        //=============================================
                        //print("DOCUMENTO ELIMINDADO: " + document.id);
                        //FirebaseFirestore.instance.collection('usuarios').doc(document.id).delete(); //GRACIAS A QUE ACCEDEMOS MEDIANTE EL ID DEL DOCUMENTO, LA ELIMINACION ES MAS SENCILLA
                        //===========================================
                        
                      },
                      child: const Text('Eliminar'),
                    ),
                    
                /*onTap: (){
                  print("DOCUMENTO ELIMINDADO: " + document.id);
                  FirebaseFirestore.instance.collection('usuarios').doc(document.id).delete(); //GRACIAS A QUE ACCEDEMOS MEDIANTE EL ID DEL DOCUMENTO, LA ELIMINACION ES MAS SENCILLA
                },*/
                /*Row(
                  children: [
                    MaterialButton(
                      onPressed: (){},
                      child: const Text('Imprimir'),
                    ),
                    MaterialButton(
                      onPressed: (){},
                      child: const Text('Eliminar'),
                    )
                  ],
                ),*/

              );
            }).toList(),
          );
          
        },
          );
  }



  
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
          mostrarTraduccionesGuardadas()
        ] 
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


  //POPUP QUE APARECERA CUANDO QUIERA ELIMINARSE EL REGISTRO DESEADO
  Widget popUpEliminarRegistro(BuildContext context) {
  return AlertDialog(
    title: const Text('¿Está seguro en eliminar esta traducción?'),
    actions: [
      MaterialButton(
        onPressed: () {
          final rutaTraduccionesGuardadas = MaterialPageRoute(
                builder: (context){
                  return TraduccionesGuardadasPage();
                }
              );
            Navigator.push( context, rutaTraduccionesGuardadas);
        },
        textColor: Theme.of(context).primaryColor,
        child: const Text('Cancelar'),
      ),
      MaterialButton(
        onPressed: () {
          final rutaTraduccionesGuardadas = MaterialPageRoute(
                builder: (context){
                  return TraduccionesGuardadasPage();
                }
              );
            Navigator.push( context, rutaTraduccionesGuardadas);
        },
        textColor: Theme.of(context).primaryColor,
        child: const Text('Eliminar'),
      ),
    ],
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