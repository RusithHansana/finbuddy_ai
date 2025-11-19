import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finbuddy_ai/models/app_user.dart';
import 'package:finbuddy_ai/models/conversation.dart';
import 'package:finbuddy_ai/models/message.dart';
import 'package:finbuddy_ai/utils/constants.dart';

/// Firestore service for database operations
/// Handles all Firestore CRUD operations
class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Collection references
  CollectionReference get _usersCollection =>
      _firestore.collection(AppConstants.usersCollection);

  CollectionReference _conversationsCollection(String userId) =>
      _usersCollection
          .doc(userId)
          .collection(AppConstants.conversationsCollection);

  CollectionReference _messagesCollection(
    String userId,
    String conversationId,
  ) => _conversationsCollection(
    userId,
  ).doc(conversationId).collection(AppConstants.messagesCollection);

  // ============== USER OPERATIONS ==============

  /// Create or update user profile
  Future saveUserProfile(AppUser user) async {
    try {
      await _usersCollection
          .doc(user.uid)
          .set(AppUser.toFirestore(user), SetOptions(merge: true));
    } catch (e) {
      throw FirestoreException('Failed to save user profile: ${e.toString()}');
    }
  }

  /// Get user profile
  Future getUserProfile(String userId) async {
    try {
      final doc = await _usersCollection.doc(userId).get();
      if (!doc.exists) return null;
      return AppUser.fromFirestore(
        doc as DocumentSnapshot<Map<String, dynamic>>,
      );
    } catch (e) {
      throw FirestoreException('Failed to get user profile: ${e.toString()}');
    }
  }

  /// Stream user profile
  Stream streamUserProfile(String userId) {
    return _usersCollection.doc(userId).snapshots().map((doc) {
      if (!doc.exists) return null;
      return AppUser.fromFirestore(
        doc as DocumentSnapshot<Map<String, dynamic>>,
      );
    });
  }

  /// Update user context
  Future updateUserContext(String userId, Map context) async {
    try {
      await _usersCollection.doc(userId).update({'context': context});
    } catch (e) {
      throw FirestoreException(
        'Failed to update user context: ${e.toString()}',
      );
    }
  }

  // ============== CONVERSATION OPERATIONS ==============

  /// Create a new conversation
  Future createConversation({
    required String userId,
    required String firstMessage,
  }) async {
    try {
      final conversation = Conversation(
        id: '', // Will be set by Firestore
        userId: userId,
        title: firstMessage.length > 50
            ? '${firstMessage.substring(0, 50)}...'
            : firstMessage,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        messageCount: 0,
      );

      final docRef = await _conversationsCollection(
        userId,
      ).add(Conversation.toFirestore(conversation));

      return docRef.id;
    } catch (e) {
      throw FirestoreException(
        'Failed to create conversation: ${e.toString()}',
      );
    }
  }

  /// Get all conversations for a user
  Future<List> getConversations(String userId) async {
    try {
      final snapshot = await _conversationsCollection(
        userId,
      ).orderBy('updatedAt', descending: true).get();

      return snapshot.docs
          .map(
            (doc) => Conversation.fromFirestore(
              doc as DocumentSnapshot<Map<String, dynamic>>,
            ),
          )
          .toList();
    } catch (e) {
      throw FirestoreException('Failed to get conversations: ${e.toString()}');
    }
  }

  /// Stream conversations for a user
  Stream<List> streamConversations(String userId) {
    return _conversationsCollection(userId)
        .orderBy('updatedAt', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map(
                (doc) => Conversation.fromFirestore(
                  doc as DocumentSnapshot<Map<String, dynamic>>,
                ),
              )
              .toList(),
        );
  }

  /// Update conversation
  Future updateConversation(
    String userId,
    String conversationId, {
    String? lastMessageText,
  }) async {
    try {
      await _conversationsCollection(userId).doc(conversationId).update({
        'updatedAt': FieldValue.serverTimestamp(),
        if (lastMessageText != null) 'lastMessageText': lastMessageText,
        'messageCount': FieldValue.increment(1),
      });
    } catch (e) {
      throw FirestoreException(
        'Failed to update conversation: ${e.toString()}',
      );
    }
  }

  /// Delete conversation
  Future deleteConversation(String userId, String conversationId) async {
    try {
      // Delete all messages in the conversation
      final messagesSnapshot = await _messagesCollection(
        userId,
        conversationId,
      ).get();
      for (var doc in messagesSnapshot.docs) {
        await doc.reference.delete();
      }

      // Delete the conversation
      await _conversationsCollection(userId).doc(conversationId).delete();
    } catch (e) {
      throw FirestoreException(
        'Failed to delete conversation: ${e.toString()}',
      );
    }
  }

  // ============== MESSAGE OPERATIONS ==============

  /// Save a message
  Future saveMessage(Message message, String userId) async {
    try {
      await _messagesCollection(
        userId,
        message.conversationId,
      ).doc(message.id).set(Message.toFirestore(message));

      // Update conversation with last message
      await updateConversation(
        userId,
        message.conversationId,
        lastMessageText: message.text,
      );
    } catch (e) {
      throw FirestoreException('Failed to save message: ${e.toString()}');
    }
  }

  /// Get messages for a conversation
  Future<List> getMessages(
    String userId,
    String conversationId, {
    int limit = 50,
  }) async {
    try {
      final snapshot = await _messagesCollection(
        userId,
        conversationId,
      ).orderBy('timestamp', descending: false).limit(limit).get();

      return snapshot.docs
          .map(
            (doc) => Message.fromFirestore(
              doc as DocumentSnapshot<Map<String, dynamic>>,
            ),
          )
          .toList();
    } catch (e) {
      throw FirestoreException('Failed to get messages: ${e.toString()}');
    }
  }

  /// Stream messages for a conversation
  Stream<List> streamMessages(String userId, String conversationId) {
    return _messagesCollection(userId, conversationId)
        .orderBy('timestamp', descending: false)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map(
                (doc) => Message.fromFirestore(
                  doc as DocumentSnapshot<Map<String, dynamic>>,
                ),
              )
              .toList(),
        );
  }

  /// Delete a message
  Future deleteMessage(
    String userId,
    String conversationId,
    String messageId,
  ) async {
    try {
      await _messagesCollection(userId, conversationId).doc(messageId).delete();
    } catch (e) {
      throw FirestoreException('Failed to delete message: ${e.toString()}');
    }
  }

  /// Search conversations by text
  Future<List> searchConversations(String userId, String query) async {
    try {
      final allConversations = await getConversations(userId);

      // Client-side filtering (Firestore doesn't support full-text search)
      return allConversations.where((conversation) {
        final titleMatch = conversation.title.toLowerCase().contains(
          query.toLowerCase(),
        );
        final messageMatch =
            conversation.lastMessageText?.toLowerCase().contains(
              query.toLowerCase(),
            ) ??
            false;
        return titleMatch || messageMatch;
      }).toList();
    } catch (e) {
      throw FirestoreException(
        'Failed to search conversations: ${e.toString()}',
      );
    }
  }
}

/// Custom exception for Firestore errors
class FirestoreException implements Exception {
  final String message;
  FirestoreException(this.message);

  @override
  String toString() => message;
}
