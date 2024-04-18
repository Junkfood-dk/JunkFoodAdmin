// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'camera_state_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$cameraStateControllerHash() =>
    r'7933724b57832b4836a3e81f08fc7a9a44037325';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$CameraStateController
    extends BuildlessAutoDisposeAsyncNotifier<void> {
  late final CameraDescription camera;

  FutureOr<void> build(
    CameraDescription camera,
  );
}

/// See also [CameraStateController].
@ProviderFor(CameraStateController)
const cameraStateControllerProvider = CameraStateControllerFamily();

/// See also [CameraStateController].
class CameraStateControllerFamily extends Family<AsyncValue<void>> {
  /// See also [CameraStateController].
  const CameraStateControllerFamily();

  /// See also [CameraStateController].
  CameraStateControllerProvider call(
    CameraDescription camera,
  ) {
    return CameraStateControllerProvider(
      camera,
    );
  }

  @override
  CameraStateControllerProvider getProviderOverride(
    covariant CameraStateControllerProvider provider,
  ) {
    return call(
      provider.camera,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'cameraStateControllerProvider';
}

/// See also [CameraStateController].
class CameraStateControllerProvider
    extends AutoDisposeAsyncNotifierProviderImpl<CameraStateController, void> {
  /// See also [CameraStateController].
  CameraStateControllerProvider(
    CameraDescription camera,
  ) : this._internal(
          () => CameraStateController()..camera = camera,
          from: cameraStateControllerProvider,
          name: r'cameraStateControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$cameraStateControllerHash,
          dependencies: CameraStateControllerFamily._dependencies,
          allTransitiveDependencies:
              CameraStateControllerFamily._allTransitiveDependencies,
          camera: camera,
        );

  CameraStateControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.camera,
  }) : super.internal();

  final CameraDescription camera;

  @override
  FutureOr<void> runNotifierBuild(
    covariant CameraStateController notifier,
  ) {
    return notifier.build(
      camera,
    );
  }

  @override
  Override overrideWith(CameraStateController Function() create) {
    return ProviderOverride(
      origin: this,
      override: CameraStateControllerProvider._internal(
        () => create()..camera = camera,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        camera: camera,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<CameraStateController, void>
      createElement() {
    return _CameraStateControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CameraStateControllerProvider && other.camera == camera;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, camera.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin CameraStateControllerRef on AutoDisposeAsyncNotifierProviderRef<void> {
  /// The parameter `camera` of this provider.
  CameraDescription get camera;
}

class _CameraStateControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<CameraStateController, void>
    with CameraStateControllerRef {
  _CameraStateControllerProviderElement(super.provider);

  @override
  CameraDescription get camera =>
      (origin as CameraStateControllerProvider).camera;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
