import 'package:OurSpace/services/auth/user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:OurSpace/services/chat/chat_services.dart';
import '../../test/mocks.mocks.dart';

void main() {
  late MockFirebaseFirestore mockFirestore;
  late MockFirebaseAuth mockAuth;
  late MockCollectionReference<Map<String, dynamic>> mockChatRoomsCollection;
  late MockDocumentReference<Map<String, dynamic>> mockChatRoomDoc;
  late MockCollectionReference<Map<String, dynamic>> mockMessagesCollection;
  late MockCollectionReference<Map<String, dynamic>> mockUsersCollection;
  late MockDocumentReference<Map<String, dynamic>> mockUserDoc;
  late MockDocumentSnapshot<Map<String, dynamic>> mockUserDocSnapshot;
  late ChatService chatService;
  late MockUser mockUser;

  setUp(() {
    mockFirestore = MockFirebaseFirestore();
    mockAuth = MockFirebaseAuth();
    mockUser = MockUser();
    mockChatRoomsCollection = MockCollectionReference();
    mockChatRoomDoc = MockDocumentReference();
    mockUserDoc = MockDocumentReference();
    mockMessagesCollection = MockCollectionReference();
    mockUsersCollection = MockCollectionReference();
    mockUserDocSnapshot = MockDocumentSnapshot();

    when(mockFirestore.collection("chat_rooms")).thenReturn(mockChatRoomsCollection);
    when(mockChatRoomsCollection.doc(any)).thenReturn(mockChatRoomDoc);
    when(mockChatRoomDoc.collection("messages")).thenReturn(mockMessagesCollection);
    when(mockAuth.currentUser).thenReturn(mockUser);

    chatService = ChatService(
      firestore: mockFirestore,
      auth: mockAuth,
    );
  });

  test('sendMessage writes message to Firestore', () async {
    when(mockUser.uid).thenReturn("user1");
    when(mockUser.email).thenReturn("user1@example.com");
    when(mockFirestore.collection('Users')).thenReturn(mockUsersCollection);
    when(mockUsersCollection.doc(any)).thenReturn(mockUserDoc);
    when(mockUserDoc.get()).thenAnswer((_) async => mockUserDocSnapshot);
    when(mockUserDocSnapshot.exists).thenReturn(true);
    when(mockUserDocSnapshot.data()).thenReturn({
      'UserName': 'TestUser',
    });
    when(mockMessagesCollection.add(any)).thenAnswer((_) async => MockDocumentReference());

    chatService = ChatService(
      firestore: mockFirestore,
      auth: mockAuth,
    );

    // just bc it's required ... our code is untestable omg
    List<String> fakeList = ['placeholder_word'];;
    String fakeString = "placeholder_word";

    // all of this to satisfy a parameter...
    await chatService.sendMessage("user2", "Hay!", fetchUser: () async {
      return UserData(
          UserName: "MockUser",
          UserUID: fakeString,
          UserEmail: fakeString,
          UserMajor: fakeString,
          UserCollege: fakeString,
          UserGradYear: fakeString,
          UserBiography: fakeString,
          UserProfilePicture: fakeString,
          inquiredUsers: fakeList,
          matchedUsers: fakeList,
      );
    });

    verify(mockMessagesCollection.add(argThat(
      allOf(
        containsPair("senderID", "user1"),
        containsPair("receiverID", "user2"),
        containsPair("message", "Hay!"),
      ),
    ))).called(1);
  });

  test('getMessages returns messages', () {
    final mockQuery = MockQuery<Map<String, dynamic>>();
    final mockSnapshot = MockQuerySnapshot<Map<String, dynamic>>();

    when(mockFirestore.collection("chat_rooms")).thenReturn(mockChatRoomsCollection);
    when(mockChatRoomsCollection.doc(any)).thenReturn(mockChatRoomDoc);
    when(mockChatRoomDoc.collection("messages")).thenReturn(mockMessagesCollection);
    when(mockMessagesCollection.orderBy("timestamp", descending: false)).thenReturn(mockQuery);

    when(mockQuery.snapshots()).thenAnswer((_) => Stream.value(mockSnapshot));

    final stream = chatService.getMessages("user1", "user2");

    expect(stream, emits(mockSnapshot));
  });

  test('getUsersStream finds the correct document', () async {
    final MockQuerySnapshot<Map<String, dynamic>> mockSnapshot;
    mockSnapshot = MockQuerySnapshot();

    final MockQueryDocumentSnapshot<Map<String, dynamic>>  mockDoc;
    mockDoc = MockQueryDocumentSnapshot();

    when(mockFirestore.collection("ChatClient")).thenReturn(mockChatRoomsCollection);
    when(mockChatRoomsCollection.snapshots()).thenAnswer((_) => Stream.value(mockSnapshot));
    when(mockSnapshot.docs).thenReturn([mockDoc]);
    when(mockDoc.data()).thenReturn({"email": "user@gmail.com"});

    final stream = chatService.getUsersStream();
    final result = await stream.first;
    expect(result, isA<List<Map<String, dynamic>>>());
    expect(result.first["email"], equals("user@gmail.com"));
  });
}