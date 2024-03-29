// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:blocapp/app/entities/project.dart';
import 'package:blocapp/app/entities/project_status.dart';
import 'package:blocapp/app/view_models/project_task_model.dart';
import 'package:isar/isar.dart';

class ProjectModel {
  final Id? id;
  final String name;
  final int estimate;
  final ProjectStatus status;

  final List<ProjectTaskModel> task;

  final String userId;
  ProjectModel({this.id = Isar.autoIncrement, required this.name, required this.estimate, required this.status, required this.task, required this.userId});

  factory ProjectModel.fromEntity(Project project) {
    project.tasks.loadSync();
    return ProjectModel(
      id: project.id,
      name: project.name,
      estimate: project.estimate,
      status: project.status,
      userId: project.userId,
      task: project.tasks.map(ProjectTaskModel.fromEntity).toList(),
    );
  }
}
