import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_food_recoginition/core/askai/chat_message.dart';

class AskAiViewModel extends ChangeNotifier {
  final List<ChatMessage> messages = [];
  bool isTyping = false;

  // التعليمات البرمجية لحصر المحادثة في الغذاء والسعرات فقط
  final String _systemPrompt = """
    You are 'CalorieCalc Magic AI'. 
    1. Your ONLY purpose is to discuss food, nutrition, recipes, and calories.
    2. If the user asks about anything else (politics, tech, etc.), politely say: 
       "I'm sorry, I can only assist with food-related topics and calorie tracking."
    3. Provide estimated calories when asked about a meal.
    4. Keep your tone helpful, healthy, and use food emojis.
  """;

  late final GenerativeModel _model;
  late final ChatSession _chat;

  void init() {
    _model = GenerativeModel(
      model: 'gemini-3-flash-preview', 
      apiKey: 'AIzaSyA3lCfR0ZRCGk8CReD78jEkzpyMBaAF4Gk',
      systemInstruction: Content.system(_systemPrompt),
    );
    _chat = _model.startChat();
  }

  Future<void> sendPrompt(String text) async {
    if (text.trim().isEmpty) return;

    // إضافة رسالة المستخدم للواجهة فوراً
    messages.add(ChatMessage(text: text, role: MessageRole.user));
    isTyping = true;
    notifyListeners();

    try {
      final response = await _chat.sendMessage(Content.text(text));
      
      if (response.text != null) {
        messages.add(ChatMessage(text: response.text!, role: MessageRole.ai));
      } else {
        messages.add(ChatMessage(text: "I'm having trouble understanding that. Try asking about a recipe! 🥗", role: MessageRole.ai));
      }
    } catch (e) {
      debugPrint("AI Error Details: $e");
      
      String errorMessage = "Connection lost. Please check your internet! 🌐";
      
      if (e.toString().contains('429') || e.toString().contains('quota')) {
        errorMessage = "The Magic AI is resting for a moment ✨. Please wait 60 seconds and try again.";
      }

      messages.add(ChatMessage(
        text: errorMessage, 
        role: MessageRole.ai
      ));
    } finally {
      isTyping = false;
      notifyListeners();
    }
  }
  void clearChat() {
    messages.clear();
    _chat = _model.startChat();
    notifyListeners();
  }
}