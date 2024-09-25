// lib/controllers/thumbnail_controller.dart

import 'dart:async';
import 'dart:io';

import 'package:flutter/widgets.dart';

import '../common/helpers/async_value.dart';
import '../common/helpers/constants.dart';
import '../slide/slide_configuration.dart';
import 'slide_capture_service.dart';

class ThumbnailController with ChangeNotifier {
  late AsyncValue<File> _asyncData = const AsyncValue.loading();

  ThumbnailController();

  Future<void> load(SlideConfiguration slide) async {
    try {
      final result = kCanRunProcess
          ? await _generateThumbnail(slide)
          : slide.thumbnailFile;
      _asyncData = AsyncValue.data(result);
    } catch (e, stackTrace) {
      _asyncData = AsyncValue.error(e, stackTrace);
    } finally {
      notifyListeners();
    }
  }

  Widget when({
    required Widget Function(File) data,
    required Widget Function() loading,
    required Widget Function(Object?) error,
  }) {
    return switch (_asyncData.status) {
      AsyncStatus.loading => loading(),
      AsyncStatus.sucess => data(_asyncData.requireData),
      AsyncStatus.error => error(_asyncData.error),
    };
  }

  bool get isRefreshing => _asyncData.isRefreshing;

  Future<void> refresh(SlideConfiguration slide) async {
    _asyncData = _asyncData.copyWith(status: AsyncStatus.loading);
    notifyListeners();

    try {
      _asyncData = AsyncValue.data(
        await _generateThumbnail(
          slide,
          force: true,
        ),
      );
    } catch (e, stackTrace) {
      _asyncData = AsyncValue.error(e, stackTrace);
    } finally {
      notifyListeners();
    }
  }
}

Future<File> _generateThumbnail(SlideConfiguration slide,
    {bool force = false}) async {
  final thumbnailFile = slide.thumbnailFile;

  if (await thumbnailFile.exists() && !force) {
    return thumbnailFile;
  }

  final imageData = await SlideCaptureService.instance.generate(
    slide: slide,
  );

  return await thumbnailFile.writeAsBytes(imageData, flush: true);
}
