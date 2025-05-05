import 'package:flutter/material.dart';

class MessagePage extends StatelessWidget {
  const MessagePage({super.key});

  @override
  Widget build(BuildContext context) {
    // THIS IS FOR THIS PAGE'S CONTENTS.
    return Container(
      color: Colors.red,
      child: const Center(
        child: Text(
          "Message",
        )
      )
    );
  }
}