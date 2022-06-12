import 'package:blocapp/app/modules/project/task/controller/task_controller.dart';
import 'package:blocapp/app/modules/project/task/task_page.dart';
import 'package:blocapp/app/view_models/project_model.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_bloc_bind/modular_bloc_bind.dart';

class TaskModule extends Module {
  @override
  // TODO: implement binds
  List<Bind<Object>> get binds => [BlocBind.lazySingleton((i) => TaskController(projectService: i()))];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: ((context, args) {
          final ProjectModel projectModel = args.data;
          return TaskPage(
            controller: Modular.get()..project = projectModel,
          );
        }))
      ];
}
