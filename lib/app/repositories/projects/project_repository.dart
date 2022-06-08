import 'package:blocapp/app/entities/project.dart';
import 'package:blocapp/app/entities/project_status.dart';

abstract class ProjectRepository {
  Future<void> register(Project project);

  Future<List<Project>> findByStatus(ProjectStatus status);
}
