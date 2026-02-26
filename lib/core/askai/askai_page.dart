import 'package:flutter/material.dart';
import 'package:flutter_food_recoginition/core/askai/view_model.dart';
import 'package:provider/provider.dart';
import 'widgets/usage_guide.dart';
import 'widgets/chat_bubble.dart';
import 'widgets/typing_indicator.dart';
import 'widgets/chat_input.dart';
import '../../../core/utiles/color_manager.dart';

class AskAiPage extends StatelessWidget {
  const AskAiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AskAiViewModel()..init(),
      child: const _AskAiView(),
    );
  }
}

class _AskAiView extends StatelessWidget {
  const _AskAiView();

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AskAiViewModel>();

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text("✨ Magic AI Assistant"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: ColorManager.textColor,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [ColorManager.primaryColor.withOpacity(0.05), Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const UsageGuideWidget(), 
              Expanded(
                child: ListView.builder(
                  reverse: false,
                  padding: const EdgeInsets.all(16),
                  itemCount: vm.messages.length,
                  itemBuilder: (context, index) {
                    return AnimatedChatBubble(message: vm.messages[index]); 
                  },
                ),
              ),
              if (vm.isTyping) const TypingIndicatorWidget(), 
              ChatInputWidget(vm: vm), 
            ],
          ),
        ),
      ),
    );
  }
}
