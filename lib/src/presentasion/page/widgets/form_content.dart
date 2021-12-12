import 'package:flutter/material.dart';

import '../../../utils/utils.dart';

class FormContent extends StatelessWidget {
  const FormContent({
    Key? key,
    required this.title,
    required this.child,
  }) : super(key: key);

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          title,
          style: lato.copyWith(fontSize: 16.0),
        ),
        const SizedBox(height: 10),
        child,
      ],
    );
  }
}
