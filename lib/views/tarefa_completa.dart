import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_agenda/models/tarefa.dart';
import 'package:flutter_agenda/provider/tarefas.dart';
import 'package:provider/provider.dart';

class TarefaCompleta extends StatefulWidget {
  const TarefaCompleta({Key? key}) : super(key: key);

  @override
  State<TarefaCompleta> createState() => _TarefaCompletaState();
}

class _TarefaCompletaState extends State<TarefaCompleta> {
  final _form = GlobalKey<FormState>();
  final Map<String, String> _formData = {};

  void _loadFormData(Tarefa tarefa) {
    _formData['id'] = tarefa.id!;
    _formData['name'] = tarefa.name;
    _formData['descricao'] = tarefa.descricao;
    _formData['data'] = tarefa.data;
    _formData['urlavatar'] = tarefa.urlavatar;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final tarefa = ModalRoute.of(context)?.settings.arguments as Tarefa;
    _loadFormData(tarefa);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tarefa'),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: _form,
          child: Column(children: [
            TextFormField(
              enabled: false,
              initialValue: _formData['name'],
              decoration: const InputDecoration(labelText: 'Nome'),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Informe Nome da Trefa';
                }
                return null;
              },
              onSaved: (value) => _formData['name'] = value!,
            ),
            TextFormField(
              enabled: false,
              initialValue: _formData['descricao'],
              decoration: const InputDecoration(labelText: 'Descrição'),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Informe a descrição';
                }
                return null;
              },
              onSaved: (value) => _formData['descricao'] = value!,
            ),
            TextFormField(
              enabled: false,
              initialValue: _formData['data'],
              decoration: const InputDecoration(labelText: 'Data'),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Informe a data';
                }
              },
            ),
            TextFormField(
              enabled: false,
              initialValue: _formData['urlavatar'],
              decoration: const InputDecoration(labelText: 'avatar'),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'InformeURL';
                }
              },
            ),
          ]),
        ),
      ),
    );
  }
}
