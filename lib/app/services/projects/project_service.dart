import 'package:blocapp/app/entities/project.dart';
import 'package:blocapp/app/entities/project_status.dart';
import 'package:blocapp/app/view_models/project_model.dart';
import 'package:blocapp/app/view_models/project_task_model.dart';

abstract class ProjectService {
  Future<void> register(ProjectModel projectModel);

  Future<List<ProjectModel>> findByStatus(ProjectStatus status);

  Future<ProjectModel> addTask(int projectId, ProjectTaskModel task);
  Future<ProjectModel> findById(int projectId);
  Future<void> finish(int projectId);
}
