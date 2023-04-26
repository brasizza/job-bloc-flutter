import 'package:blocapp/app/entities/project_status.dart';
import 'package:blocapp/app/entities/project_task.dart';
import 'package:isar/isar.dart';

part 'project.g.dart';

@Collection()
class Project {
  Id id = Isar.autoIncrement;
  late String name;
  @enumerated
  late ProjectStatus status;
  late int estimate;
  final tasks = IsarLinks<ProjectTask>();
  late String userId;
}
