import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../utils/utils.dart';

class ModalBottomPickImage extends StatelessWidget {
  const ModalBottomPickImage({
    Key? key,
    required this.onPickImage,
  }) : super(key: key);

  final Function(File file) onPickImage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            // ignore: use_named_constants
            margin: const EdgeInsets.only(),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListTile(
                onTap: () async {
                  final result = await sharedFunction.pickImage(
                    maxHeight: 1000,
                    maxWidth: 1000,
                    imageQuality: 80,
                    source: ImageSource.gallery,
                  );

                  if (result != null) {
                    onPickImage(File(result));
                  }
                },
                leading: const CircleAvatar(
                  child: Icon(Icons.image),
                ),
                title: const Text('Ambil dari gallery'),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Card(
            // ignore: use_named_constants
            margin: const EdgeInsets.only(),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListTile(
                onTap: () async {
                  final result = await sharedFunction.pickImage(
                    maxHeight: 1000,
                    maxWidth: 1000,
                    imageQuality: 80,
                  );

                  if (result != null) {
                    onPickImage(File(result));
                  }
                },
                leading: const CircleAvatar(
                  child: Icon(Icons.camera),
                ),
                title: const Text('Ambil dari camera'),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
