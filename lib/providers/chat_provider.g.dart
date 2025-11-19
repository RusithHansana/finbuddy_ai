// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(aiService)
const aiServiceProvider = AiServiceProvider._();

final class AiServiceProvider
    extends $FunctionalProvider<AIService, AIService, AIService>
    with $Provider<AIService> {
  const AiServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'aiServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$aiServiceHash();

  @$internal
  @override
  $ProviderElement<AIService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AIService create(Ref ref) {
    return aiService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AIService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AIService>(value),
    );
  }
}

String _$aiServiceHash() => r'c5ca77fbbebcbe821b863ad2f3cf2f523ac3a779';

@ProviderFor(CurrentConversationId)
const currentConversationIdProvider = CurrentConversationIdProvider._();

final class CurrentConversationIdProvider
    extends $NotifierProvider<CurrentConversationId, String?> {
  const CurrentConversationIdProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentConversationIdProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentConversationIdHash();

  @$internal
  @override
  CurrentConversationId create() => CurrentConversationId();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String?>(value),
    );
  }
}

String _$currentConversationIdHash() =>
    r'2363a6bc801eaadb551a3db921c4d307641b0044';

abstract class _$CurrentConversationId extends $Notifier<String?> {
  String? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<String?, String?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String?, String?>,
              String?,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(conversationMessages)
const conversationMessagesProvider = ConversationMessagesFamily._();

final class ConversationMessagesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<dynamic>>,
          List<dynamic>,
          Stream<List<dynamic>>
        >
    with $FutureModifier<List<dynamic>>, $StreamProvider<List<dynamic>> {
  const ConversationMessagesProvider._({
    required ConversationMessagesFamily super.from,
    required (String, String) super.argument,
  }) : super(
         retry: null,
         name: r'conversationMessagesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$conversationMessagesHash();

  @override
  String toString() {
    return r'conversationMessagesProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $StreamProviderElement<List<dynamic>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<dynamic>> create(Ref ref) {
    final argument = this.argument as (String, String);
    return conversationMessages(ref, argument.$1, argument.$2);
  }

  @override
  bool operator ==(Object other) {
    return other is ConversationMessagesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$conversationMessagesHash() =>
    r'84a3c4ac32ffab486f73218f62c596aa43fc5df3';

final class ConversationMessagesFamily extends $Family
    with $FunctionalFamilyOverride<Stream<List<dynamic>>, (String, String)> {
  const ConversationMessagesFamily._()
    : super(
        retry: null,
        name: r'conversationMessagesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ConversationMessagesProvider call(String userId, String conversationId) =>
      ConversationMessagesProvider._(
        argument: (userId, conversationId),
        from: this,
      );

  @override
  String toString() => r'conversationMessagesProvider';
}

@ProviderFor(ChatActions)
const chatActionsProvider = ChatActionsProvider._();

final class ChatActionsProvider
    extends $AsyncNotifierProvider<ChatActions, dynamic> {
  const ChatActionsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'chatActionsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$chatActionsHash();

  @$internal
  @override
  ChatActions create() => ChatActions();
}

String _$chatActionsHash() => r'c455deb2b28357f7e7a520a9a84986de1858da47';

abstract class _$ChatActions extends $AsyncNotifier<dynamic> {
  FutureOr<dynamic> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<dynamic>, dynamic>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<dynamic>, dynamic>,
              AsyncValue<dynamic>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
