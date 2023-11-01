import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  const TextFormFieldWidget({
    super.key,
    required this.controller,
    required this.title,
    required this.hintText,
    this.maxLines,
  });

  final TextEditingController controller;
  final String title;
  final String hintText;
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
    );
  }
}
