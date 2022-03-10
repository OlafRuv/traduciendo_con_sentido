import 'package:flutter/material.dart';
import 'package:tcs/src/pages/login_section/crear_sesion_password_page.dart';

class CrearSesionPage extends StatefulWidget {
  
  //const CrearSesionPage({Key? key}) : super(key: key);
  @override
  State<CrearSesionPage> createState() => _CrearSesionPageState();
}

class _CrearSesionPageState extends State<CrearSesionPage> {
  final correoController = TextEditingController(); //NOS AYUDA A TENER UN CONTROL EN EL VALOR DEL TEXTFIELD Y LE NOTIFICA AL OYENTE PARA QUE INTERPRETE EL TEXTO
  String correo = ''; //SE USUARA PARA PASAR EL VALOR DEL CORREO A LA OTRA PAGINA DE PASSWORD

  final GlobalKey<FormState> _key = GlobalKey<FormState>(); //Editado


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        
        children: [
          _crearFondo(context),
          _loginForm(context),
        ],
      ),
    );
  }

  Widget _crearFondo(BuildContext context){

    final size = MediaQuery.of(context).size; //PARA OCUPAR EL 40% DE LA PANTALLA
    final colorFondo = Container(
      height: size.height * 0.4,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.lightGreen,
            Color.fromRGBO(0, 150, 28, 1.0),
          ]
        )
      ),
    );


    final circuloFondo = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        color: Color.fromRGBO(255, 255, 255, 0.05)
      )
    );


    return Stack(
      children: [
        colorFondo,
        Positioned( top: 90.0, left: 30.0, child: circuloFondo ),
        Positioned( top: -40.0, right: -30.0, child: circuloFondo ),
        Positioned( bottom: -50.0, left: -10.0, child: circuloFondo ),
        
        Container(
          padding: EdgeInsets.only(top: 80.0),
          child: Column(
            children: [
              Icon(Icons.person_pin_circle, color: Colors.white, size: 100.0,),
              SizedBox(height: 10.0, width: double.infinity),
              Text('Bienvenido', style: TextStyle(color: Colors.white, fontSize: 25.0),)
            ],
          ),
        )
      ],
    );
  }

  Widget _loginForm(BuildContext context){

    final size = MediaQuery.of(context).size;//SACAR DIMESIONES DE LA PANTALLA

    return SingleChildScrollView( //ME VA A PERMITIR HACER SCROLL DEPENDIENDO DEL TAMAÑO DEL HIJO
      
      child: Column(
        children: [
          SafeArea(
            child: Container(
              height: 180.0,
            ),
          ),
          Container(
            width: size.width * 0.85,
            margin: EdgeInsets.symmetric(vertical: 30.0),
            padding: EdgeInsets.symmetric(vertical: 50.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 3.0,
                  offset: Offset(0.0, 5.0),
                  spreadRadius: 3.0,
                )
              ]

            ),
            child: Column
            (children: [
                Text('Crear sesión', style: TextStyle(fontSize: 20.0),),
                SizedBox(height: 60.0,),
                _crearEmail(),
                SizedBox(height: 30.0,),
                //_botonConfirmar(context)
              ],
            ),
          ),
        ],
      ),
    );
  }




  Widget _crearEmail() {
    return Form(
      key: _key, //Editado
      child: Column(
        children: [
          Container(
            
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                icon: Icon(Icons.alternate_email, color: Colors.green[800], ),
                hintText: 'nombre@correo.com',
                labelText: 'Correo electronico',
    
              ),
              controller: correoController, //Editado
              validator: validarEmail, //Editado
            ),
          ),
          MaterialButton(
        onPressed: (){
          
          if (_key.currentState!.validate()){ //Editado
            correo = correoController.text; //Editado
            final rutaVerificacion = MaterialPageRoute(
                  builder: (context){
                    //return CrearSesionVerificacionPage(); //Editado
                    return CrearSesionPasswordPage(correo); //Editado
                  }
                );
              Navigator.push( context, rutaVerificacion);
          }
          
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
          child: Text('Confirmar'),
        ),
        shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(30.0), ),
        elevation: 0.0,
        color: Colors.green[800],
        textColor: Colors.white,
      ),
    
        ],
      ),
    );
  }



  String? validarEmail(String? formularioEmail){ //Editado
    if(formularioEmail ==null || formularioEmail.isEmpty){
      return 'Correo electronico requerido';
    }

    String patron = r'\w+@\w+\.\w+';
    RegExp regex = RegExp(patron);
    if(!regex.hasMatch(formularioEmail)){
      return 'Formato de Correo Electronico invalido.';
    }
      return null;
  }







  /*
  Widget _crearEmail() {
    return Container(
      
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          icon: Icon(Icons.alternate_email, color: Colors.green[800], ),
          hintText: 'nombre@correo.com',
          labelText: 'Correo electronico',

        ),
        controller: correoController, //Editado
        validator: validarEmail, //Editado
      ),
    );
  }



  String? validarEmail(String? formularioEmail){ //Editado
    if(formularioEmail ==null || formularioEmail.isEmpty){
      return 'Correo electronico requerido';
    }
      return null;
  }


  Widget _botonConfirmar(BuildContext context){
    return MaterialButton(
      onPressed: (){
        
        if (_key.currentState!.validate()){ //Editado
          correo = correoController.text; //Editado
          final rutaVerificacion = MaterialPageRoute(
                builder: (context){
                  //return CrearSesionVerificacionPage(); //Editado
                  return CrearSesionPasswordPage(correo); //Editado
                }
              );
            Navigator.push( context, rutaVerificacion);
        }
        
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
        child: Text('Confirmar'),
      ),
      shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(30.0), ),
      elevation: 0.0,
      color: Colors.green[800],
      textColor: Colors.white,
    );
  }*/
}