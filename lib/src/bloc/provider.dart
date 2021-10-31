import 'package:flutter/material.dart';
import 'package:tcs/src/bloc/login_bloc.dart';

class Provider extends InheritedWidget {

  final loginBloc = LoginBloc();

  Provider(Key key, Widget child)
    : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true; //AL ACTUALIZARSE DEBE NOTIFICAR A SUS HIJOS 

  //VA A BUSCAR INTERNAMENTE EN EL ARBOL DE WIDGETS VA A RETORNAR EL BLOC
  static LoginBloc of (BuildContext context){
 
    return (context.dependOnInheritedWidgetOfExactType<Provider>() as Provider).loginBloc;
  }
  
}