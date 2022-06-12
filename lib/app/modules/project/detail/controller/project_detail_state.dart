// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'project_detail_controller.dart';

enum ProjectDetailStatus { initial, loading, complete, failure }

class ProjectDetailState extends Equatable {
  final ProjectDetailStatus status;
  final ProjectModel? projectModel;
  const ProjectDetailState._({
    required this.status,
    this.projectModel,
  });

  const ProjectDetailState.intial() : this._(status: ProjectDetailStatus.initial);

  ProjectDetailState copyWith({
    ProjectDetailStatus? status,
    ProjectModel? projectModel,
  }) {
    return ProjectDetailState._(
      status: status ?? this.status,
      projectModel: projectModel ?? this.projectModel,
    );
  }

  @override
  List<Object?> get props => [status, projectModel];
}
