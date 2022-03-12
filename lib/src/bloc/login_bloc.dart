import 'dart:async';

class LoginBloc {

  //STREAM CONTROLERS
  final _emailController = StreamController<String>.broadcast(); //EL BROADCAST SIRVE PARA QUE VARIAS INSTANCIAS PUEDAN ESTAR ESCUCHANDO ESOS CAMBIOS
  final _passwordController = StreamController<String>.broadcast();


  //INSERTAR VALORES AL STREAM
  Function(String) get changeEmail => _emailController.sink.add; //VA A APUNTAR AL EMAILCONTROLLER MANDANDOLA COMO REFERENCIA
  Function(String) get changePassword => _passwordController.sink.add;


  //RECUPERAR LOS DATOS DEL STREAM
  Stream<String> get emailStream => _emailController.stream; //CON EL STREAM AYUDA A ESCUCHAR CUANDO ALGO SALGA DE ALLI MEDIANTE EL EMAILSTREAM
  Stream<String> get passwordStream => _passwordController.stream;


  //METODO PARA CERRAR LOS CONTROLLER CUANDO NO SEAN NECESARIOS
  dispose() {
    _emailController.close(); //EL SIGNO DE INTERROGACION NOS SIRVE PARA EN EL CASO DE QUE SI ALGUN CONTROLLER FUERA NULL NO EJECUTA EL CLOSE()
    _passwordController.close();
  }
}