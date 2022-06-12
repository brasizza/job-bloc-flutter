import 'package:blocapp/app/core/ui/job_timer_icons_icons.dart';
import 'package:blocapp/app/modules/home/controller/home_controller.dart';
import 'package:blocapp/app/view_models/project_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ProjectListTile extends StatelessWidget {
  final ProjectModel projectModel;
  const ProjectListTile({super.key, required this.projectModel});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await Modular.to.pushNamed('/project/detail', arguments: projectModel);
        Modular.get<HomeController>().updateList();
      },
      child: Container(
        constraints: const BoxConstraints(maxHeight: 90),
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade300, width: 4),
        ),
        child: Column(
          children: [
            _ProjectName(projectModel: projectModel),
            Expanded(
              child: _ProjectProgress(
                projectModel: projectModel,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProjectName extends StatelessWidget {
  final ProjectModel projectModel;
  const _ProjectName({required this.projectModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(projectModel.name),
          Icon(JobTimerIcons.angle_double_right, color: Theme.of(context).primaryColor, size: 20),
        ],
      ),
    );
  }
}

class _ProjectProgress extends StatelessWidget {
  final ProjectModel projectModel;
  const _ProjectProgress({required this.projectModel});

  @override
  Widget build(BuildContext context) {
    final totalTaks = projectModel.task.fold<int>(0, ((previousValue, task) => previousValue += task.duration));
    double percent = 0.0;

    if (totalTaks > 0) {
      percent = totalTaks / projectModel.estimate;
    }
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(children: [
        Expanded(
            child: LinearProgressIndicator(
          value: percent,
          backgroundColor: Colors.grey.shade400,
          color: Theme.of(context).primaryColor,
        )),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            "${projectModel.estimate} h",
          ),
        ),
      ]),
    );
  }
}
