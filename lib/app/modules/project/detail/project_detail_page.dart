import 'package:asuka/asuka.dart';
import 'package:blocapp/app/core/ui/job_timer_icons_icons.dart';
import 'package:blocapp/app/entities/project_status.dart';
import 'package:blocapp/app/modules/project/detail/controller/project_detail_controller.dart';
import 'package:blocapp/app/modules/project/detail/widgets/project_detail_appbar.dart';
import 'package:blocapp/app/modules/project/detail/widgets/project_pie_chart.dart';
import 'package:blocapp/app/modules/project/detail/widgets/project_task_tile.dart';
import 'package:blocapp/app/view_models/project_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProjectDetailPage extends StatelessWidget {
  const ProjectDetailPage({required this.controller, Key? key}) : super(key: key);

  final ProjectDetailController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<ProjectDetailController, ProjectDetailState>(
      bloc: controller,
      listener: (context, state) {
        if (state.status == ProjectDetailStatus.failure) {
          return AsukaSnackbar.alert('Erro interno').show();
        }
        // TODO: implement listener
      },
      builder: (context, state) {
        final ProjectModel = state.projectModel;

        switch (state.status) {
          case ProjectDetailStatus.initial:
            return const Center(
              child: Text('Carregando projeto'),
            );
          case ProjectDetailStatus.loading:
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          case ProjectDetailStatus.complete:
            return _buildProjectDetail(context, ProjectModel!);

          case ProjectDetailStatus.failure:
            if (state.projectModel != null) {
              return _buildProjectDetail(context, ProjectModel!);
            } else {
              return const Text("Erro ao carregar o projeto");
            }
        }
      },
    ));
  }

  CustomScrollView _buildProjectDetail(BuildContext context, ProjectModel projectModel) {
    final totalTasks = projectModel.task.fold<int>(0, ((totalValue, task) {
      return totalValue += task.duration;
    }));
    return CustomScrollView(
      slivers: [
        ProjectDetailAppbar(
          projectModel: projectModel,
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 50.0),
                child: ProjectPieChart(projectEstimate: projectModel.estimate, totalTask: totalTasks),
              ),
              ...projectModel.task
                  .map(
                    (task) => ProjectTaskTile(task: task),
                  )
                  .toList(),
            ],
          ),
        ),
        SliverFillRemaining(
          fillOverscroll: false,
          child: Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Visibility(
                visible: projectModel.status != ProjectStatus.finalizado,
                replacement: const Text('Projeto finalizada!'),
                child: ElevatedButton.icon(
                  onPressed: () async {
                    controller.finishProject();
                  },
                  icon: const Icon(JobTimerIcons.ok_circled2),
                  label: const Text('Finalizar projeto'),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
