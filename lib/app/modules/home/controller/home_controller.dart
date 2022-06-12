import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:blocapp/app/services/projects/project_service.dart';
import 'package:equatable/equatable.dart';

import '../../../entities/project_status.dart';
import '../../../view_models/project_model.dart';

part 'home_state.dart';

class HomeController extends Cubit<HomeState> {
  final ProjectService _projectService;
  HomeController({required ProjectService projectService})
      : _projectService = projectService,
        super(HomeState.initial());

  Future<void> loadProject() async {
    emit(state.copyWith(status: HomeStatus.loading));
    try {
      final _projects = await _projectService.findByStatus(state.projectFilter);
      emit(state.copyWith(status: HomeStatus.complete, projects: _projects));
    } on Exception catch (e, s) {
      log('Erro ao buscar os projetos', error: e, stackTrace: s);
      emit(state.copyWith(status: HomeStatus.failure));
    }
  }

  Future<void> filter(ProjectStatus status) async {
    emit(
      state.copyWith(
        status: HomeStatus.loading,
        projects: [],
      ),
    );
    final projects = await _projectService.findByStatus(status);
    emit(
      state.copyWith(
        projectFilter: status,
        status: HomeStatus.complete,
        projects: projects,
      ),
    );
  }

  void updateList() => filter(state.projectFilter);
}
