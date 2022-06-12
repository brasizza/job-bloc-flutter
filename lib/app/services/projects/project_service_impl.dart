import 'package:blocapp/app/entities/project.dart';
import 'package:blocapp/app/entities/project_status.dart';
import 'package:blocapp/app/entities/project_task.dart';
import 'package:blocapp/app/repositories/projects/project_repository.dart';
import 'package:blocapp/app/view_models/project_model.dart';
import 'package:blocapp/app/view_models/project_task_model.dart';

import './project_service.dart';

class ProjectServiceImpl implements ProjectService {
  final ProjectRepository _projectRepository;

  ProjectServiceImpl({required ProjectRepository projectRepository}) : _projectRepository = projectRepository;

  @override
  Future<void> register(ProjectModel projectModel) async {
    final project = Project()
      ..id = projectModel.id
      ..name = projectModel.name
      ..status = projectModel.status
      ..estimate = projectModel.estimate
      ..userId = projectModel.userId;

    await _projectRepository.register(project);
  }

  @override
  Future<List<ProjectModel>> findByStatus(ProjectStatus status, {String? userId}) async {
    final projects = await _projectRepository.findByStatus(status, userId);
    return projects.map(ProjectModel.fromEntity).toList();
  }

  @override
  Future<ProjectModel> addTask(int projectId, ProjectTaskModel task) async {
    final projectTask = ProjectTask()
      ..duration = task.duration
      ..name = task.name;

    final project = await _projectRepository.addTask(projectId, projectTask);
    return ProjectModel.fromEntity(project);
  }

  @override
  Future<ProjectModel> findById(int projectId) async {
    final project = await _projectRepository.findById(projectId);
    return ProjectModel.fromEntity(project);
  }

  @override
  Future<void> finish(int projectId) async => _projectRepository.finish(projectId);
}
