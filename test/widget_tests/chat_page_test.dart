import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:OurSpace/pages/chat_page.dart';
import '../mocks.mocks.dart';

void main() {
  late MockChatService mockChatService;
  late Mockauthentication mockAuth;
  late MockQuerySnapshot<Map<String, dynamic>> mockQuerySnapshot;
  late MockQueryDocumentSnapshot<
      Map<String, dynamic>> mockQueryDocumentSnapshot;
  late MockDocumentSnapshot mockDocSnapshot;
  late MockUser mockUser;

  setUp(() {
    mockChatService = MockChatService();
    mockAuth = Mockauthentication();
    mockDocSnapshot = MockDocumentSnapshot();
    mockUser = MockUser();
    mockQuerySnapshot = MockQuerySnapshot<Map<String, dynamic>>();
    mockQueryDocumentSnapshot =
        MockQueryDocumentSnapshot<Map<String, dynamic>>();
    when(mockQuerySnapshot.docs).thenReturn([mockQueryDocumentSnapshot]);
    when(mockQueryDocumentSnapshot.data()).thenReturn({
      'message': 'Heyyy!',
      'senderID': 'sender123',
    });
  });

  Widget createChatPage() {
    return MaterialApp(
      home: ChatPage(
        receiverEmail: 'otherPerson@gmail.com',
        receiverID: 'receiver1126',
        receiverName: 'Name',
        chatService: mockChatService,
        auth: mockAuth,
      ),
    );
  }

  testWidgets('Create ChatPage and display message', (
      WidgetTester tester) async {
    final fakeDocData = {
      'message': 'Heyyy!',
      'senderID': 'sender0401',
    };

    when(mockUser.uid).thenReturn('sender0401');
    when(mockAuth.getCurrentUser()).thenReturn(mockUser);
    when(mockChatService.getMessages(any, any))
        .thenAnswer((_) => Stream.value(mockQuerySnapshot));
    when(mockQuerySnapshot.docs).thenReturn([mockQueryDocumentSnapshot]);
    when(mockDocSnapshot.data()).thenReturn(fakeDocData);

    await tester.pumpWidget(
      MaterialApp(
        home: ChatPage(
          receiverEmail: 'otherPerson@gmail.com',
          receiverID: 'receiver1126',
          receiverName: 'Name',
          chatService: mockChatService,
          auth: mockAuth,
        ),
      ),
    );

    await tester.pump();

    expect(find.text('Heyyy!'), findsOneWidget);
    expect(find.text('Name'), findsOneWidget); // AppBar title
  });
}