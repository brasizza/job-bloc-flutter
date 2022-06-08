import 'package:blocapp/app/modules/project/register/controller/project_register_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_bloc_bind/modular_bloc_bind.dart';

import 'register_page.dart';

class RegisterModule extends Module {
  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (context, args) => RegisterPage(controller: Modular.get()),
        )
      ];

  @override
  List<Bind<Object>> get binds => [
        BlocBind.lazySingleton(
            (i) => ProjectRegisterController(projectService: i())),
      ];
}
