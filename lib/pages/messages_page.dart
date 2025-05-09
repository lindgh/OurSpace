import 'package:OurSpace/pages/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:OurSpace/services/chat/chat_services.dart';
import 'package:OurSpace/components/user_tile.dart';
import '../services/auth/authentication.dart';

class MessagePage extends StatelessWidget {
  MessagePage({super.key});

  final ChatService _chatService = ChatService();
  final authentication _authentication = authentication();

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
    // display all users but the current user -- ADJUST THIS LATER.
    // SHOW ONLY RELEVANT USERS
    if (userData["email"] != _authentication.getCurrentUser()!.email) {
      return UserTile(
        text: userData["email"],
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => ChatPage(
            receiverEmail: userData["email"],
            receiverID: userData["uid"],
          ),
          ),
          );
        },
      );
    } else {
      return Container();
    }
  }
}