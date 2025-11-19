import 'package:finbuddy_ai/providers/auth_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'history_provider.g.dart';

// ============== CONVERSATIONS STREAM PROVIDER ==============

@riverpod
Stream<List> userConversations(Ref ref, String userId) {
  final firestoreService = ref.watch(firestoreServiceProvider);
  return firestoreService.streamConversations(userId);
}

// ============== SEARCH QUERY PROVIDER ==============

@riverpod
class SearchQuery extends _$SearchQuery {
  @override
  String build() => '';

  void updateQuery(String query) {
    state = query;
  }

  void clearQuery() {
    state = '';
  }
}

// ============== FILTERED CONVERSATIONS PROVIDER ==============

@riverpod
Future<List> filteredConversations(Ref ref, String userId) async {
  final query = ref.watch(searchQueryProvider);
  final firestoreService = ref.watch(firestoreServiceProvider);

  if (query.isEmpty) {
    return await firestoreService.getConversations(userId);
  }

  return await firestoreService.searchConversations(userId, query);
}

// ============== HISTORY ACTIONS PROVIDER ==============

@riverpod
class HistoryActions extends _$HistoryActions {
  @override
  FutureOr build() {}

  /// Delete a conversation
  Future deleteConversation({
    required String userId,
    required String conversationId,
  }) async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      final firestoreService = ref.read(firestoreServiceProvider);
      await firestoreService.deleteConversation(userId, conversationId);
    });
  }

  /// Delete multiple conversations
  Future deleteMultipleConversations({
    required String userId,
    required List conversationIds,
  }) async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      final firestoreService = ref.read(firestoreServiceProvider);

      for (final conversationId in conversationIds) {
        await firestoreService.deleteConversation(userId, conversationId);
      }
    });
  }

  /// Search conversations
  Future<List> searchConversations({
    required String userId,
    required String query,
  }) async {
    final firestoreService = ref.read(firestoreServiceProvider);
    return await firestoreService.searchConversations(userId, query);
  }
}
