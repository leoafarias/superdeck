import 'package:dart_mappable/dart_mappable.dart';

part 'project_analysis.dto.mapper.dart';

@MappableClass()
class ProjectReferenceContext with ProjectReferenceContextMappable {
  final List<String> entities;
  final List<String> paths;
  const ProjectReferenceContext(
    this.entities,
    this.paths,
  );

  static const fromMap = ProjectReferenceContextMapper.fromMap;
  static const fromJson = ProjectReferenceContextMapper.fromJson;
}
