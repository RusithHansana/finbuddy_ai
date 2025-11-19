// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AppUser _$AppUserFromJson(Map<String, dynamic> json) => _AppUser(
  uid: json['uid'] as String,
  email: json['email'] as String,
  displayName: json['displayName'] as String?,
  photoUrl: json['photoUrl'] as String?,
  annualIncome: (json['annualIncome'] as num?)?.toDouble(),
  incomeFrequency: json['incomeFrequency'] as String?,
  financialGoals:
      (json['financialGoals'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  context: json['context'] as Map<String, dynamic>? ?? const {},
  notificationsEnabled: json['notificationsEnabled'] as bool? ?? true,
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  lastLoginAt: json['lastLoginAt'] == null
      ? null
      : DateTime.parse(json['lastLoginAt'] as String),
);

Map<String, dynamic> _$AppUserToJson(_AppUser instance) => <String, dynamic>{
  'uid': instance.uid,
  'email': instance.email,
  'displayName': instance.displayName,
  'photoUrl': instance.photoUrl,
  'annualIncome': instance.annualIncome,
  'incomeFrequency': instance.incomeFrequency,
  'financialGoals': instance.financialGoals,
  'context': instance.context,
  'notificationsEnabled': instance.notificationsEnabled,
  'createdAt': instance.createdAt?.toIso8601String(),
  'lastLoginAt': instance.lastLoginAt?.toIso8601String(),
};
