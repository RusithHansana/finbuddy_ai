import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

/// Authentication service using Firebase Auth
/// Handles all authentication operations
class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn.instance;
  bool _isGoogleSignInInitialized = false;

  AuthService() {
    _initializeGoogleSignIn();
  }

  Future _initializeGoogleSignIn() async {
    if (_isGoogleSignInInitialized) return;

    try {
      await _googleSignIn.initialize();
      _isGoogleSignInInitialized = true;
    } catch (e) {
      throw AuthException(
        'Failed to initialize Google Sign-In: ${e.toString()}',
      );
    }
  }

  /// Stream of authentication state changes
  Stream get authStateChanges => _auth.authStateChanges();

  /// Get current user
  User? get currentUser => _auth.currentUser;

  /// Check if user is authenticated
  bool get isAuthenticated => currentUser != null;

  /// Sign up with email and password
  Future signUpWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  /// Sign in with email and password
  Future signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  /// Sign in with Google
  Future signInWithGoogle() async {
    try {
      if (!_isGoogleSignInInitialized) {
        await _initializeGoogleSignIn();
      }

      final GoogleSignInAccount googleUser = await _googleSignIn.authenticate(
        scopeHint: ['email', 'profile'],
      );

      final GoogleSignInAuthentication googleAuth = googleUser.authentication;

      final authClient = _googleSignIn.authorizationClient;
      final authorization = await authClient.authorizationForScopes([
        'email',
        'profile',
      ]);

      final credential = GoogleAuthProvider.credential(
        accessToken: authorization?.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await _auth.signInWithCredential(credential);
      return userCredential;
    } catch (e) {
      throw AuthException('Failed to sign in with Google: ${e.toString()}');
    }
  }

  /// Sign out
  Future signOut() async {
    try {
      await Future.wait([_auth.signOut(), _googleSignIn.signOut()]);
    } catch (e) {
      throw AuthException('Failed to sign out: ${e.toString()}');
    }
  }

  /// Send password reset email
  Future resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  /// Update display name
  Future updateDisplayName(String displayName) async {
    try {
      await currentUser?.updateDisplayName(displayName);
      await currentUser?.reload();
    } catch (e) {
      throw AuthException('Failed to update display name: ${e.toString()}');
    }
  }

  /// Delete user account
  Future deleteAccount() async {
    try {
      await currentUser?.delete();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        throw AuthException(
          'Please sign in again before deleting your account',
        );
      }
      throw _handleAuthException(e);
    }
  }

  /// Handle Firebase Auth exceptions
  AuthException _handleAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'weak-password':
        return AuthException('The password provided is too weak');
      case 'email-already-in-use':
        return AuthException('An account already exists for that email');
      case 'user-not-found':
        return AuthException('No user found for that email');
      case 'invalid-credential':
        return AuthException(
          'Email or password is incorrect. Please try again!',
        );
      case 'user-disabled':
        return AuthException('This user account has been disabled');
      case 'too-many-requests':
        return AuthException('Too many attempts. Please try again later');
      case 'operation-not-allowed':
        return AuthException('This sign-in method is not enabled');
      default:
        return AuthException(e.message ?? 'An authentication error occurred');
    }
  }
}

/// Custom exception for authentication errors
class AuthException implements Exception {
  final String message;
  AuthException(this.message);

  @override
  String toString() => message;
}
