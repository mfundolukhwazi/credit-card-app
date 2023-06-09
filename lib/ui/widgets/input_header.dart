import 'package:flutter/material.dart';

class InputHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  const InputHeader({Key? key, required this.title, required this.subtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        subtitle == null || subtitle == ""
            ? const SizedBox.shrink()
            : Text(
                subtitle!,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: Colors.grey, fontWeight: FontWeight.normal),
              ),
        const SizedBox(height: 10),
      ],
    );
  }
}
