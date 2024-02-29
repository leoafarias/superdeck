import 'dart:io';

import 'package:mason_logger/mason_logger.dart';
import 'package:path/path.dart';
import 'package:scope/scope.dart';

import 'helper/logger.dart';

final contextKey = ScopeKey<CliContext>();

/// Generates an [CliContext] value.
///
/// Generators are allowed to return `null`, in which case the context will
/// store the `null` value as the value for that type.
// ignore: avoid-dynamic
typedef Generator = dynamic Function(CliContext context);

CliContext get ctx => use(contextKey, withDefault: () => CliContext.main);

T getProvider<T>() => ctx.get<T>();

class CliContext {
  final String id;

  /// Generators for dependencies
  final Map<Type, dynamic>? generators;

  /// Generated values
  final Map<Type, dynamic> _dependencies = {};

  final Directory workingDirectory;

  final bool isTest;

  static final main = CliContext.create(id: 'ROOT');

  CliContext._({
    required this.id,
    this.generators,
    required this.isTest,
    required this.workingDirectory,
  });

  factory CliContext.create({
    required String id,
    Map<Type, Generator>? generators,
    Level? level,
    bool isTest = false,
    Directory? workingDirectory,
  }) {
    return CliContext._(
      id: id,
      workingDirectory: workingDirectory ?? Directory.current,
      generators: {
        LoggerService: (context) =>
            LoggerService(level: level, context: context),
      },
      isTest: isTest,
    );
  }

  Directory get assetsDir => Directory(join(workingDirectory.path, 'assets'));

  File get slidesMarkdownFile => File(join(workingDirectory.path, 'slides.md'));

  File get slidesJsonFile => File(join(assetsDir.path, 'slides.json'));

  File get assetsJsonFile => File(join(assetsDir.path, 'assets.json'));

  Directory get assetsImageDir => Directory(join(assetsDir.path, 'images'));

  File getImageFile(String name) => File(join(assetsImageDir.path, name));

  T get<T>() {
    if (_dependencies.containsKey(T)) {
      return _dependencies[T] as T;
    }
    if (generators != null && generators!.containsKey(T)) {
      final generator = generators![T] as Generator;
      _dependencies[T] = generator(this);

      return _dependencies[T];
    }
    throw Exception('Generator for $T not found');
  }
}

abstract class ContextService {
  final CliContext? _context;
  const ContextService(CliContext? context) : _context = context;

  CliContext get context {
    return _context == null ? ctx : _context!;
  }
}
