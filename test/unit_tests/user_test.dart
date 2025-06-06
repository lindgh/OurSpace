import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:OurSpace/services/auth/user.dart';
import '../mocks.mocks.dart';

void main() {
  late MockFirebaseAuth mockAuth;
  late MockUser mockUser;
  late MockFirebaseFirestore mockFirestore;
  late MockCollectionReference<Map<String, dynamic>> mockUsersCollection;
  late MockDocumentReference<Map<String, dynamic>> mockCurrentUserDoc;
  late MockDocumentReference<Map<String, dynamic>> mockSwipedUserDoc;
  late MockDocumentSnapshot<Map<String, dynamic>> mockCurrentUserSnapshot;
  late MockDocumentSnapshot<Map<String, dynamic>> mockSwipedUserSnapshot;

  const currentUserId = 'UserId';
  const swipedUserId = 'swipedUserId';

  setUp(() {
    mockAuth = MockFirebaseAuth();
    mockUser = MockUser();
    mockFirestore = MockFirebaseFirestore();
    mockCurrentUserDoc = MockDocumentReference();
    mockSwipedUserDoc = MockDocumentReference();
    mockCurrentUserSnapshot = MockDocumentSnapshot();
    mockSwipedUserSnapshot = MockDocumentSnapshot();
    mockUsersCollection = MockCollectionReference();

    when(mockAuth.currentUser).thenReturn(mockUser);
    when(mockUser.uid).thenReturn(currentUserId);

    when(mockFirestore.collection('Users')).thenReturn(mockUsersCollection);
    when(mockUsersCollection.doc(currentUserId)).thenReturn(mockCurrentUserDoc);
    when(mockUsersCollection.doc(swipedUserId)).thenReturn(mockSwipedUserDoc);
    when(mockCurrentUserDoc.get()).thenAnswer((_) async => mockCurrentUserSnapshot);
    when(mockSwipedUserDoc.get()).thenAnswer((_) async => mockSwipedUserSnapshot);
  });

  // TEST FOR addInquiredUser function
  test('addInquiredUser: returns true, updates matched_users user is inquired', () async {
    when(mockSwipedUserSnapshot['inquired_users']).thenReturn([currentUserId]);

    final result = await addInquiredUser(
      swipedUserId,
      auth: mockAuth,
      firestore: mockFirestore,
    );

    expect(result, true);
    verify(mockCurrentUserDoc.update({
      'matched_users': FieldValue.arrayUnion([swipedUserId]),
    })).called(1);
    verify(mockSwipedUserDoc.update({
      'matched_users': FieldValue.arrayUnion([currentUserId]),
    })).called(1);
  });

  test('addInquiredUser: returns false, adds swipedUser to inquired_users', () async {
    when(mockSwipedUserSnapshot['inquired_users']).thenReturn([]);

    final result = await addInquiredUser(
      swipedUserId,
      auth: mockAuth,
      firestore: mockFirestore,
    );

    expect(result, false);
    verify(mockCurrentUserDoc.update({
      'inquired_users': FieldValue.arrayUnion([swipedUserId])
    })).called(1);
    verifyNever(mockSwipedUserDoc.update(any));
  });


  // TEST FOR fetchCurrentUser function
  test('fetchCurrentUser: returns UserData when document exists', () async {
    final data = {
      'uid': currentUserId,
      'Email': 'test@gmail.com',
      'Name': 'Test User',
    };

    when(mockCurrentUserSnapshot.exists).thenReturn(true);
    when(mockCurrentUserSnapshot.data()).thenReturn(data);

    final result = await UserData.fetchCurrentUser(
      auth: mockAuth,
      firestore: mockFirestore,
    );

    expect(result, isNotNull);
    expect(result!.UserUID, equals(currentUserId));
    expect(result.UserEmail, equals('test@gmail.com'));
    expect(result.UserName, equals('Test User'));
  });

  test('fetchCurrentUser: returns null when user is null', () async {
    when(mockAuth.currentUser).thenReturn(null);

    final result = await UserData.fetchCurrentUser(
      auth: mockAuth,
      firestore: mockFirestore,
    );

    expect(result, isNull);
  });

  test('fetchCurrentUser: returns null when document does not exist', () async {
    when(mockCurrentUserSnapshot.exists).thenReturn(false);

    final result = await UserData.fetchCurrentUser(
      auth: mockAuth,
      firestore: mockFirestore,
    );

    expect(result, isNull);
  });
}