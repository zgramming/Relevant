import 'package:flutter/material.dart';
import '../../../utils/utils.dart';

class ContactInformation extends StatelessWidget {
  const ContactInformation({
    Key? key,
    required this.icon,
    required this.title,
    this.onTap,
    this.isActive = false,
  }) : super(key: key);

  final IconData icon;
  final String title;
  final void Function()? onTap;
  final bool isActive;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Ink(
        decoration: BoxDecoration(
          color: !isActive ? darkGrey400 : Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: const [
            BoxShadow(
              color: Colors.black45,
              blurRadius: 1.0,
            ),
          ],
        ),
        // ignore: use_named_constants
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
      ),
    );
  }
}
