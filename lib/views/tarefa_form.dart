import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_agenda/models/tarefa.dart';
import 'package:flutter_agenda/provider/tarefas.dart';
import 'package:provider/provider.dart';

class TarefaForm extends StatefulWidget {
  const TarefaForm({Key? key}) : super(key: key);

  @override
  State<TarefaForm> createState() => _TarefaFormState();
}

class _TarefaFormState extends State<TarefaForm> {
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
        title: const Text('Alterar/Criar'),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              final isValid = _form.currentState!.validate();

              if (isValid) {
                _form.currentState!.save();
                Provider.of<TarefasProvider>(context, listen: false).put(
                  Tarefa(
                    id: _formData['id'],
                    name: _formData['name']!,
                    descricao: _formData['descricao']!,
                    data: _formData['data']!,
                    urlavatar: _formData['urlavatar']!,
                  ),
                );
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: _form,
          child: Column(children: [
            TextFormField(
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
              initialValue: _formData['data'],
              decoration: const InputDecoration(labelText: 'Data'),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Informe a data';
                }
              },
            ),
            TextFormField(
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
