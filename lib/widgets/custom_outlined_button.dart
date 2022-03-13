import 'package:flutter/material.dart';

class CustomOutlinedButton extends StatelessWidget {
  final String textContent;
  final double textSize;
  final String route;
  const CustomOutlinedButton({
    Key? key, 
    required this.textContent, 
    required this.textSize, 
    required this.route
  }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return OutlinedButton(
      onPressed: (){
        Navigator.pushNamed(context, route);
      }, 
      child: Text(
        textContent,
        style: TextStyle(
          fontSize: textSize),
      )
    );
  }
}