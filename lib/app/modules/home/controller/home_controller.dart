import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:blocapp/app/services/projects/project_service.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
      final String userId = FirebaseAuth.instance.currentUser?.uid ?? '';
      final projects = await _projectService.findByStatus(state.projectFilter, userId: userId);
      emit(state.copyWith(status: HomeStatus.complete, projects: projects));
    } on Exception catch (e, s) {
      log('Erro ao buscar os projetos', error: e, stackTrace: s);
      emit(state.copyWith(status: HomeStatus.failure));
    }
  }

  Future<void> filter(ProjectStatus status) async {
    final String userId = FirebaseAuth.instance.currentUser?.uid ?? '';

    emit(
      state.copyWith(
        status: HomeStatus.loading,
        projects: [],
      ),
    );
    final projects = await _projectService.findByStatus(status, userId: userId);
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
