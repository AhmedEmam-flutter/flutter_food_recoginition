import 'package:flutter/material.dart';
import 'package:flutter_food_recoginition/core/askai/view_model.dart';
import '../../../core/utiles/color_manager.dart';

class ChatInputWidget extends StatefulWidget {
  final AskAiViewModel vm;
  const ChatInputWidget({required this.vm, super.key});

  @override
  State<ChatInputWidget> createState() => _ChatInputWidgetState();
}

class _ChatInputWidgetState extends State<ChatInputWidget> {
  final TextEditingController controller = TextEditingController();
  bool canSend = false;

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      setState(() {
        canSend = controller.text.trim().isNotEmpty; 
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _sendMessage() {
    if (controller.text.trim().isEmpty) return;
    widget.vm.sendPrompt(controller.text.trim());
    controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              maxLines: null,
              style: const TextStyle(color: Colors.black), 
              decoration: InputDecoration(
                hintText: "Ask about food...",
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
              textInputAction: TextInputAction.newline, 
            ),
          ),
          const SizedBox(width: 10),
          FloatingActionButton(
            onPressed: canSend ? _sendMessage : null, 
            backgroundColor: canSend
                ? ColorManager.primaryColor
                : Colors.grey, 
            child: const Icon(Icons.auto_awesome, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
