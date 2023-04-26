import 'package:blocapp/app/modules/project/detail/controller/project_detail_controller.dart';
import 'package:blocapp/app/modules/project/detail/project_detail_page.dart';
import 'package:blocapp/app/view_models/project_model.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_bloc_bind/modular_bloc_bind.dart';

class ProjectDetailModule extends Module {
  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (context, args) {
            final ProjectModel projectModel = args.data;
            return ProjectDetailPage(controller: Modular.get()..project = projectModel);
          },
        ),
      ];

  @override
  List<Bind> get binds => [
        BlocBind.lazySingleton(
          (i) => ProjectDetailController(projectService: i()),
        ),
      ];
}
