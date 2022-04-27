import 'package:flutter/material.dart';

import 'package:TCS/utils/validators.dart';
import 'package:TCS/widgets/widgets.dart';

class InicioSesionRecuperarPage extends StatelessWidget {
  const InicioSesionRecuperarPage({
    Key? key
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Agregamos el background que creamos como widget
          const CustomHalfBackground(title: 'Recupere Su Sesion'),
          // Agregamos la credential card que creamos como widget
          CredentialCard(
            cardTitle: 'Ingrese su Correo Electronico', 
            cardForm: _buildForm(context), //Llamamos como el cuerpo de la tarjeta el BuildForm
          ),
        ],
      ),
    );
  }

  Widget _buildForm(BuildContext context) {
    return Form(
      // key: _key,
      child: Column(
        children: [
          // Aniadimos un texfield form personalizado
          const TextFieldForm(
            keyboardType: TextInputType.emailAddress,
            icon: Icons.alternate_email,
            hintText: 'nombre@correo.com',
            labelText: 'Correo Electronico',
            // controller: correoController,
            validator: validarEmail, 
            hasNextFocus: false, 
            obscureText: false,
          ),
          // Aniadimos un sizeb box que nos de espacio
          const SizedBox(height: 30),
          // Aniadimos un boton personalizado
          CustomButton(
            buttontext: 'Recuperar Credenciales', 
            elevationButton: 0,
            padHButton: 20.0,
            padVButton: 20.0,
            // El boton personalizado al ser presionado hace validaciones con la bd y nos  
            // envia el correo para despues redirigirnos a la pagina de iniciar sesión
            onPressedFunction: (){
              // Esta funcion abre el PopUp con la confirmacion del correo enviado
              showDialog(
                context: context, 
                builder: (BuildContext context) => 
                CustomPopUp(
                  title: 'Se envio la contraseña a su correo', 
                  content: const Text('Una vez consultada su contraseña por favor ingresela en el inicio de sesión',
                    textAlign: TextAlign.justify,
                    style: TextStyle(fontSize: 20)
                  ), 
                  buttonText: 'Continuar',
                  onPressedFunction: () {
                    Navigator.pushNamed( 
                      context, 
                      'iniciar_sesion');
                  }
                ),
                // _popUpRecuperarCredenciales(context)
              );
            },
          ),
        ],
      ),
    );
  }

}