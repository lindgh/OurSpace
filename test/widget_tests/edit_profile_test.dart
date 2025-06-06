import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../lib/pages/edit_profile.dart';
import '../../lib/models/pickImage.dart';
import 'package:image_picker/image_picker.dart';
import '../mocks.mocks.dart';
import 'package:mockito/mockito.dart';


class MockImagePicker extends Mock {
  Future<Uint8List> call(ImageSource source);
}

void main() {
  testWidgets('selectEditedImage sets userImage with picked image', (tester) async {
    final fakeImage = Uint8List.fromList([1, 2, 3, 4]);

    final mockPickImage = (ImageSource source) async => fakeImage;

    final widget = EditProfilePage(pickImageFn: mockPickImage);
    await tester.pumpWidget(MaterialApp(home: widget));

    final state = tester.state(find.byType(EditProfilePage)) as dynamic;

    await state.selectEditedImage();

    expect(state.userImage, equals(fakeImage));
  });
}