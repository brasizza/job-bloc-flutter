import 'dart:developer';

import 'package:blocapp/app/core/database/database.dart';
import 'package:blocapp/app/core/exceptions/failure.dart';
import 'package:blocapp/app/entities/project.dart';
import 'package:blocapp/app/entities/project_status.dart';
import 'package:blocapp/app/entities/project_task.dart';
import 'package:isar/isar.dart';

import './project_repository.dart';

class ProjectRepositoryImpl implements ProjectRepository {
  final Database _database;

  ProjectRepositoryImpl({required Database database}) : _database = database;
  @override
  Future<void> register(Project project) async {
    try {
      final connection = await _database.openConnection();
      await connection.writeTxn((isar) {
        return isar.projects.put(project);
      });
    } on IsarError catch (e, s) {
      log('Erro ao cadastrar do projeto', error: e, stackTrace: s);
      throw Failure('Erro ao cadastrar projeto');
    }
  }

  @override
  Future<List<Project>> findByStatus(ProjectStatus status, String? userId) async {
    final connection = await _database.openConnection();
    final projectFilter = connection.projects.filter().statusEqualTo(status);
    if (userId != null) {
      return await projectFilter.and().userIdEqualTo(userId).findAll();
    }
    return await projectFilter.findAll();
  }

  @override
  Future<Project> addTask(int projectId, ProjectTask task) async {
    final connection = await _database.openConnection();
    final project = await findById(projectId);
    project.tasks.add(task);
    await connection.writeTxn((isar) => project.tasks.save());
    return project;
  }

  @override
  Future<Project> findById(int projectId) async {
    final connection = await _database.openConnection();
    final project = await connection.projects.get(projectId);
    if (project == null) {
      throw Failure('Projeto não encontrado');
    }
    return project;
  }

  @override
  Future<void> finish(int projectId) async {
    try {
      final connection = await _database.openConnection();
      final project = await findById(projectId);
      project.status = ProjectStatus.finalizado;

      await connection.writeTxn((isar) => connection.projects.put(project, saveLinks: true));
    } on IsarError catch (e, s) {
      log(e.message, error: e, stackTrace: s);
      throw Failure('Erro ao finalizar projeto');
    }
  }

  @override
  Future<void> deleteTask(int? taskId) async {
    try {
      final connection = await _database.openConnection();
      await connection.writeTxn((isar) => connection.projectTasks.delete(taskId!));
    } on IsarError catch (e, s) {
      log(e.message, error: e, stackTrace: s);
      throw Failure('Erro ao finalizar projeto');
    }
  }
}
