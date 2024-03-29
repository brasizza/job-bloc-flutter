import 'package:blocapp/app/modules/project/detail/project_detail_module.dart';
import 'package:blocapp/app/modules/project/register/register_module.dart';
import 'package:blocapp/app/modules/project/task/task_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ProjectModule extends Module {
  @override
  List<ModularRoute> get routes => [
        ModuleRoute('/register', module: RegisterModule()),
        ModuleRoute('/detail', module: ProjectDetailModule()),
        ModuleRoute('/task', module: TaskModule()),
      ];
}
