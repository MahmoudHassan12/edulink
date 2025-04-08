import 'package:flutter/material.dart';

class SendMessageInput extends StatelessWidget {
  const SendMessageInput({
    required this.controller,
    required this.onSendMessage,
    super.key,
  });

  final TextEditingController controller;
  final VoidCallback onSendMessage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: TextField(
                controller: controller,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black87, // Typing text color
                ),
                decoration: const InputDecoration(
                  hintText: 'Type a message...',
                  hintStyle: TextStyle(
                    color: Colors.grey, // Hint text color
                    fontSize: 15,
                  ),
                  border: InputBorder.none, // Remove the default border
                  contentPadding: EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          FloatingActionButton(
            backgroundColor: Colors.blueAccent, // Send button color
            onPressed: onSendMessage, // Send icon
            elevation: 6,
            child: const Icon(Icons.send, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
