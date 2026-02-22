import 'package:flutter/material.dart';

class ChatInputBar extends StatelessWidget {
  final TextEditingController c;
  final VoidCallback onSend;

  const ChatInputBar({super.key, required this.c, required this.onSend});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: c,
            decoration: const InputDecoration(
              hintText: "Ask about a food recipe...",
            ),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.send),
          onPressed: onSend,
        )
      ],
    );
  }
}
