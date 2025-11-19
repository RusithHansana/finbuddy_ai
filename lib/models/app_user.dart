import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'app_user.freezed.dart';
part 'app_user.g.dart';

/// Represents user context and preferences stored in Firestore
@freezed
sealed class AppUser with _$AppUser {
  const factory AppUser({
    required String uid,
    required String email,
    String? displayName,
    String? photoUrl,
    double? annualIncome,
    String? incomeFrequency, // 'annual', 'monthly', 'hourly'
    @Default([]) List<String> financialGoals,
    @Default({}) Map<String, dynamic> context, // Extracted user context
    @Default(true) bool notificationsEnabled,
    DateTime? createdAt,
    DateTime? lastLoginAt,
  }) = _AppUser;

  factory AppUser.fromJson(Map<String, dynamic> json) =>
      _$AppUserFromJson(json);

  /// Factory constructor for creating AppUser from Firestore
  factory AppUser.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data()!;
    return AppUser(
      uid: snapshot.id,
      email: data['email'] as String,
      displayName: data['displayName'] as String?,
      photoUrl: data['photoUrl'] as String?,
      annualIncome: (data['annualIncome'] as num?)?.toDouble(),
      incomeFrequency: data['incomeFrequency'] as String?,
      financialGoals:
          (data['financialGoals'] as List?)?.map((e) => e as String).toList() ??
          [],
      context: (data['context'] as Map<String, dynamic>?) ?? {},
      notificationsEnabled: data['notificationsEnabled'] as bool? ?? true,
      createdAt: (data['createdAt'] as Timestamp?)?.toDate(),
      lastLoginAt: (data['lastLoginAt'] as Timestamp?)?.toDate(),
    );
  }

  /// Convert AppUser to Firestore-compatible Map
  static Map<String, dynamic> toFirestore(AppUser user) {
    return {
      'email': user.email,
      'displayName': user.displayName,
      'photoUrl': user.photoUrl,
      'annualIncome': user.annualIncome,
      'incomeFrequency': user.incomeFrequency,
      'financialGoals': user.financialGoals,
      'context': user.context,
      'notificationsEnabled': user.notificationsEnabled,
      'createdAt':
          user.createdAt != null
              ? Timestamp.fromDate(user.createdAt!)
              : FieldValue.serverTimestamp(),
      'lastLoginAt':
          user.lastLoginAt != null
              ? Timestamp.fromDate(user.lastLoginAt!)
              : FieldValue.serverTimestamp(),
    };
  }
}
