import 'dart:math';

import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_agenda/data/dummy_agenda.dart';
import 'package:flutter_agenda/models/tarefa.dart';

//implementa o bserver changeNotifier
//sempre que ouver uma mudanca vamos notificar os listener e a interface sera atualizada
class TarefasProvider with ChangeNotifier {
  final Map<String, Tarefa> _items = {...DUMMY_TAREFAS};

  List<Tarefa> get all {
    return [..._items.values]; //um clone
  }

  int get count {
    return _items.length;
  }

  Tarefa byIndex(int i) {
    return _items.values.elementAt(i);
  }

  void put(Tarefa tarefa) {
    //atualizar
    if (tarefa.id != null &&
        tarefa.id!.trim().isNotEmpty &&
        _items.containsKey(tarefa.id)) {
      _items.update(
        tarefa.id!,
        (_) => Tarefa(
          name: tarefa.name,
          descricao: tarefa.descricao,
          data: tarefa.data,
          urlavatar: tarefa.urlavatar,
        ),
      );
    } else {
      //adicionar
      final id = Random().nextDouble().toString();
      _items.putIfAbsent(
        id,
        () => Tarefa(
          id: id,
          name: tarefa.name,
          descricao: tarefa.descricao,
          data: tarefa.data,
          urlavatar: tarefa.urlavatar,
        ),
      );
    }
    notifyListeners();
  }

  void remove(Tarefa tarefa) {
    if (tarefa != null && tarefa.id != null) {
      _items.remove(tarefa.id);
    }
    notifyListeners();
  }
}
