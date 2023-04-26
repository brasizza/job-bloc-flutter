import 'package:blocapp/app/app_module.dart';
import 'package:blocapp/app/app_widget.dart';
import 'package:blocapp/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(ModularApp(
    module: AppModule(),
    child: const AppWidget(),
  ));
}
