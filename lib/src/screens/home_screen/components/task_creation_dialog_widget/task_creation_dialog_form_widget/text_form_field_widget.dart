import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  const TextFormFieldWidget({
    super.key,
    required this.controller,
    required this.title,
    required this.hintText,
    required this.minLength,
    required this.maxLength,
    this.maxLines,
  });

  final TextEditingController controller;
  final String title;
  final String hintText;
  final int minLength;
  final int maxLength;
  final int? maxLines;

  InputBorder get _outlineInputBorder => OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
      );

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      style: const TextStyle(
        color: Colors.white,
      ),
      decoration: InputDecoration(
        alignLabelWithHint: true,
        label: Text(
          title,
        ),
        labelStyle: TextStyle(
          color: Colors.grey.shade300,
        ),
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.grey.shade500,
        ),
        border: _outlineInputBorder,
        enabledBorder: _outlineInputBorder.copyWith(
          borderSide: BorderSide(
            color: Colors.grey.shade800,
          ),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Preencha o campo';
        } else if (value.length < minLength) {
          return 'A quantidade mínima de caracteres é $minLength';
        } else if (value.length > maxLength) {
          return 'A quantiade máxima de caracteres é $maxLength';
        }

        return null;
      },
    );
  }
}
