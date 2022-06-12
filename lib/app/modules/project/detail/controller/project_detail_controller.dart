import 'package:blocapp/app/services/projects/project_service.dart';
import 'package:blocapp/app/view_models/project_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'project_detail_state.dart';

class ProjectDetailController extends Cubit<ProjectDetailState> {
  final ProjectService _projectService;
  ProjectDetailController({required ProjectService projectService})
      : _projectService = projectService,
        super(const ProjectDetailState.intial());

  set project(ProjectModel project) {
    emit(state.copyWith(projectModel: project, status: ProjectDetailStatus.complete));
  }

  void updateProject() async {
    final project = await _projectService.findById(state.projectModel!.id!);
    emit(state.copyWith(
      projectModel: project,
      status: ProjectDetailStatus.complete,
    ));
  }

  Future<void> finishProject() async {
    try {
      emit(state.copyWith(status: ProjectDetailStatus.loading));
      final projectId = state.projectModel!.id!;
      await _projectService.finish(projectId);

      updateProject();
    } catch (e) {
      emit(state.copyWith(status: ProjectDetailStatus.failure));
    }
  }
}
