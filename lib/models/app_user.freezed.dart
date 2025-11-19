// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AppUser {

 String get uid; String get email; String? get displayName; String? get photoUrl; double? get annualIncome; String? get incomeFrequency;// 'annual', 'monthly', 'hourly'
 List<String> get financialGoals; Map<String, dynamic> get context;// Extracted user context
 bool get notificationsEnabled; DateTime? get createdAt; DateTime? get lastLoginAt;
/// Create a copy of AppUser
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppUserCopyWith<AppUser> get copyWith => _$AppUserCopyWithImpl<AppUser>(this as AppUser, _$identity);

  /// Serializes this AppUser to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppUser&&(identical(other.uid, uid) || other.uid == uid)&&(identical(other.email, email) || other.email == email)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.annualIncome, annualIncome) || other.annualIncome == annualIncome)&&(identical(other.incomeFrequency, incomeFrequency) || other.incomeFrequency == incomeFrequency)&&const DeepCollectionEquality().equals(other.financialGoals, financialGoals)&&const DeepCollectionEquality().equals(other.context, context)&&(identical(other.notificationsEnabled, notificationsEnabled) || other.notificationsEnabled == notificationsEnabled)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.lastLoginAt, lastLoginAt) || other.lastLoginAt == lastLoginAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,uid,email,displayName,photoUrl,annualIncome,incomeFrequency,const DeepCollectionEquality().hash(financialGoals),const DeepCollectionEquality().hash(context),notificationsEnabled,createdAt,lastLoginAt);

@override
String toString() {
  return 'AppUser(uid: $uid, email: $email, displayName: $displayName, photoUrl: $photoUrl, annualIncome: $annualIncome, incomeFrequency: $incomeFrequency, financialGoals: $financialGoals, context: $context, notificationsEnabled: $notificationsEnabled, createdAt: $createdAt, lastLoginAt: $lastLoginAt)';
}


}

/// @nodoc
abstract mixin class $AppUserCopyWith<$Res>  {
  factory $AppUserCopyWith(AppUser value, $Res Function(AppUser) _then) = _$AppUserCopyWithImpl;
@useResult
$Res call({
 String uid, String email, String? displayName, String? photoUrl, double? annualIncome, String? incomeFrequency, List<String> financialGoals, Map<String, dynamic> context, bool notificationsEnabled, DateTime? createdAt, DateTime? lastLoginAt
});




}
/// @nodoc
class _$AppUserCopyWithImpl<$Res>
    implements $AppUserCopyWith<$Res> {
  _$AppUserCopyWithImpl(this._self, this._then);

  final AppUser _self;
  final $Res Function(AppUser) _then;

/// Create a copy of AppUser
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? uid = null,Object? email = null,Object? displayName = freezed,Object? photoUrl = freezed,Object? annualIncome = freezed,Object? incomeFrequency = freezed,Object? financialGoals = null,Object? context = null,Object? notificationsEnabled = null,Object? createdAt = freezed,Object? lastLoginAt = freezed,}) {
  return _then(_self.copyWith(
uid: null == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,displayName: freezed == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String?,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,annualIncome: freezed == annualIncome ? _self.annualIncome : annualIncome // ignore: cast_nullable_to_non_nullable
as double?,incomeFrequency: freezed == incomeFrequency ? _self.incomeFrequency : incomeFrequency // ignore: cast_nullable_to_non_nullable
as String?,financialGoals: null == financialGoals ? _self.financialGoals : financialGoals // ignore: cast_nullable_to_non_nullable
as List<String>,context: null == context ? _self.context : context // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,notificationsEnabled: null == notificationsEnabled ? _self.notificationsEnabled : notificationsEnabled // ignore: cast_nullable_to_non_nullable
as bool,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,lastLoginAt: freezed == lastLoginAt ? _self.lastLoginAt : lastLoginAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [AppUser].
extension AppUserPatterns on AppUser {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AppUser value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AppUser() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AppUser value)  $default,){
final _that = this;
switch (_that) {
case _AppUser():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AppUser value)?  $default,){
final _that = this;
switch (_that) {
case _AppUser() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String uid,  String email,  String? displayName,  String? photoUrl,  double? annualIncome,  String? incomeFrequency,  List<String> financialGoals,  Map<String, dynamic> context,  bool notificationsEnabled,  DateTime? createdAt,  DateTime? lastLoginAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AppUser() when $default != null:
return $default(_that.uid,_that.email,_that.displayName,_that.photoUrl,_that.annualIncome,_that.incomeFrequency,_that.financialGoals,_that.context,_that.notificationsEnabled,_that.createdAt,_that.lastLoginAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String uid,  String email,  String? displayName,  String? photoUrl,  double? annualIncome,  String? incomeFrequency,  List<String> financialGoals,  Map<String, dynamic> context,  bool notificationsEnabled,  DateTime? createdAt,  DateTime? lastLoginAt)  $default,) {final _that = this;
switch (_that) {
case _AppUser():
return $default(_that.uid,_that.email,_that.displayName,_that.photoUrl,_that.annualIncome,_that.incomeFrequency,_that.financialGoals,_that.context,_that.notificationsEnabled,_that.createdAt,_that.lastLoginAt);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String uid,  String email,  String? displayName,  String? photoUrl,  double? annualIncome,  String? incomeFrequency,  List<String> financialGoals,  Map<String, dynamic> context,  bool notificationsEnabled,  DateTime? createdAt,  DateTime? lastLoginAt)?  $default,) {final _that = this;
switch (_that) {
case _AppUser() when $default != null:
return $default(_that.uid,_that.email,_that.displayName,_that.photoUrl,_that.annualIncome,_that.incomeFrequency,_that.financialGoals,_that.context,_that.notificationsEnabled,_that.createdAt,_that.lastLoginAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AppUser implements AppUser {
  const _AppUser({required this.uid, required this.email, this.displayName, this.photoUrl, this.annualIncome, this.incomeFrequency, final  List<String> financialGoals = const [], final  Map<String, dynamic> context = const {}, this.notificationsEnabled = true, this.createdAt, this.lastLoginAt}): _financialGoals = financialGoals,_context = context;
  factory _AppUser.fromJson(Map<String, dynamic> json) => _$AppUserFromJson(json);

@override final  String uid;
@override final  String email;
@override final  String? displayName;
@override final  String? photoUrl;
@override final  double? annualIncome;
@override final  String? incomeFrequency;
// 'annual', 'monthly', 'hourly'
 final  List<String> _financialGoals;
// 'annual', 'monthly', 'hourly'
@override@JsonKey() List<String> get financialGoals {
  if (_financialGoals is EqualUnmodifiableListView) return _financialGoals;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_financialGoals);
}

 final  Map<String, dynamic> _context;
@override@JsonKey() Map<String, dynamic> get context {
  if (_context is EqualUnmodifiableMapView) return _context;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_context);
}

// Extracted user context
@override@JsonKey() final  bool notificationsEnabled;
@override final  DateTime? createdAt;
@override final  DateTime? lastLoginAt;

/// Create a copy of AppUser
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppUserCopyWith<_AppUser> get copyWith => __$AppUserCopyWithImpl<_AppUser>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AppUserToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppUser&&(identical(other.uid, uid) || other.uid == uid)&&(identical(other.email, email) || other.email == email)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.annualIncome, annualIncome) || other.annualIncome == annualIncome)&&(identical(other.incomeFrequency, incomeFrequency) || other.incomeFrequency == incomeFrequency)&&const DeepCollectionEquality().equals(other._financialGoals, _financialGoals)&&const DeepCollectionEquality().equals(other._context, _context)&&(identical(other.notificationsEnabled, notificationsEnabled) || other.notificationsEnabled == notificationsEnabled)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.lastLoginAt, lastLoginAt) || other.lastLoginAt == lastLoginAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,uid,email,displayName,photoUrl,annualIncome,incomeFrequency,const DeepCollectionEquality().hash(_financialGoals),const DeepCollectionEquality().hash(_context),notificationsEnabled,createdAt,lastLoginAt);

@override
String toString() {
  return 'AppUser(uid: $uid, email: $email, displayName: $displayName, photoUrl: $photoUrl, annualIncome: $annualIncome, incomeFrequency: $incomeFrequency, financialGoals: $financialGoals, context: $context, notificationsEnabled: $notificationsEnabled, createdAt: $createdAt, lastLoginAt: $lastLoginAt)';
}


}

