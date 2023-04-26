import 'package:asuka/asuka.dart';
import 'package:blocapp/app/core/ui/button_with_loader.dart';
import 'package:blocapp/app/modules/project/register/controller/project_register_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:validatorless/validatorless.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key, required this.controller}) : super(key: key);

  final ProjectRegisterController controller;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameEC = TextEditingController();
  final _estimateEC = TextEditingController();

  @override
  void dispose() {
    _nameEC.dispose();
    _estimateEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProjectRegisterController, ProjectRegisterStatus>(
      bloc: widget.controller,
      listener: (context, state) {
        switch (state) {
          case ProjectRegisterStatus.success:
            Navigator.pop(context);
            break;
          case ProjectRegisterStatus.failure:
            AsukaSnackbar.alert('Erro ao cadastrar projeto').show();
            break;

          default:
            break;
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            'Criar novo projeto',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextFormField(
                    controller: _nameEC,
                    validator: Validatorless.required('Nome Obrigatorio'),
                    decoration: const InputDecoration(label: Text("Nome do projeto")),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _estimateEC,
                    keyboardType: TextInputType.number,
                    validator: Validatorless.multiple([Validatorless.required('Estimativa obrigatória'), Validatorless.number('Permitido somente número')]),
                    decoration: const InputDecoration(label: Text("Estimativa de horas")),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // BlocSelector<ProjectRegisterController, ProjectRegisterStatus, bool>(
                  //   bloc: widget.controller,
                  //   selector: (state) {
                  //     return state == ProjectRegisterStatus.loading;
                  //   },
                  //   builder: (context, showLoading) {
                  //     return Visibility(
                  //       visible: showLoading,
                  //       child: Center(
                  //         child: CircularProgressIndicator.adaptive(),
                  //       ),
                  //     );
                  //   },
                  // ),
                  SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 49,
                      child: ButtonWithLoader<ProjectRegisterController, ProjectRegisterStatus>(
                        selector: ((state) => state == ProjectRegisterStatus.loading),
                        bloc: widget.controller,
                        onPressed: () async {
                          final formValid = _formKey.currentState?.validate() ?? false;
                          if (formValid) {
                            final name = _nameEC.text;
                            final estimate = int.parse(_estimateEC.text);

                            await widget.controller.register(name, estimate);
                          }
                        },
                        label: 'Salvar',
                      )
                      // ElevatedButton(
                      //   onPressed: () async {
                      //     final formValid = _formKey.currentState?.validate() ?? false;
                      //     if (formValid) {
                      //       final name = _nameEC.text;
                      //       final estimate = int.parse(_estimateEC.text);

                      //       await widget.controller.register(name, estimate);
                      //     }
                      //   },
                      //   child: const Text('Salvar'),
                      // ),
                      ),
                ],
              ),
            )),
      ),
    );
  }
}
