// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:blocapp/app/entities/project.dart';
import 'package:blocapp/app/entities/project_status.dart';
import 'package:blocapp/app/entities/project_task.dart';
import 'package:blocapp/app/view_models/project_task_model.dart';

class ProjectModel {
  final int? id;
  final String name;
  final int estimate;
  final ProjectStatus status;

  final List<ProjectTaskModel> task;
  ProjectModel({
    this.id,
    required this.name,
    required this.estimate,
    required this.status,
    required this.task,
  });

  factory ProjectModel.fromEntity(Project project) {
    project.tasks.loadSync();
    return ProjectModel(
        name: project.name,
        estimate: project.estimate,
        status: project.status,
        task: project.tasks.map(ProjectTaskModel.fromEntity).toList());
  }
}
