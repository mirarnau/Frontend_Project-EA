import 'package:flutter/material.dart';

class TextFieldWidget extends StatefulWidget {
  final String label;
  final String text;
  final ValueChanged<String> onChanged;

  const TextFieldWidget(
      {required this.label, required this.text, required this.onChanged});

  @override
  _TextFieldWidgetState createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [],
      );
}
