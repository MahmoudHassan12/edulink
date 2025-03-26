import 'dart:io' show File;
import 'package:image_picker/image_picker.dart' show ImagePicker, ImageSource;

Future<File?> pickImage() => ImagePicker()
    .pickImage(source: ImageSource.gallery)
    .then((image) => image != null ? File(image.path) : null);
