import 'package:OurSpace/pages/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:OurSpace/services/chat/chat_services.dart';
import 'package:OurSpace/components/user_tile.dart';
import '../services/auth/authentication.dart';
import '../services/auth/user.dart';

class MessagePage extends StatelessWidget {
  MessagePage({super.key});

  final ChatService _chatService = ChatService();
  final authentication _authentication = authentication();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Messages"),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        elevation: 0,
      ),
      body: _buildUserList(),
    );
  }

  Widget _buildUserList() {
    return FutureBuilder<UserData?>(
      future: UserData.fetchCurrentUser(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final matchedUserIds = snapshot.data!.matchedUsers ?? [];

        return StreamBuilder(
          stream: _chatService.getUsersStream(),
          builder: (context, snapshot) {
            if (snapshot.hasError) return const Text("Error");
            if (snapshot.connectionState == ConnectionState.waiting) return const Text("Loading...");

            final matchedUsers = snapshot.data!
                .where((user) =>
            user["uid"] != _authentication.getCurrentUser()!.uid &&
                matchedUserIds.contains(user["uid"]))
                .toList();

            return ListView(
              children: matchedUsers.map<Widget>((userData) =>
                  _buildUserListItem(userData, context)).toList(),
            );
          },
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
        text: userData["UserName"],
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => ChatPage(
            receiverEmail: userData["email"],
            receiverID: userData["uid"],
            receiverName: userData["UserName"],
            chatService: _chatService,
            auth: _authentication,
            ),
          ));
        },
      );
    } else {
      return Container();
    }
  }
}