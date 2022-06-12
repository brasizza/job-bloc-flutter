import 'package:blocapp/app/entities/project_status.dart';
import 'package:blocapp/app/modules/home/controller/home_controller.dart';
import 'package:blocapp/app/modules/project/detail/controller/project_detail_controller.dart';
import 'package:blocapp/app/view_models/project_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ProjectDetailAppbar extends SliverAppBar {
  ProjectDetailAppbar({required ProjectModel projectModel, super.key})
      : super(
          expandedHeight: 100,
          pinned: true,
          toolbarHeight: 100,
          title: Text(projectModel.name),
          centerTitle: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(15),
            ),
          ),
          flexibleSpace: Stack(
            children: [
              Align(
                alignment: const Alignment(0, 1.6),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Material(
                    elevation: 2,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      height: 48,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text('${projectModel.task.length} tasks'),
                          _NewTaks(projectModel: projectModel),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
}

class _NewTaks extends StatelessWidget {
  final ProjectModel projectModel;
  const _NewTaks({Key? key, required this.projectModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: projectModel.status != ProjectStatus.finalizado,
      replacement: const Text("Projeto finalizado"),
      child: InkWell(
        onTap: () async {
          await Modular.to.pushNamed('/project/task/', arguments: projectModel);
          Modular.get<ProjectDetailController>().updateProject();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: CircleAvatar(
                backgroundColor: Theme.of(context).primaryColor,
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
            const Text('Adicionar task')
          ],
        ),
      ),
    );
  }
}
