import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'conversation.freezed.dart';
part 'conversation.g.dart';

/// Represents a chat conversation
@freezed
sealed class Conversation with _$Conversation {
  const factory Conversation({
    required String id,
    required String userId,
    required String title,
    required DateTime createdAt,
    required DateTime updatedAt,
    String? lastMessageText,
    int? messageCount,
  }) = _Conversation;

  factory Conversation.fromJson(Map<String, dynamic> json) =>
      _$ConversationFromJson(json);

  /// Factory constructor for creating Conversation from Firestore
  factory Conversation.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data()!;
    return Conversation(
      id: snapshot.id,
      userId: data['userId'] as String,
      title: data['title'] as String,
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      updatedAt: (data['updatedAt'] as Timestamp).toDate(),
      lastMessageText: data['lastMessageText'] as String?,
      messageCount: data['messageCount'] as int?,
    );
  }

  /// Convert Conversation to Firestore-compatible Map
  static Map<String, dynamic> toFirestore(Conversation conversation) {
    return {
      'userId': conversation.userId,
      'title': conversation.title,
      'createdAt': Timestamp.fromDate(conversation.createdAt),
      'updatedAt': Timestamp.fromDate(conversation.updatedAt),
      'lastMessageText': conversation.lastMessageText,
      'messageCount': conversation.messageCount,
    };
  }
}
