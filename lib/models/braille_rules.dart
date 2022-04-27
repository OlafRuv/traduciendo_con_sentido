// * Regla de mayusculas para la traduccion en Braille
String mayusculas(String t){ 
  int len = t.length;
  for(int i = 0; i < len; i++) {
    var char = t[i];
    if (char != " " && char != "\n"){
      if (char.toUpperCase() == t[i]){
        t = t.substring(0, i) + "."+ t[i].toLowerCase() + t.substring(i+1, t.length);
        i++;
      }
    }
  }
  return t;
}

// * Regla de numeros para la traduccion en Braille
String numeros(String n){ 
  int len = n.length;
  for(int i = 0; i < len; i++) {
    try {
      var char = int.parse(n[i]);
      if (char == 1){n = n.substring(0, i) + "#a" + n.substring(i+1, n.length);i++;}
      if (char == 2){n = n.substring(0, i) + "#b" + n.substring(i+1, n.length);i++;}
      if (char == 3){n = n.substring(0, i) + "#c" + n.substring(i+1, n.length);i++;}
      if (char == 4){n = n.substring(0, i) + "#d" + n.substring(i+1, n.length);i++;}
      if (char == 5){n = n.substring(0, i) + "#e" + n.substring(i+1, n.length);i++;}
      if (char == 6){n = n.substring(0, i) + "#f" + n.substring(i+1, n.length);i++;}
      if (char == 7){n = n.substring(0, i) + "#g" + n.substring(i+1, n.length);i++;}
      if (char == 8){n = n.substring(0, i) + "#h" + n.substring(i+1, n.length);i++;}
      if (char == 9){n = n.substring(0, i) + "#i" + n.substring(i+1, n.length);i++;}
      if (char == 0){n = n.substring(0, i) + "#j" + n.substring(i+1, n.length);i++;}
    // ignore: empty_catches
    } on Exception {}
  }
  return n;
}

// * Funcion para la aplicacion de reglas
// Se recibe un string y se regresa un string
String aplicarReglas(String t){
  String x;
  x = mayusculas(numeros(t));
  return x;
}

  // void main(List<String> args) {
  //   String x = aplicarReglas("Este es un texto de Ejemplo\n 1 2 3 4 5 6 7 8 9 0\n Caracteres especiales\n ( á é í ó ú ñ )");
  //   print(x);
  // }