import 'package:dio/dio.dart';
import '../model/chat_message.dart';

class AskAiRepository {
  final Dio dio;
  final String apiKey;

  AskAiRepository({required this.dio, required this.apiKey});

  Future<String> askFood(String userMessage) async {
    final res = await dio.post(
      "https://api.openai.com/v1/responses",
      options: Options(headers: {
        "Authorization": "Bearer $apiKey",
        "Content-Type": "application/json",
      }),
      data: {
        "model": "gpt-4o-mini",
        "input": [
          {
            "role": "system",
            "content": [
              {
                "type": "text",
                "text":
                    "You are a food-only assistant. Answer only about recipes, cooking, ingredients, and calories. Refuse non-food questions."
              }
            ]
          },
          {
            "role": "user",
            "content": [
              {"type": "text", "text": userMessage}
            ]
          }
        ]
      },
    );

    final out = res.data["output"][0]["content"][0]["text"];
    return out ?? "No reply";
  }
}
