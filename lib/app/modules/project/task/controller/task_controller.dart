import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:blocapp/app/services/projects/project_service.dart';
import 'package:blocapp/app/view_models/project_model.dart';
import 'package:blocapp/app/view_models/project_task_model.dart';

part 'task_state.dart';

class TaskController extends Cubit<TaskStatus> {
  late final ProjectModel _projectModel;

  final ProjectService _projectService;
  TaskController({required ProjectService projectService})
      : _projectService = projectService,
        super(TaskStatus.initial);

  set project(ProjectModel project) => _projectModel = project;

  Future<void> register(String name, int duration) async {
    try {
      emit(TaskStatus.loading);
      int totalHoras = _projectModel.task.fold<int>(0, ((totalValue, task) => totalValue += task.duration));
      totalHoras += duration;
      if (totalHoras > _projectModel.estimate) {
        emit(TaskStatus.hourExceed);
      } else {
        final task = ProjectTaskModel(name: name, duration: duration);
        await _projectService.addTask(_projectModel.id!, task);
        emit(TaskStatus.success);
      }
    } catch (e, s) {
      log('Erro ao salvar task', error: e, stackTrace: s);
      emit(TaskStatus.failure);
    }
  }
}
