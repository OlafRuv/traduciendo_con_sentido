import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// * Esta es una pagina de error que se desplegara cuando la ruta buscada no se encuentre
// Toda la implementacion solo despliega una alerta

class AlertScreen extends StatelessWidget {
  
  const AlertScreen({Key? key}) : super(key: key);
  
  void displayDialogIOS (BuildContext context){
    showCupertinoDialog(
      context: context, 
      builder: (context){
        return CupertinoAlertDialog(
          title: const Text('Page Under Construction'),
           content: Column(
            mainAxisSize: MainAxisSize.min,
            children:const [
              Text('We are working to give you a better experience'),
              SizedBox(height: 10),
              FlutterLogo(size: 100),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context), 
              child: const Text('Cancelar',style: TextStyle(color: Colors.red),),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context), 
              child: const Text('Ok'),
            ),
          ],
        );
      }
      );
  }



  void displayDialogAndroid(BuildContext context){
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context){
        return AlertDialog(
          elevation: 5,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          title: const Text('Page Under Construction'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children:const [
              Text('We are working to give you a better experience'),
              SizedBox(height: 10),
              FlutterLogo(size: 100),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context), 
              child: const Text('Cancelar',style: TextStyle(color: Colors.red),),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context), 
              child: const Text('Ok'),
            ),

          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          // style: ElevatedButton.styleFrom(
          //   primary: AppTheme.primary,
          //   shape: const StadiumBorder(),
          //   elevation: 0,
          // ),
          child: const Padding(
            padding:  EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text('Mostrar Alerta',style: TextStyle(fontSize: 16),),
          ),
          // onPressed: () => displayDialogAndroid(context),
          onPressed: () => Platform.isAndroid 
          ? displayDialogAndroid(context)
          : displayDialogIOS(context)
        )
      ),
      floatingActionButtonLocation: 
      FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.close),
        onPressed: (){
          Navigator.pop(context);
        }
        ),
    );
  }
}