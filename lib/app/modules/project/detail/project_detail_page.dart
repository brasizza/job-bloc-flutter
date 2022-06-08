import 'package:blocapp/app/core/ui/job_timer_icons_icons.dart';
import 'package:blocapp/app/modules/project/detail/widgets/project_detail_appbar.dart';
import 'package:blocapp/app/modules/project/detail/widgets/project_pie_chart.dart';
import 'package:blocapp/app/modules/project/detail/widgets/project_task_tile.dart';
import 'package:flutter/material.dart';

class ProjectDetailPage extends StatelessWidget {
  const ProjectDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        ProjectDetailAppbar(),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 50.0),
                child: ProjectPieChart(),
              ),
              ProjectTaskTile(),
              ProjectTaskTile(),
              ProjectTaskTile(),
              ProjectTaskTile(),
              ProjectTaskTile(),
              ProjectTaskTile(),
            ],
          ),
        ),
        SliverFillRemaining(
          fillOverscroll: false,
          child: Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: Icon(JobTimerIcons.ok_circled2),
                label: Text('Finalizar projeto'),
              ),
            ),
          ),
        )
      ],
    ));
  }
}
