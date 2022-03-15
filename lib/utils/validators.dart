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

String? validarPassword(String? formularioPassword){ //Editado
  if(formularioPassword ==null || formularioPassword.isEmpty){
    return 'Contraseña requerida';
  }

  String patron = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~.]).{6,}$';
  RegExp regex = RegExp(patron);
  if(!regex.hasMatch(formularioPassword)){
    return 'La contraseña debe de tener al menos 6 caracteres, incluyendo alguna letra mayuscula, minuscula, numero y simbolo';
  }
    return null;
}