//used by create_profile
import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String text;
  const MyTextField({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column (
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: TextFormField(
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              labelText: text,
            ),
          ),
        ),
      ],
    );
  }
}
