import 'package:OurSpace/components/chat_bubble.dart';
import 'package:OurSpace/services/auth/authentication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:OurSpace/services/chat/chat_services.dart';
import 'package:OurSpace/components/custom_textfield.dart';

class ChatPage extends StatelessWidget {
  final String receiverEmail;
  final String receiverID;
  final String receiverName;
  final ChatService chatService;
  final authentication auth;

  ChatPage({
    super.key,
    required this.receiverEmail,
    required this.receiverID,
    required this.receiverName,
    required this.chatService,
    required this.auth,
  });

  final TextEditingController _messageController = TextEditingController();

  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await chatService.sendMessage(receiverID, _messageController.text);
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(receiverName),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(child: _buildMessageList()),
          _buildUserInput(),
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    final senderID = auth.getCurrentUser()!.uid;
    return StreamBuilder(
      stream: chatService.getMessages(receiverID, senderID),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text("Error");
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading...");
        }

        return ListView(
          children: snapshot.data!.docs
              .map((doc) => _buildMessageItem(doc))
              .toList(),
        );
      },
    );
  }

  Widget _buildMessageItem(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    final isCurrentUser = data['senderID'] == auth.getCurrentUser()!.uid;
    final alignment = isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

    return Container(
      alignment: alignment,
      child: ChatBubble(
        message: data['message'],
        isCurrentUser: isCurrentUser,
      ),
    );
  }

  Widget _buildUserInput() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50.0),
      child: Row(
        children: [
          Expanded(
            child: CustomTextField(
              controller: _messageController,
              hintText: "Type a message",
              obscureText: false,
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              color: Colors.indigo,
              shape: BoxShape.circle,
            ),
            margin: const EdgeInsets.only(right: 25),
            child: IconButton(
              onPressed: sendMessage,
              icon: const Icon(Icons.arrow_upward, color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}