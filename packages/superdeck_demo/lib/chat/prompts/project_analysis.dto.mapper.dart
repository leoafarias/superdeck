// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'project_analysis.dto.dart';

class ProjectReferenceContextMapper
    extends ClassMapperBase<ProjectReferenceContext> {
  ProjectReferenceContextMapper._();

  static ProjectReferenceContextMapper? _instance;
  static ProjectReferenceContextMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals
          .use(_instance = ProjectReferenceContextMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'ProjectReferenceContext';

  static List<String> _$entities(ProjectReferenceContext v) => v.entities;
  static const Field<ProjectReferenceContext, List<String>> _f$entities =
      Field('entities', _$entities);
  static List<String> _$paths(ProjectReferenceContext v) => v.paths;
  static const Field<ProjectReferenceContext, List<String>> _f$paths =
      Field('paths', _$paths);

  @override
  final Map<Symbol, Field<ProjectReferenceContext, dynamic>> fields = const {
    #entities: _f$entities,
    #paths: _f$paths,
  };

  static ProjectReferenceContext _instantiate(DecodingData data) {
    return ProjectReferenceContext(data.dec(_f$entities), data.dec(_f$paths));
  }

  @override
  final Function instantiate = _instantiate;

  static ProjectReferenceContext fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ProjectReferenceContext>(map);
  }

  static ProjectReferenceContext fromJson(String json) {
    return ensureInitialized().decodeJson<ProjectReferenceContext>(json);
  }
}

mixin ProjectReferenceContextMappable {
  String toJson() {
    return ProjectReferenceContextMapper.ensureInitialized()
        .encodeJson<ProjectReferenceContext>(this as ProjectReferenceContext);
  }

  Map<String, dynamic> toMap() {
    return ProjectReferenceContextMapper.ensureInitialized()
        .encodeMap<ProjectReferenceContext>(this as ProjectReferenceContext);
  }

  ProjectReferenceContextCopyWith<ProjectReferenceContext,
          ProjectReferenceContext, ProjectReferenceContext>
      get copyWith => _ProjectReferenceContextCopyWithImpl(
          this as ProjectReferenceContext, $identity, $identity);
  @override
  String toString() {
    return ProjectReferenceContextMapper.ensureInitialized()
        .stringifyValue(this as ProjectReferenceContext);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            ProjectReferenceContextMapper.ensureInitialized()
                .isValueEqual(this as ProjectReferenceContext, other));
  }

  @override
  int get hashCode {
    return ProjectReferenceContextMapper.ensureInitialized()
        .hashValue(this as ProjectReferenceContext);
  }
}

extension ProjectReferenceContextValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ProjectReferenceContext, $Out> {
  ProjectReferenceContextCopyWith<$R, ProjectReferenceContext, $Out>
      get $asProjectReferenceContext => $base
          .as((v, t, t2) => _ProjectReferenceContextCopyWithImpl(v, t, t2));
}

abstract class ProjectReferenceContextCopyWith<
    $R,
    $In extends ProjectReferenceContext,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get entities;
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get paths;
  $R call({List<String>? entities, List<String>? paths});
  ProjectReferenceContextCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _ProjectReferenceContextCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ProjectReferenceContext, $Out>
    implements
        ProjectReferenceContextCopyWith<$R, ProjectReferenceContext, $Out> {
  _ProjectReferenceContextCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ProjectReferenceContext> $mapper =
      ProjectReferenceContextMapper.ensureInitialized();
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get entities =>
      ListCopyWith($value.entities, (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(entities: v));
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get paths =>
      ListCopyWith($value.paths, (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(paths: v));
  @override
  $R call({List<String>? entities, List<String>? paths}) =>
      $apply(FieldCopyWithData({
        if (entities != null) #entities: entities,
        if (paths != null) #paths: paths
      }));
  @override
  ProjectReferenceContext $make(CopyWithData data) => ProjectReferenceContext(
      data.get(#entities, or: $value.entities),
      data.get(#paths, or: $value.paths));

  @override
  ProjectReferenceContextCopyWith<$R2, ProjectReferenceContext, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _ProjectReferenceContextCopyWithImpl($value, $cast, t);
}
