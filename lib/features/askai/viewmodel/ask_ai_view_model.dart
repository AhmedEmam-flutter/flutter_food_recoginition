import 'package:flutter/material.dart';
import '../data/ask_ai_repository.dart';
import '../model/chat_message.dart';

class AskAiViewModel extends ChangeNotifier {
  final AskAiRepository repo;

  AskAiViewModel(this.repo);

  final messages = <ChatMessage>[];
  bool isLoading = false;

  bool _foodOnly(String t) {
    const k = ["cook","recipe","food","calorie","طبخ","وصفة","اكل"];
    return k.any((e) => t.toLowerCase().contains(e));
  }

  Future<void> send(String text) async {
    if (text.trim().isEmpty) return;

    if (!_foodOnly(text)) {
      messages.add(ChatMessage(
        role: ChatRole.assistant,
        text: "اسأل عن الأكل فقط 🍽️",
      ));
      notifyListeners();
      return;
    }

    messages.add(ChatMessage(role: ChatRole.user, text: text));
    isLoading = true;
    notifyListeners();

    final reply = await repo.askFood(text);

    messages.add(ChatMessage(role: ChatRole.assistant, text: reply));
    isLoading = false;
    notifyListeners();
  }
}
