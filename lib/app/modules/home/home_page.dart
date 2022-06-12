import 'package:asuka/asuka.dart';
import 'package:blocapp/app/core/database/database.dart';
import 'package:blocapp/app/entities/project_status.dart';
import 'package:blocapp/app/modules/home/controller/home_controller.dart';
import 'package:blocapp/app/modules/home/widgets/header_projects_menu.dart';
import 'package:blocapp/app/modules/home/widgets/project_tile.dart';
import 'package:blocapp/app/modules/login/controller/login_controller.dart';
import 'package:blocapp/app/services/auth/auth_service.dart';
import 'package:blocapp/app/view_models/project_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../entities/project.dart';

class HomePage extends StatelessWidget {
  final HomeController controller;
  const HomePage({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeController, HomeState>(
      bloc: controller,
      listener: (context, state) {
        if (state.status == HomeStatus.failure) {
          AsukaSnackbar.alert('Falha ao buscar o projeto').show();
        }
        // TODO: implement listener
      },
      child: Scaffold(
        drawer: Drawer(
            child: SafeArea(
                child: ListTile(
          title: Text('Sair'),
          onTap: () async {
            Modular.get<AuthService>().signOut();
          },
        ))),
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              const SliverAppBar(
                title: Text('Projetos'),
                expandedHeight: 100,
                toolbarHeight: 100,
                centerTitle: true,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(bottom: Radius.circular(15))),
              ),
              SliverPersistentHeader(
                delegate: HeaderProjectsMenu(controller: controller),
                pinned: true,
              ),
              BlocSelector<HomeController, HomeState, bool>(
                bloc: controller,
                selector: (state) {
                  return state.status == HomeStatus.loading;
                },
                builder: (context, showLoading) {
                  return SliverVisibility(
                    visible: showLoading,
                    sliver: const SliverToBoxAdapter(
                        child: SizedBox(
                      height: 50,
                      child: Center(child: CircularProgressIndicator.adaptive()),
                    )),
                  );
                },
              ),
              BlocSelector<HomeController, HomeState, List<ProjectModel>>(
                bloc: controller,
                selector: (state) {
                  return state.projects;
                },
                builder: (context, projects) {
                  return SliverList(
                      delegate: SliverChildListDelegate(projects
                          .map(
                            (project) => ProjectListTile(projectModel: project),
                          )
                          .toList()));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
