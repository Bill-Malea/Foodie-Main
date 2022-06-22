import 'package:flutter/material.dart';

class FormInputFieldWithIcon extends StatelessWidget {
  const FormInputFieldWithIcon({
    Key? key,
    //required this.iconPrefix,
    required this.labelText,
    required this.validator,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    required this.onchanged,
  }) : super(key: key);

  final String labelText;
 
  final String? Function(String?) validator;
  final TextInputType keyboardType;
  final bool obscureText;
  final void Function(String?) onchanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: TextFormField(
      
        style: const TextStyle(
          fontSize: 16,
        ),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 10,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          border: InputBorder.none,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(
              width: 0.0,
              color: Colors.red,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(
              width: 0.0,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(
              color: Colors.indigo,
              width: 0.0,
            ),
          ),
          labelStyle: const TextStyle(
            fontSize: 14,
          ),
          labelText: labelText,
          filled: true,
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(
              width: 1.0,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(
              width: 1.0,
            ),
          ),
          errorStyle: const TextStyle(
            fontSize: 14,
          ),
        ),
       
        keyboardType: TextInputType.number,
        obscureText: obscureText,
        validator: validator,
        onChanged: onchanged,
      ),
    );
  }
}