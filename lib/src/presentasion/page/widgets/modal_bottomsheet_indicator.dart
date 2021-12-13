import 'package:flutter/material.dart';

import '../../../utils/colors.dart';

class ModalBottomSheetIndicator extends StatelessWidget {
  const ModalBottomSheetIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 10),
        Center(
          child: Container(
            height: 5,
            width: 30,
            decoration: BoxDecoration(
              color: darkGrey400,
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
