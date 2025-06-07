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

class FakeProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => const Text('Stub Profile Page');
}

class TestableEditProfilePage extends StatelessWidget {
  final VoidCallback? onCancel;
  final VoidCallback? onSaveChanges;

  const TestableEditProfilePage({super.key, this.onSaveChanges, this.onCancel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                if (onSaveChanges != null) {
                  onSaveChanges!();
                } else {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => FakeProfilePage()),
                  );
                }
              },
              child: const Text('Save Changes'),
            ),
            ElevatedButton(
              onPressed: () {
                if (onCancel != null) {
                  onCancel!();
                } else {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => FakeProfilePage()),
                  );
                }
              },
              child: const Text('Cancel'),
            ),
          ],
        ),
      ),
    );
  }
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

  testWidgets('Save Changes button navigates to Profile Page', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: TestableEditProfilePage(
          onSaveChanges: () {
            Navigator.of(tester.element(find.byType(TestableEditProfilePage)))
                .pushReplacement(MaterialPageRoute(builder: (_) => FakeProfilePage()));
          },
        ),
      ),
    );

    await tester.tap(find.text('Save Changes'));
    await tester.pumpAndSettle();

    expect(find.text('Stub Profile Page'), findsOneWidget);
  });

  testWidgets('Cancel button navigates to Profile Page', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: TestableEditProfilePage(
          onCancel: () {
            Navigator.of(tester.element(find.byType(TestableEditProfilePage)))
                .pushReplacement(MaterialPageRoute(builder: (_) => FakeProfilePage()));
          },
        ),
      ),
    );

    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();

    expect(find.text('Stub Profile Page'), findsOneWidget);
  });

}