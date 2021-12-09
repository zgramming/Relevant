import 'package:flutter/material.dart';
import 'package:global_template/global_template.dart';

import '../../../../utils/utils.dart';

class FormContent extends StatelessWidget {
  const FormContent({
    Key? key,
    required this.textFormFieldCustom,
    required this.title,
  }) : super(key: key);

  final TextFormFieldCustom textFormFieldCustom;
  final String title;

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
        textFormFieldCustom,
      ],
    );
  }
}
