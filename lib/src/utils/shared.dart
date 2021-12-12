import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class SharedFunction {
  Future<String?> pickImage({
    ImageSource source = ImageSource.camera,
    int imageQuality = 50,
    double maxHeight = 400,
    double maxWidth = 400,
  }) async {
    try {
      final picker = ImagePicker();
      final xFile = await picker.pickImage(
        source: source,
        imageQuality: imageQuality,
        maxHeight: maxHeight,
        maxWidth: maxWidth,
      );

      if (xFile == null) {
        return null;
      }

      final file = File(xFile.path);

      final newPath = (await getApplicationDocumentsDirectory()).path;
      final filename = p.basename(file.path);
      final moveFile = await file.copy('$newPath/$filename');
      return moveFile.path;
    } catch (e) {
      rethrow;
    }
  }
}

final sharedFunction = SharedFunction();
