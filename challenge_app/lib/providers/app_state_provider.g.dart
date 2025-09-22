// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_state_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AppStateNotifier)
const appStateProvider = AppStateNotifierProvider._();

final class AppStateNotifierProvider
    extends $AsyncNotifierProvider<AppStateNotifier, AppState> {
  const AppStateNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appStateProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appStateNotifierHash();

  @$internal
  @override
  AppStateNotifier create() => AppStateNotifier();
}

String _$appStateNotifierHash() => r'2a4f800f5e7eb22304d05df3ba19e4cf3cbd6197';

abstract class _$AppStateNotifier extends $AsyncNotifier<AppState> {
  FutureOr<AppState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<AppState>, AppState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<AppState>, AppState>,
              AsyncValue<AppState>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
