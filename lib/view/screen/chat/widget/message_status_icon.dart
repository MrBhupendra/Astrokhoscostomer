import 'package:flutter/material.dart';

import '../model/chat_message_model.dart';

Widget buildMessageStatusIcon(ChatMessageModel message, String? currentUserUniId) {
  if (currentUserUniId == null) return const SizedBox.shrink();
  if (message.senderUniId != currentUserUniId) return const SizedBox.shrink();

  final status = (message.deliveryStatus ?? 'sent').toLowerCase();

  if (status == 'read') {
    return const Icon(Icons.done_all, size: 14, color: Colors.blue);
  }
  if (status == 'delivered') {
    return const Icon(Icons.done_all, size: 14, color: Colors.grey);
  }
  return const Icon(Icons.done, size: 14, color: Colors.grey);
}

