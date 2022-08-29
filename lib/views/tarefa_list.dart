import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_agenda/components/tarefa_tile.dart';
import 'package:flutter_agenda/data/dummy_agenda.dart';
import 'package:flutter_agenda/models/tarefa.dart';
import 'package:flutter_agenda/provider/tarefas.dart';
import 'package:flutter_agenda/routes/app_routes.dart';
import 'package:provider/provider.dart';

class TarefaList extends StatelessWidget {
  const TarefaList({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final TarefasProvider tarefasProvider = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minhas Tarefas do dia'),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            alignment: Alignment.centerLeft,
            icon: Icon(Icons.more_vert),
            iconSize: 36.3,
            onPressed: () {},
          ),
          IconButton(
            alignment: Alignment.centerLeft,
            color: Colors.red,
            //icon: Icon(Icons.attachment_outlined),
            icon: Icon(Icons.add),
            iconSize: 36.3,
            onPressed: () {
              Navigator.of(context).pushNamed(
                AppRoutes.TarefaForm,
                arguments: const Tarefa(
                  id: '',
                  name: '',
                  descricao: '',
                  data: '',
                  urlavatar: '',
                ),
              );
            },
          ),
          //Text('Nova Tarefa'),
        ],
      ),
      body: ListView.builder(
        itemCount: tarefasProvider.count,
        //itemBuilder: (ctx, i) => Text(tarefas.values.elementAt(i).name),
        itemBuilder: (ctx, i) => TarefaTile(tarefasProvider.byIndex(i)),
      ),
    );
  }
}
