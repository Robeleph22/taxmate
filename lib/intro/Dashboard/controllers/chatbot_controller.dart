import 'package:get/get.dart';

import '../../../core/controllers/base_controller.dart';

class ChatMessage {
  final String id;
  final String text;
  final bool fromUser;

  const ChatMessage({
    required this.id,
    required this.text,
    required this.fromUser,
  });
}

class ChatbotController extends BaseController<List<ChatMessage>> {
  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  @override
  Future<void> loadData() async {
    // For now we just show an empty conversation.
    setSuccess(const <ChatMessage>[]);
  }

  void sendMessage(String text) {
    final current = List<ChatMessage>.from(state.value.data ?? const <ChatMessage>[]);

    if (text.trim().isEmpty) return;

    current.add(ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      text: text.trim(),
      fromUser: true,
    ));

    // In a real app you would call an API and add bot responses.
    setSuccess(current);
  }
}

