// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Message _$MessageFromJson(Map<String, dynamic> json) => _Message(
      id: json['id'] as String,
      conversationId: json['conversationId'] as String,
      text: json['text'] as String,
      sender: $enumDecode(_$MessageSenderEnumMap, json['sender']),
      timestamp: DateTime.parse(json['timestamp'] as String),
      userId: json['userId'] as String?,
      isStreaming: json['isStreaming'] as bool? ?? false,
    );

Map<String, dynamic> _$MessageToJson(_Message instance) => <String, dynamic>{
      'id': instance.id,
      'conversationId': instance.conversationId,
      'text': instance.text,
      'sender': _$MessageSenderEnumMap[instance.sender]!,
      'timestamp': instance.timestamp.toIso8601String(),
      'userId': instance.userId,
      'isStreaming': instance.isStreaming,
    };

const _$MessageSenderEnumMap = {
  MessageSender.user: 'user',
  MessageSender.ai: 'ai',
  MessageSender.system: 'system',
};
