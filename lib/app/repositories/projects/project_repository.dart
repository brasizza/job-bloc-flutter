import 'package:blocapp/app/entities/project.dart';
import 'package:blocapp/app/entities/project_status.dart';

import '../../entities/project_task.dart';

abstract class ProjectRepository {
  Future<void> register(Project project);
  Future<List<Project>> findByStatus(ProjectStatus status, String? userId);
  Future<Project> addTask(int projectId, ProjectTask task);
  Future<Project> findById(int projectId);

  Future<void> finish(int projectId);
}
