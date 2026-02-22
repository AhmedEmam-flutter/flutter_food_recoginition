import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/network/dio_client.dart';
import '../data/ask_ai_repository.dart';
import '../viewmodel/ask_ai_view_model.dart';
import 'widgets/chat_bubble.dart';
import 'widgets/chat_input_bar.dart';
import 'widgets/prompt_helper.dart';

class AskAiPage extends StatelessWidget {
  const AskAiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AskAiViewModel(
        AskAiRepository(
          dio: buildDio(),
          apiKey: "PUT_KEY_HERE",
        ),
      ),
      child: const _Body(),
    );
  }
}

class _Body extends StatefulWidget {
  const _Body();

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  final c = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AskAiViewModel>();

    return Scaffold(
      appBar: AppBar(title: const Text("Ask AI")),
      body: Column(
        children: [
          PromptHelper(),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(12),
              children: vm.messages.map((e) => ChatBubble(e)).toList(),
            ),
          ),
          ChatInputBar(
            c: c,
            onSend: () {
              context.read<AskAiViewModel>().send(c.text);
              c.clear();
            },
          ),
          if (vm.isLoading) const LinearProgressIndicator(),
        ],
      ),
    );
  }
}
