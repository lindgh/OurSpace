import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../lib/services/upload/add_data.dart';
import '../mocks.mocks.dart';

void main() {
  late MockStoreData mockStoreData;
  late Uint8List fakeImage;

  setUp(() {
    mockStoreData = MockStoreData();
    fakeImage = Uint8List.fromList([0, 1, 2, 3]);
  });


  test('uploadUserInfo uploads image and saves data', () async {

    final newImageURL = "http://fakeurl.com/image.jpg";

    when(mockStoreData.uploadImageToStorage(any)).thenAnswer((_) async => newImageURL);
    when(mockStoreData.saveData(
      name: anyNamed('name'),
      major: anyNamed('major'),
      college: anyNamed('college'),
      gradYear: anyNamed('gradYear'),
      biography: anyNamed('biography'),
      imageURL: anyNamed('imageURL'),
    )).thenAnswer((_) async => 'success');

    final result = await mockStoreData.saveData(
      name: "Test Name",
      major: "Test Major",
      college: "Test College",
      gradYear: "Test Year",
      biography: "Test Bio",
      imageURL: newImageURL,
    );

    expect(result, 'success');
    verify(mockStoreData.saveData(
      name: "Test Name",
      major: "Test Major",
      college: "Test College",
      gradYear: "Test Year",
      biography: "Test Bio",
      imageURL: newImageURL,
    )).called(1);
  });
}
