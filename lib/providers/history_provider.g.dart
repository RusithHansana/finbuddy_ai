// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(userConversations)
const userConversationsProvider = UserConversationsFamily._();

final class UserConversationsProvider extends $FunctionalProvider<
        AsyncValue<List<dynamic>>, List<dynamic>, Stream<List<dynamic>>>
    with $FutureModifier<List<dynamic>>, $StreamProvider<List<dynamic>> {
  const UserConversationsProvider._({
    required UserConversationsFamily super.from,
    required String super.argument,
  }) : super(
          retry: null,
          name: r'userConversationsProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$userConversationsHash();

  @override
  String toString() {
    return r'userConversationsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<List<dynamic>> $createElement(
    $ProviderPointer pointer,
  ) =>
      $StreamProviderElement(pointer);

  @override
  Stream<List<dynamic>> create(Ref ref) {
    final argument = this.argument as String;
    return userConversations(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is UserConversationsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$userConversationsHash() => r'b05fd99578c790366cd4880459a8ca2157633e42';

final class UserConversationsFamily extends $Family
    with $FunctionalFamilyOverride<Stream<List<dynamic>>, String> {
  const UserConversationsFamily._()
      : super(
          retry: null,
          name: r'userConversationsProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  UserConversationsProvider call(String userId) =>
      UserConversationsProvider._(argument: userId, from: this);

  @override
  String toString() => r'userConversationsProvider';
}

@ProviderFor(SearchQuery)
const searchQueryProvider = SearchQueryProvider._();

final class SearchQueryProvider extends $NotifierProvider<SearchQuery, String> {
  const SearchQueryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'searchQueryProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$searchQueryHash();

  @$internal
  @override
  SearchQuery create() => SearchQuery();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$searchQueryHash() => r'5cfb8bc058f64b12d9a61421526a8ea7b414d4fa';

abstract class _$SearchQuery extends $Notifier<String> {
  String build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<String, String>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<String, String>, String, Object?, Object?>;
    element.handleValue(ref, created);
  }
}

@ProviderFor(filteredConversations)
const filteredConversationsProvider = FilteredConversationsFamily._();

final class FilteredConversationsProvider extends $FunctionalProvider<
        AsyncValue<List<dynamic>>, List<dynamic>, FutureOr<List<dynamic>>>
    with $FutureModifier<List<dynamic>>, $FutureProvider<List<dynamic>> {
  const FilteredConversationsProvider._({
    required FilteredConversationsFamily super.from,
    required String super.argument,
  }) : super(
          retry: null,
          name: r'filteredConversationsProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$filteredConversationsHash();

  @override
  String toString() {
    return r'filteredConversationsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<dynamic>> $createElement(
    $ProviderPointer pointer,
  ) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<dynamic>> create(Ref ref) {
    final argument = this.argument as String;
    return filteredConversations(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is FilteredConversationsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$filteredConversationsHash() =>
    r'910a97c7a2b2c9891b41d12c2a9bb6031f911e84';

final class FilteredConversationsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<dynamic>>, String> {
  const FilteredConversationsFamily._()
      : super(
          retry: null,
          name: r'filteredConversationsProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  FilteredConversationsProvider call(String userId) =>
      FilteredConversationsProvider._(argument: userId, from: this);

  @override
  String toString() => r'filteredConversationsProvider';
}

@ProviderFor(HistoryActions)
const historyActionsProvider = HistoryActionsProvider._();

final class HistoryActionsProvider
    extends $AsyncNotifierProvider<HistoryActions, dynamic> {
  const HistoryActionsProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'historyActionsProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$historyActionsHash();

  @$internal
  @override
  HistoryActions create() => HistoryActions();
}

String _$historyActionsHash() => r'cf5f035998ddb207ec7950df77f8066e7da2601a';

abstract class _$HistoryActions extends $AsyncNotifier<dynamic> {
  FutureOr<dynamic> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<dynamic>, dynamic>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<dynamic>, dynamic>,
        AsyncValue<dynamic>,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}
