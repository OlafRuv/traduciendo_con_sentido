import 'package:flutter/material.dart';

import 'package:tcs/src/pages/login_section/crear_sesion_password_page.dart';
import 'package:tcs/utils/validators.dart';
import 'package:tcs/widgets/widgets.dart';

class CrearSesionPage extends StatefulWidget {
  const CrearSesionPage({Key? key}) : super(key: key);

  @override
  State<CrearSesionPage> createState() => _CrearSesionPageState();
}

class _CrearSesionPageState extends State<CrearSesionPage> {
  final correoController = TextEditingController(); 
  // nos ayuda a tener un control en el valor del textfield y le notifica al oyente para que interprete el texto
  String correo = ''; 
  // se usuara para pasar el valor del correo a la otra pagina de password

  final GlobalKey<FormState> _key = GlobalKey<FormState>(); //Editado

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Agregamos el background que creamos como widget
          const CustomHalfBackground(title: 'Bienvenido'),
          // Agregamos la credential card que creamos como widget 
          CredentialCard(
            cardTitle: 'Crear Sesión', 
            cardForm: _buildForm(), //Llamamos como el cuerpo de la tarjeta el BuildForm
          ),
        ],
      ),
    );
  }
    // Creamos nuestro Form 
  Widget _buildForm() {
    return Form(
      key: _key,
      child: Column(
        children: [
          // Aniadimos un texfield form personalizado
          TextFieldForm(
            keyboardType: TextInputType.emailAddress,
            icon: Icons.alternate_email,
            hintText: 'nombre@correo.com',
            labelText: 'Correo Electronico',
            controller: correoController,
            validator: validarEmail, 
            hasNextFocus: true, 
            obscureText: false,
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
            // a la pagina de crear el password de la nueva cuenta
            onPressedFunction: (){
              if (_key.currentState!.validate()){ //Editado
                correo = correoController.text; //Editado
                // TODO: Revisar este caso de enrutamiento que recibe como parametro el correo
                final rutaVerificacion = MaterialPageRoute(
                      builder: (context){
                        //return CrearSesionVerificacionPage(); //Editado
                        return CrearSesionPasswordPage(correo); //Editado
                      }
                    );
                  Navigator.push( context, rutaVerificacion);
              }
            },
          ),
        ],
      ),
    );
  }
}