import 'package:asuka/snackbars/asuka_snack_bar.dart';
import 'package:blocapp/app/core/ui/button_with_loader.dart';
import 'package:blocapp/app/modules/project/task/controller/task_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:validatorless/validatorless.dart';

class TaskPage extends StatefulWidget {
  final TaskController controller;
  const TaskPage({Key? key, required this.controller}) : super(key: key);

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  final _formKey = GlobalKey<FormState>();

  final _nameEC = TextEditingController();
  final _durationEC = TextEditingController();
  @override
  void dispose() {
    super.dispose();

    _nameEC.dispose();

    _durationEC.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TaskController, TaskStatus>(
      bloc: widget.controller,
      listener: (context, state) {
        if (state == TaskStatus.success) {
          Navigator.pop(context);
        } else if (state == TaskStatus.failure) {
          AsukaSnackbar.alert('Erro ao salvar task').show();
        } else if (state == TaskStatus.hourExceed) {
          AsukaSnackbar.alert('As horas preenchidas excedem a estimativa do projeto!').show();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            'Criar nova task',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black),
          elevation: 0,
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextFormField(
                  controller: _nameEC,
                  decoration: const InputDecoration(
                    label: Text(
                      'Nome da task',
                    ),
                  ),
                  validator: Validatorless.required('Nome obrigatório'),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: _durationEC,
                  decoration: const InputDecoration(
                    label: Text(
                      'Duração task',
                    ),
                  ),
                  validator: Validatorless.multiple([
                    Validatorless.required('Duração obrigatória'),
                    Validatorless.number('Somente números'),
                  ]),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 49,
                  child: ButtonWithLoader<TaskController, TaskStatus>(
                    bloc: widget.controller,
                    label: 'Salvar',
                    selector: (state) => state == TaskStatus.loading,
                    onPressed: () {
                      final formValid = _formKey.currentState?.validate() ?? false;
                      if (formValid) {
                        widget.controller.register(_nameEC.text, int.parse(_durationEC.text));
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
