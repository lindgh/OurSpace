import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

pickImage(ImageSource source) async {
  final ImagePicker imagePicker = ImagePicker();
  XFile? _file = await imagePicker.pickImage(source: source);

  if (_file != null) {
    print('Path of file picked: ${_file.path}\n');
    return await _file.readAsBytes();
  }

  print('No images selected!');
}