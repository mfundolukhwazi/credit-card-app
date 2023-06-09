import 'package:creditcard/ui/widgets/input_header.dart';
import 'package:flutter/material.dart';
import 'package:search_choices/search_choices.dart';

class DropDownInput extends StatefulWidget {
  final String title;
  final String? subtitle;
  final List<String> options;
  final Function(String) onDropdownChange;
  const DropDownInput(
      {Key? key,
      required this.title,
      this.subtitle,
      required this.onDropdownChange,
      required this.options})
      : super(key: key);

  @override
  State<DropDownInput> createState() => _DropDownInputState();
}

class _DropDownInputState extends State<DropDownInput> {
  String selectedOption = "";
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        InputHeader(title: widget.title, subtitle: widget.subtitle),
        SearchChoices.single(
          displayClearIcon: false,
          fieldPresentationFn: (Widget fieldWidget, {bool? selectionIsValid}) {
            return SizedBox(
              child: InputDecorator(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  border: const OutlineInputBorder(),
                ),
                child: fieldWidget,
              ),
            );
          },
          hint: "Select Option",
          value: selectedOption.isEmpty ? "Select Option" : selectedOption,
          items: widget.options.map(
            (val) {
              return DropdownMenuItem<String>(
                alignment: AlignmentDirectional.centerStart,
                value: val,
                child: Text(val),
              );
            },
          ).toList(),
          onChanged: ((value) {
            setState(() {
              widget.onDropdownChange(value!);
              selectedOption = value;
            });
          }),
          isExpanded: true,
        )
      ],
    );
  }
}
