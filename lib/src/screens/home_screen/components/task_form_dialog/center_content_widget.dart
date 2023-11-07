import 'package:flutter/material.dart';

class CenterContentWidget extends StatelessWidget {
  const CenterContentWidget({
    super.key,
    required this.content,
  });

  final Widget content;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.0,
      width: double.infinity,
      child: Center(
        child: content,
      ),
    );
  }
}
