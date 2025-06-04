import 'package:OurSpace/services/auth/authentication.dart';
import 'package:flutter_test/flutter_test.dart';
import '../mocks.mocks.dart';
import 'package:mockito/mockito.dart';

void main() {
  late MockFirebaseAuth mockAuth;
  late MockFirebaseFirestore mockFirestore;
  late MockUser mockUser;
  late MockUserCredential mockUserCredential;
  late MockCollectionReference<Map<String, dynamic>> mockCollection;
  late MockDocumentReference<Map<String, dynamic>> mockDoc;
  late authentication authService;

  setUp(() {
    mockAuth = MockFirebaseAuth();
    mockFirestore = MockFirebaseFirestore();
    mockUser = MockUser();
    mockUserCredential = MockUserCredential();
    mockCollection = MockCollectionReference();
    mockDoc = MockDocumentReference();

    authService = authentication.test(mockAuth, mockFirestore);
  });

  test('getCurrentUser returns current user properly', () {
    when(mockAuth.currentUser).thenReturn(mockUser);
    final user = authService.getCurrentUser();
    expect(user, mockUser);
  });

  test('loginUserWithEmailAndPassword logs in; ChatClient/User data stored in Firestore', () async {
    when(mockAuth.signInWithEmailAndPassword(
        email: anyNamed('email'), password: anyNamed('password')))
        .thenAnswer((_) async => mockUserCredential);

    when(mockUserCredential.user).thenReturn(mockUser);
    when(mockUser.uid).thenReturn("123");

    when(mockFirestore.collection("ChatClient")).thenReturn(mockCollection);
    when(mockCollection.doc("123")).thenReturn(mockDoc);
    when(mockDoc.set(any)).thenAnswer((_) async => null);

    final result = await authService.loginUserWithEmailAndPassword(
        "test@gmail.com", "password");

    expect(result, mockUserCredential);
  });

  test('signUpUserWithEmailAndPassword signs up;  ChatClient/User data stored in Firestore', () async {
    when(mockAuth.createUserWithEmailAndPassword(
        email: anyNamed('email'), password: anyNamed('password')))
        .thenAnswer((_) async => mockUserCredential);

    when(mockUserCredential.user).thenReturn(mockUser);
    when(mockUser.uid).thenReturn("1234");

    when(mockFirestore.collection("ChatClient")).thenReturn(mockCollection);
    when(mockFirestore.collection("Users")).thenReturn(mockCollection);
    when(mockCollection.doc("1234")).thenReturn(mockDoc);
    when(mockDoc.set(any)).thenAnswer((_) async => null);

    final result = await authService.signUpUserWithEmailAndPassword(
        "test2@gmail.com", "password2");

    expect(result, mockUserCredential);
    verify(mockFirestore.collection("ChatClient")).called(1);
    verify(mockFirestore.collection("Users")).called(1);
  });

  test('logoutOfAccount calls signOut', () async {
    when(mockAuth.signOut()).thenAnswer((_) async => null);

    await authService.logoutOfAccount();
    verify(mockAuth.signOut()).called(1);
  });
}