// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:blocapp/app/entities/project_task.dart';
import 'package:isar/isar.dart';

part 'project_task_model.g.dart';

@collection
class ProjectTaskModel {
  Id? id = Isar.autoIncrement;
  String name;
  int duration;
  ProjectTaskModel({
    this.id,
    required this.name,
    required this.duration,
  });

  factory ProjectTaskModel.fromEntity(ProjectTask task) {
    return ProjectTaskModel(name: task.name, duration: task.duration, id: task.id);
  }
}
