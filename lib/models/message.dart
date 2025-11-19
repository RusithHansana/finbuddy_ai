import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'message.freezed.dart';
part 'message.g.dart';

/// Represents the sender of a message
enum MessageSender { user, ai, system }

/// Represents a single chat message
@freezed
sealed class Message with _$Message {
  const factory Message({
    required String id,
    required String conversationId,
    required String text,
    required MessageSender sender,
    required DateTime timestamp,
    String? userId,
    @Default(false) bool isStreaming,
  }) = _Message;

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  /// Factory constructor for creating Message from Firestore DocumentSnapshot
  factory Message.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data()!;
    return Message(
      id: snapshot.id,
      conversationId: data['conversationId'] as String,
      text: data['text'] as String,
      sender: MessageSender.values.firstWhere(
        (e) => e.name == data['sender'],
        orElse: () => MessageSender.system,
      ),
      timestamp: (data['timestamp'] as Timestamp).toDate(),
      userId: data['userId'] as String?,
      isStreaming: false,
    );
  }

  /// Convert Message to Firestore-compatible Map
  static Map<String, dynamic> toFirestore(Message message) {
    return {
      'conversationId': message.conversationId,
      'text': message.text,
      'sender': message.sender.name,
      'timestamp': Timestamp.fromDate(message.timestamp),
      'userId': message.userId,
    };
  }
}