/// @nodoc
abstract mixin class _$AppUserCopyWith<$Res> implements $AppUserCopyWith<$Res> {
  factory _$AppUserCopyWith(_AppUser value, $Res Function(_AppUser) _then) = __$AppUserCopyWithImpl;
@override @useResult
$Res call({
 String uid, String email, String? displayName, String? photoUrl, double? annualIncome, String? incomeFrequency, List<String> financialGoals, Map<String, dynamic> context, bool notificationsEnabled, DateTime? createdAt, DateTime? lastLoginAt
});




}
/// @nodoc
class __$AppUserCopyWithImpl<$Res>
    implements _$AppUserCopyWith<$Res> {
  __$AppUserCopyWithImpl(this._self, this._then);

  final _AppUser _self;
  final $Res Function(_AppUser) _then;

/// Create a copy of AppUser
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? uid = null,Object? email = null,Object? displayName = freezed,Object? photoUrl = freezed,Object? annualIncome = freezed,Object? incomeFrequency = freezed,Object? financialGoals = null,Object? context = null,Object? notificationsEnabled = null,Object? createdAt = freezed,Object? lastLoginAt = freezed,}) {
  return _then(_AppUser(
uid: null == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,displayName: freezed == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String?,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,annualIncome: freezed == annualIncome ? _self.annualIncome : annualIncome // ignore: cast_nullable_to_non_nullable
as double?,incomeFrequency: freezed == incomeFrequency ? _self.incomeFrequency : incomeFrequency // ignore: cast_nullable_to_non_nullable
as String?,financialGoals: null == financialGoals ? _self._financialGoals : financialGoals // ignore: cast_nullable_to_non_nullable
as List<String>,context: null == context ? _self._context : context // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,notificationsEnabled: null == notificationsEnabled ? _self.notificationsEnabled : notificationsEnabled // ignore: cast_nullable_to_non_nullable
as bool,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,lastLoginAt: freezed == lastLoginAt ? _self.lastLoginAt : lastLoginAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
