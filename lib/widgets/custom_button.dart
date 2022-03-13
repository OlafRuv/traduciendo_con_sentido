import 'package:flutter/material.dart';
import 'package:tcs/theme/app_theme.dart';

class CustomButton extends StatefulWidget {
  final String buttontext;
  final Function()? onPressedFunction;
  final Color? colorButton;

  const CustomButton({
    Key? key, 
    required this.buttontext, 
    required this.onPressedFunction, 
    this.colorButton,
  }) : super(key: key);

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: widget.colorButton
      ),
      child: Text(
        widget.buttontext, 
        style: const TextStyle(
          fontSize: AppTheme.size20),
      ),

      onPressed: widget.onPressedFunction,
    );
  }
}