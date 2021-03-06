//import 'package:diseno_inicial/src/pages/home/widgets/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:TCS/widgets/widgets.dart';

// * Screen de Politicas de Uso
class PoliticasDeUsoPage extends StatefulWidget {
  const PoliticasDeUsoPage({Key? key}) : super(key: key);

  @override
  _PoliticasDeUsoPageState createState() => _PoliticasDeUsoPageState();
}

class _PoliticasDeUsoPageState extends State<PoliticasDeUsoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Le asignamos nombre a la pagina
        title: const Text('POLITICAS DE USO'),
      ),

      body: Stack(
        children: [
          SingleChildScrollView(
            //similar a listview, la diferencia es que abarca toda la pantalla
            child: Column(
              // Desplegamos el titulo de la seccion y su contenido, los cuales definimos en las funciones en la parte de abajo
              children: [_tituloDescripcion(), _textoPoliticasDeUso()],
            ),
          )
        ],
      ),
      bottomNavigationBar: const CustomBottomNavigation(botonBarraActual: 2),
    );
  }

  // Seccion de texto de inicio
  Widget _tituloDescripcion() {
    return SafeArea(
      child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Politicas de uso de Traduciendo con sentido',
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10.0),
            ],
          )),
    );
  }

  // Seccion del contenido de las politicas de Uso
  Widget _textoPoliticasDeUso() {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: const Text(
          'El Usuario reconoce y acepta que el uso de los contenidos y/o servicios ofrecidos por la presente aplicaci??n m??vil o web ser?? bajo su exclusivo riesgo y/o responsabilidad. El Usuario se compromete a utilizar la presente aplicaci??n m??vil y todo su contenido y Servicios de conformidad con la ley, la moral, el orden p??blico y las presentes Condiciones de Uso, y las Condiciones Particulares que, en su caso, le sean de aplicaci??n. Asimismo, se compromete hacer un uso adecuado de los servicios y/o contenidos de la aplicaci??n m??vil que atenten contra los derechos de terceros y/o que infrinjan la regulaci??n sobre propiedad intelectual e industrial, o cualesquiera otras normas del ordenamiento jur??dico aplicable. En particular, el Usuario se compromete a no trasmitir, introducir, difundir y poner a disposici??n de terceros, cualquier tipo de material e informaci??n (datos contenidos, archivos e imagen) que sean contrarios a la ley, la moral, el orden p??blico y las presentes Condiciones de Uso y, en su caso, a las Condiciones Particulares que le sean de aplicaci??n. A t??tulo enunciativo, y en ning??n caso limitativo o excluyente, el Usuario se compromete a:  \n- No introducir o difundir contenidos o propaganda de car??cter racista, xen??fobo, pornogr??fico, de apolog??a del terrorismo o que atenten contra los derechos humanos. \n- No introducir o difundir en la red programas de datos (virus y software nocivo) susceptibles de provocar da??os en los sistemas inform??ticos del proveedor de acceso, sus proveedores o terceros usuarios de la red Internet. \n- No difundir, transmitir o poner a disposici??n de terceros cualquier tipo de informaci??n, elemento o contenido que atente contra los derechos fundamentales y las libertades p??blicas reconocidos constitucionalmente y en los tratados internacionales. \n- No difundir, transmitir o poner a disposici??n de terceros cualquier tipo de informaci??n, elemento o contenido que constituya publicidad il??cita o desleal. \n- No transmitir publicidad no solicitada o autorizada, material publicitario, "correo basura", "cartas en cadena", "estructuras piramidales", o cualquier otra forma de solicitaci??n. \n- No introducir o difundir cualquier informaci??n y contenidos falsos, ambiguos o inexactos de forma que induzca a error a los receptores de la informaci??n. \n- No suplantar a otros usuarios utilizando sus claves de registro a los distintos servicios y/o contenidos. \n- No difundir, transmitir o poner a disposici??n de terceros cualquier tipo de informaci??n, elemento o contenido que suponga una violaci??n del secreto de las comunicaciones y la legislaci??n de datos de car??cter personal. \n\nEXCLUSION DE GARANT??AS. RESPONSABILIDAD\n Traduciendo con sentido no garantiza en todo momento la disponibilidad de acceso y continuidad del funcionamiento de la presente aplicaci??n m??vil y de sus servicios, por lo que Traduciendo con sentido no ser?? responsable, con los l??mites establecidos en el Ordenamiento Jur??dico vigente, de los da??os y perjuicios causados al Usuario como consecuencia de la indisponibilidad, fallos de acceso y falta de continuidad de la presente aplicaci??n m??vil o web y sus Servicios. Traduciendo con sentido responder?? ??nica y exclusivamente de los Servicios que preste por s?? misma y de los contenidos directamente originados e identificados con su copyright. Dicha responsabilidad quedar?? excluida en los casos en que concurran causas de fuerza mayor o en los supuestos en que la configuraci??n de los dispositivos del Usuario no sea la adecuada para permitir el correcto uso de los servicios de Internet prestados por Traduciendo con sentido. La descarga, acceso y uso de la aplicaci??n en los dispositivos m??viles o similares, no implica la obligaci??n por parte de Traduciendo con sentido de controlar la ausencia de virus, gusanos o cualquier otro elemento inform??tico da??ino. Corresponde al Usuario, en todo caso, la disponibilidad de herramientas adecuadas para la detecci??n y desinfecci??n de programas inform??ticos da??inos. \n\nCONDUCTA DE LOS USUARIOS\n Traduciendo con sentido no garantiza que los Usuarios de la presente aplicaci??n m??vil utilicen los contenidos y/o servicios del mismo de conformidad con la ley, la moral, el orden p??blico, ni las presentes Condiciones Generales y, en su caso, las condiciones Particulares que resulten de aplicaci??n. Asimismo, no garantiza la veracidad y exactitud, exhaustividad y/o autenticidad de los datos proporcionados por los Usuarios.  Traduciendo con sentido no ser?? responsable, indirecta ni subsidiariamente, de los da??os y perjuicios de cualquier naturaleza derivados de la utilizaci??n de los Servicios y Contenidos de la aplicaci??n por parte de los Usuarios o que puedan derivarse de la falta de veracidad, exactitud y/o autenticidad de los datos o informaciones proporcionadas por los Usuarios, o de la suplantaci??n de la identidad de un tercero efectuada por un Usuario en cualquier clase de actuaci??n a trav??s de la presente aplicaci??n m??vil o web. Por lo tanto, el uso de esta aplicaci??n no implica la obligaci??n por parte de Traduciendo con sentido de comprobar la veracidad, exactitud, adecuaci??n, idoneidad, exhaustividad y actualidad de la informaci??n suministrada a trav??s de la misma. Traduciendo con sentido no se responsabiliza de las decisiones tomadas a partir de la informaci??n suministrada a trav??s de la aplicaci??n ni de los da??os y perjuicios producidos en el Usuario o terceros con motivo de actuaciones que tengan como ??nico fundamento la informaci??n obtenida en la aplicaci??n. '),
    );
  }
}
