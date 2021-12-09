import 'package:flutter/material.dart';

class ContactInformation extends StatelessWidget {
  const ContactInformation({
    Key? key,
    required this.title,
    required this.icon,
  }) : super(key: key);

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Card(
      // ignore: use_named_constants
      margin: const EdgeInsets.only(),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16.0),
            const SizedBox(width: 5),
            Text(title),
          ],
        ),
      ),
    );
  }
}
