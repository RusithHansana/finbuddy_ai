import 'package:finbuddy_ai/models/app_user.dart';
import 'package:finbuddy_ai/services/auth_service.dart';
import 'package:finbuddy_ai/services/firestore_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_provider.g.dart';

// ============== SERVICE PROVIDERS ==============

@riverpod
AuthService authService(Ref ref) {
  return AuthService();
}

@riverpod
FirestoreService firestoreService(Ref ref) {
  return FirestoreService();
}

// ============== AUTH STATE PROVIDER ==============

@riverpod
Stream authStateChanges(Ref ref) {
  final authService = ref.watch(authServiceProvider);
  return authService.authStateChanges;
}

// ============== CURRENT USER PROVIDER ==============

@riverpod
Stream currentUser(Ref ref) async* {
  final authService = ref.watch(authServiceProvider);
  final authStream = authService.authStateChanges;

  await for (final user in authStream) {
    if (user == null) {
      yield null;
    } else {
      final firestoreService = ref.watch(firestoreServiceProvider);
      yield* firestoreService.streamUserProfile(user.uid);
    }
  }
}

// ============== AUTH ACTIONS PROVIDER ==============

@riverpod
class AuthActions extends _$AuthActions {
  @override
  FutureOr build() {}

  /// Sign up with email and password
  Future signUpWithEmail({
    required String email,
    required String password,
    String? displayName,
  }) async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      final authService = ref.read(authServiceProvider);
      final firestoreService = ref.read(firestoreServiceProvider);

      // Create Firebase Auth account
      final userCredential = await authService.signUpWithEmail(
        email: email,
        password: password,
      );

      // Update display name if provided
      if (displayName != null) {
        await authService.updateDisplayName(displayName);
      }

      // Create user profile in Firestore
      final user = userCredential.user!;
      final appUser = AppUser(
        uid: user.uid,
        email: user.email!,
        displayName: displayName ?? user.displayName,
        photoUrl: user.photoURL,
        createdAt: DateTime.now(),
        lastLoginAt: DateTime.now(),
      );

      await firestoreService.saveUserProfile(appUser);
    });
  }

  /// Sign in with email and password
  Future signInWithEmail({
    required String email,
    required String password,
  }) async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      final authService = ref.read(authServiceProvider);
      await authService.signInWithEmail(email: email, password: password);
    });
  }

  /// Sign in with Google
  Future signInWithGoogle() async {
    final link = ref.keepAlive();
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      final authService = ref.read(authServiceProvider);
      final firestoreService = ref.read(firestoreServiceProvider);

      final userCredential = await authService.signInWithGoogle();
      final user = userCredential.user!;

      // Create or update user profile in Firestore
      final appUser = AppUser(
        uid: user.uid,
        email: user.email!,
        displayName: user.displayName,
        photoUrl: user.photoURL,
        lastLoginAt: DateTime.now(),
      );

      await firestoreService.saveUserProfile(appUser);
    });

    link.close();
  }

  /// Sign out
  Future signOut() async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      final authService = ref.read(authServiceProvider);
      await authService.signOut();
    });
  }

  /// Reset password
  Future resetPassword(String email) async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      final authService = ref.read(authServiceProvider);
      await authService.resetPassword(email);
    });
  }

  /// Update user profile
  Future updateProfile({
    String? displayName,
    double? annualIncome,
    String? incomeFrequency,
    List? financialGoals,
  }) async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      final authService = ref.read(authServiceProvider);
      final firestoreService = ref.read(firestoreServiceProvider);
      final user = authService.currentUser!;

      // Update display name in Firebase Auth if changed
      if (displayName != null) {
        await authService.updateDisplayName(displayName);
      }

      // Update profile in Firestore
      final existingProfile = await firestoreService.getUserProfile(user.uid);
      if (existingProfile != null) {
        final updatedProfile = existingProfile.copyWith(
          displayName: displayName,
          annualIncome: annualIncome,
          incomeFrequency: incomeFrequency,
          financialGoals: financialGoals,
        );
        await firestoreService.saveUserProfile(updatedProfile);
      }
    });
  }

  /// Delete account
  Future deleteAccount() async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      final authService = ref.read(authServiceProvider);
      await authService.deleteAccount();
    });
  }
}
