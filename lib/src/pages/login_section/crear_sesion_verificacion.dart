import 'package:flutter/material.dart';

import 'package:TCS/src/pages/login_section/crear_sesion_password_page.dart';
import 'package:TCS/widgets/widgets.dart';

class CrearSesionVerificacionPage extends StatelessWidget {
  const CrearSesionVerificacionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Agregamos el background que creamos como widget
          const CustomHalfBackground(title: 'Crear Contraseña'),
          // Agregamos la credential card que creamos como widget 
          CredentialCard(
            cardTitle: 'Ingrese la clave de Verificacion',
            // Llamamos como el cuerpo de la tarjeta nuestra verificacion de clave de confirmacion 
            cardForm: _crearClave(context), 
          ),
          // _loginForm(context),
        ],
      ),
    );
  }

  // Creamos la forma de verificacion de la clave de confirmacion
  Widget _crearClave( BuildContext context) {
    String email=''; 
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              icon: Icon(Icons.vpn_key, color: Colors.green[800], ),
              labelText: 'Clave de verificación',
            ),
          ),
        ),
        // Aniadimos un sizeb box que nos de espacio
        const SizedBox(height: 30),
        // Aniadimos un boton personalizado
        CustomButton(
          buttontext: 'Confirmar', 
          elevationButton: 0,
          padHButton: 80.0,
          padVButton: 20.0,
          // El boton personalizado al ser presionado hace validaciones con la bd y nos redirige 
          // a la pagina de menu principal de la aplicacion
          onPressedFunction: (){
            final rutaCrearPassword = MaterialPageRoute(
                    builder: (context){
                      return CrearSesionPasswordPage(email); //Editado
                    }
                  );
                Navigator.push( context, rutaCrearPassword);
          },
        ),
      ],
    );
  }
}