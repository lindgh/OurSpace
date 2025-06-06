import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../lib/pages/create_profile.dart';
import '../../lib/models/pickImage.dart';
import 'package:image_picker/image_picker.dart';
import '../mocks.mocks.dart';
import 'package:mockito/mockito.dart';


class MockImagePicker extends Mock {
  Future<Uint8List> call(ImageSource source);
}

void main() {
  testWidgets('selectImage sets userImage with picked image', (tester) async {
    final fakeImage = Uint8List.fromList([1, 2, 3, 4]);

    final mockPickImage = (ImageSource source) async => fakeImage;

    final widget = CreateProfilePage(pickImageFn: mockPickImage);
    await tester.pumpWidget(MaterialApp(home: widget));

    final state = tester.state(find.byType(CreateProfilePage)) as dynamic;

    await state.selectImage();

    expect(state.userImage, equals(fakeImage));
  });
}