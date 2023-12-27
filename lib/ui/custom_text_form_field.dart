import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gracesoft/core/constants/app_colors.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField(

    {required this.controller,
      this.validator,
  
      this.keyboardType,
      this.hint,
      this.validate,
    
      this.borderRadius = 10.0,
      Key? key})
      : super(key: key);

  final TextEditingController controller;
  final String? Function(String?)? validator;

  final TextInputType? keyboardType;
  final AutovalidateMode? validate;
  final String? hint;

  final double borderRadius;


  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      keyboardType: widget.keyboardType,
      autovalidateMode: widget.validate,
      decoration: InputDecoration(
        hintText: widget.hint,
        contentPadding: const EdgeInsets.all(16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
        )
      ),
    );
  }
}