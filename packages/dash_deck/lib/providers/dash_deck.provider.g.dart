// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dash_deck.provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$currentSlideHash() => r'8d2aace41b27bf2ed8d1589ccde9cdd77f807490';

/// See also [currentSlide].
@ProviderFor(currentSlide)
final currentSlideProvider = AutoDisposeProvider<Slide?>.internal(
  currentSlide,
  name: r'currentSlideProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$currentSlideHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef CurrentSlideRef = AutoDisposeProviderRef<Slide?>;
String _$slidePageHash() => r'3d3d10e8df4d2cbc242e66b9d0eddf952c0028b8';

/// See also [SlidePage].
@ProviderFor(SlidePage)
final slidePageProvider = AutoDisposeNotifierProvider<SlidePage, int>.internal(
  SlidePage.new,
  name: r'slidePageProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$slidePageHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SlidePage = AutoDisposeNotifier<int>;
String _$deckControllerHash() => r'976d160cee43e92bda79d58ea1866625328921b3';

/// See also [DeckController].
@ProviderFor(DeckController)
final deckControllerProvider =
    AutoDisposeAsyncNotifierProvider<DeckController, DashDeckData>.internal(
  DeckController.new,
  name: r'deckControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$deckControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$DeckController = AutoDisposeAsyncNotifier<DashDeckData>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
