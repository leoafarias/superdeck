import 'package:dart_mappable/dart_mappable.dart';

import './slide_options.model.dart';

part 'slide_data.model.mapper.dart';

@MappableClass()
class SlideData with SlideDataMappable {
  final String? content;
  final SlideOptions options;

  const SlideData({
    this.content,
    this.options = const SlideOptions(),
  });

  static final fromMap = SlideDataMapper.fromMap;
  static final fromJson = SlideDataMapper.fromJson;
}
