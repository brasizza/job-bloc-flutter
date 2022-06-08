import 'package:blocapp/app/entities/project_status.dart';
import 'package:blocapp/app/view_models/project_model.dart';

abstract class ProjectService {
  Future<void> register(ProjectModel projectModel);

  Future<List<ProjectModel>> findByStatus(ProjectStatus status);
}
