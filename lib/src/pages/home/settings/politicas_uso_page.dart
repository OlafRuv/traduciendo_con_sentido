//import 'package:diseno_inicial/src/pages/home/widgets/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';


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
        title: Text('POLITICAS DE USO'),
        backgroundColor: Colors.green[800],
      ),

      
      body: Stack(
        children: [
          _fondoApp(),

          SingleChildScrollView( //SIMILAR A LISTVIEW, LA DIFERENCIA ES QUE ABARCA TODA LA PANTALLA
              child: Column(
                children: [
                  _tituloDescripcion(),
                  _textoPoliticasDeUso()
                ],
              ),
            )
        ],
      ),
      bottomNavigationBar: _bottomNavigationBar(context),
    );
  }



  Widget _fondoApp(){
    final gradiente = Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
    );
    
    return Stack(
      children: [
        gradiente,
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
              Text('Politicas de uso de Traduciendo con sentido', style:TextStyle( color: Colors.black87, fontSize: 30.0, fontWeight: FontWeight.bold),),
              SizedBox( height: 10.0),            ],
          )
      ),
    );
  }


  Widget _textoPoliticasDeUso(){
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Text('El Usuario reconoce y acepta que el uso de los contenidos y/o servicios ofrecidos por la presente aplicación móvil o web será bajo su exclusivo riesgo y/o responsabilidad. El Usuario se compromete a utilizar la presente aplicación móvil y todo su contenido y Servicios de conformidad con la ley, la moral, el orden público y las presentes Condiciones de Uso, y las Condiciones Particulares que, en su caso, le sean de aplicación. Asimismo, se compromete hacer un uso adecuado de los servicios y/o contenidos de la aplicación móvil que atenten contra los derechos de terceros y/o que infrinjan la regulación sobre propiedad intelectual e industrial, o cualesquiera otras normas del ordenamiento jurídico aplicable. En particular, el Usuario se compromete a no trasmitir, introducir, difundir y poner a disposición de terceros, cualquier tipo de material e información (datos contenidos, archivos e imagen) que sean contrarios a la ley, la moral, el orden público y las presentes Condiciones de Uso y, en su caso, a las Condiciones Particulares que le sean de aplicación. A título enunciativo, y en ningún caso limitativo o excluyente, el Usuario se compromete a:  \n- No introducir o difundir contenidos o propaganda de carácter racista, xenófobo, pornográfico, de apología del terrorismo o que atenten contra los derechos humanos. \n- No introducir o difundir en la red programas de datos (virus y software nocivo) susceptibles de provocar daños en los sistemas informáticos del proveedor de acceso, sus proveedores o terceros usuarios de la red Internet. \n- No difundir, transmitir o poner a disposición de terceros cualquier tipo de información, elemento o contenido que atente contra los derechos fundamentales y las libertades públicas reconocidos constitucionalmente y en los tratados internacionales. \n- No difundir, transmitir o poner a disposición de terceros cualquier tipo de información, elemento o contenido que constituya publicidad ilícita o desleal. \n- No transmitir publicidad no solicitada o autorizada, material publicitario, "correo basura", "cartas en cadena", "estructuras piramidales", o cualquier otra forma de solicitación. \m- No introducir o difundir cualquier información y contenidos falsos, ambiguos o inexactos de forma que induzca a error a los receptores de la información. \n- No suplantar a otros usuarios utilizando sus claves de registro a los distintos servicios y/o contenidos. \n- No difundir, transmitir o poner a disposición de terceros cualquier tipo de información, elemento o contenido que suponga una violación del secreto de las comunicaciones y la legislación de datos de carácter personal. \n\nEXCLUSION DE GARANTÍAS. RESPONSABILIDAD\n Traduciendo con sentido no garantiza en todo momento la disponibilidad de acceso y continuidad del funcionamiento de la presente aplicación móvil y de sus servicios, por lo que Traduciendo con sentido no será responsable, con los límites establecidos en el Ordenamiento Jurídico vigente, de los daños y perjuicios causados al Usuario como consecuencia de la indisponibilidad, fallos de acceso y falta de continuidad de la presente aplicación móvil o web y sus Servicios. Traduciendo con sentido responderá única y exclusivamente de los Servicios que preste por sí misma y de los contenidos directamente originados e identificados con su copyright. Dicha responsabilidad quedará excluida en los casos en que concurran causas de fuerza mayor o en los supuestos en que la configuración de los dispositivos del Usuario no sea la adecuada para permitir el correcto uso de los servicios de Internet prestados por Traduciendo con sentido. La descarga, acceso y uso de la aplicación en los dispositivos móviles o similares, no implica la obligación por parte de Traduciendo con sentido de controlar la ausencia de virus, gusanos o cualquier otro elemento informático dañino. Corresponde al Usuario, en todo caso, la disponibilidad de herramientas adecuadas para la detección y desinfección de programas informáticos dañinos. \n\nCONDUCTA DE LOS USUARIOS\n Traduciendo con sentido no garantiza que los Usuarios de la presente aplicación móvil utilicen los contenidos y/o servicios del mismo de conformidad con la ley, la moral, el orden público, ni las presentes Condiciones Generales y, en su caso, las condiciones Particulares que resulten de aplicación. Asimismo, no garantiza la veracidad y exactitud, exhaustividad y/o autenticidad de los datos proporcionados por los Usuarios.  Traduciendo con sentido no será responsable, indirecta ni subsidiariamente, de los daños y perjuicios de cualquier naturaleza derivados de la utilización de los Servicios y Contenidos de la aplicación por parte de los Usuarios o que puedan derivarse de la falta de veracidad, exactitud y/o autenticidad de los datos o informaciones proporcionadas por los Usuarios, o de la suplantación de la identidad de un tercero efectuada por un Usuario en cualquier clase de actuación a través de la presente aplicación móvil o web. Por lo tanto, el uso de esta aplicación no implica la obligación por parte de Traduciendo con sentido de comprobar la veracidad, exactitud, adecuación, idoneidad, exhaustividad y actualidad de la información suministrada a través de la misma. Traduciendo con sentido no se responsabiliza de las decisiones tomadas a partir de la información suministrada a través de la aplicación ni de los daños y perjuicios producidos en el Usuario o terceros con motivo de actuaciones que tengan como único fundamento la información obtenida en la aplicación. '),
      );
  }
    



  Widget _bottomNavigationBar( BuildContext context){ 
  int _botonBarraActual = 2;
  
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