import 'package:flutter/material.dart';
import 'package:flutter_agenda/provider/tarefas.dart';
import 'package:flutter_agenda/routes/app_routes.dart';
import 'package:flutter_agenda/views/tarefa_completa.dart';
import 'package:flutter_agenda/views/tarefa_form.dart';
import 'package:flutter_agenda/views/tarefa_list.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => TarefasProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Agenda_demo',
        theme: ThemeData(
          primarySwatch: Colors.cyan,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        routes: {
          AppRoutes.home: (_) => const TarefaList(),
          AppRoutes.TarefaForm: (_) => const TarefaForm(),
          AppRoutes.TarefaCompleta: (_) => const TarefaCompleta(),
        },
      ),
    );
  }
}
