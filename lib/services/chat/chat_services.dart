import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../models/message.dart';
import '../auth/user.dart';

class ChatService {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  ChatService({
    FirebaseFirestore? firestore,
    FirebaseAuth? auth,
}): firestore = firestore ?? FirebaseFirestore.instance,
  auth = auth ?? FirebaseAuth.instance;

  Stream<List<Map<String,dynamic>>> getUsersStream() {
    return firestore.collection("ChatClient").snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final user = doc.data();

        return user;
      }).toList();
    });
  }

  // send message
  Future<void> sendMessage(String receiverID, message, {
    Future<UserData?> Function()? fetchUser,
  }) async {
    // get user info
    final currentUser = await (fetchUser?.call() ?? UserData.fetchCurrentUser());
    final String userName = currentUser!.UserName!;

    final String currentUserID = auth.currentUser!.uid;
    final String currentUserEmail = auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    // write a message
    Message newMessage = Message(
        senderID: currentUserID,
        senderName: userName,
        senderEmail: currentUserEmail,
        receiverID: receiverID,
        message: message,
        timestamp: timestamp
    );

    // pair two users
    List<String> ids = [currentUserID, receiverID];
    ids.sort();
    String chatRoomID = ids.join('_');

    // send new message to firebase
    await firestore
        .collection("chat_rooms")
        .doc(chatRoomID)
        .collection("messages")
        .add(newMessage.toMap());
  }

  // get message
  Stream<QuerySnapshot> getMessages(String userID, secondUserID) {
    List<String> ids = [userID, secondUserID];
    ids.sort();
    String chatRoomID = ids.join('_');

    return firestore
        .collection("chat_rooms")
        .doc(chatRoomID)
        .collection("messages")
        .orderBy("timestamp", descending: false)
        .snapshots();
  }
}