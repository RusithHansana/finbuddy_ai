import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

/// Represents a FinBuddy user's profile data
@freezed
sealed class User with _$User {
  const factory User({
    required String uid,
    required String email,
    String? displayName,
    String? photoUrl,
    double? annualIncome,
    @Default([]) List financialGoals,
    DateTime? createdAt,
    DateTime? lastLoginAt,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
