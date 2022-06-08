import 'package:blocapp/app/modules/project/detail/project_detail_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ProjectDetailModule extends Module {
  @override
  // TODO: implement routes
  List<ModularRoute> get routes =>
      [ChildRoute('/', child: (context, args) => ProjectDetailPage())];
}
