import 'package:OurSpace/pages/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:OurSpace/services/chat/chat_services.dart';
import 'package:OurSpace/components/user_tile.dart';

class MessagePage extends StatelessWidget {
  MessagePage({super.key});

  final ChatService _chatService = ChatService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Messages"),
      ),
      body: _buildUserList(),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder(
      stream: _chatService.getUsersStream(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text("Error");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading...");
        }

        return ListView(
          children: snapshot.data!
              .map<Widget>((userData) => _buildUserListItem(userData, context))
              .toList(),
        );
      },
    );
  }

  Widget _buildUserListItem(
  Map<String, dynamic> userData, BuildContext context) {
    return UserTile(
      text: userData["email"],
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => ChatPage(
          receiverEmail: userData["email"],
        ),
        ),
        );
      },
    );
  }
}