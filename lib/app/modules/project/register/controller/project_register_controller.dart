import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:blocapp/app/entities/project_status.dart';
import 'package:blocapp/app/services/projects/project_service.dart';
import 'package:blocapp/app/view_models/project_model.dart';

part 'project_register_state.dart';

class ProjectRegisterController extends Cubit<ProjectRegisterStatus> {
  final ProjectService _projectService;
  ProjectRegisterController({required ProjectService projectService})
      : _projectService = projectService,
        super(ProjectRegisterStatus.initial);

  Future<void> register(String name, int estimate) async {
    emit(ProjectRegisterStatus.loading);
    try {
      final project = ProjectModel(
          name: name,
          estimate: estimate,
          status: ProjectStatus.emAndamento,
          task: []);
      await _projectService.register(project);
      emit(ProjectRegisterStatus.success);
    } catch (e, s) {
      log('Erro ao salvar projeto', error: e, stackTrace: s);
      emit(ProjectRegisterStatus.failure);
    }
  }
}
