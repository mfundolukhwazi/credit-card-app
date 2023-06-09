import 'package:creditcard/ui/widgets/input_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextInput extends StatefulWidget {
  final TextEditingController textEditingController;
  final String title;
  final String? subtitle;
  final Function(String?) onSaved;
  final Function(String?) onValidate;
  final List<TextInputFormatter> inputFormatters;
  final bool isTextEditable;

  const TextInput(
      {Key? key,
      required this.textEditingController,
      required this.title,
      this.subtitle,
      required this.onSaved,
      required this.onValidate,
      required this.inputFormatters,
      required this.isTextEditable})
      : super(key: key);

  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        InputHeader(title: widget.title, subtitle: widget.subtitle),
        TextFormField(
          controller: widget.textEditingController,
          enabled: widget.isTextEditable,
          onSaved: (newValue) => widget.onSaved(newValue),
          validator: (value) => widget.onValidate(value),
          inputFormatters: widget.inputFormatters,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey.shade200,
            border: const OutlineInputBorder(),
          ),
        ),
      ],
    );
  }
}
