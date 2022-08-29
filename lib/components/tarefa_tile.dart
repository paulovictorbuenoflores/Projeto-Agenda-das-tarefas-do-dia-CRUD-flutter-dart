import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter_agenda/models/tarefa.dart';
import 'package:flutter_agenda/provider/tarefas.dart';
import 'package:flutter_agenda/routes/app_routes.dart';
import 'package:provider/provider.dart';

class TarefaTile extends StatelessWidget {
  final Tarefa? tarefa;
  const TarefaTile(this.tarefa);
  @override
  Widget build(BuildContext context) {
    final avatar = tarefa!.urlavatar == null || tarefa!.urlavatar.isEmpty
        ? CircleAvatar(child: Icon(Icons.person))
        : CircleAvatar(backgroundImage: NetworkImage(tarefa!.urlavatar));
    return ListTile(
      leading: avatar,
      title: Text(tarefa!.name),
      subtitle: Text(tarefa!.descricao),
      onTap: () {
        Navigator.of(context).pushNamed(
          AppRoutes.TarefaCompleta,
          arguments: tarefa,
        );
      },
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            //Icon(Icons.more_vert),

            IconButton(
              icon: Icon(Icons.edit),
              color: Colors.yellow,
              onPressed: () {
                Navigator.of(context).pushNamed(
                  AppRoutes.TarefaForm,
                  arguments: tarefa,
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.delete),
              color: Colors.red,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: Text('Excluir está Tarefa'),
                    content: Text('Tem Certeza?'),
                    actions: <Widget>[
                      FlatButton(
                        child: const Text('Não'),
                        onPressed: () => Navigator.of(context).pop(false),
                      ),
                      FlatButton(
                        child: const Text('Sim'),
                        onPressed: () => Navigator.of(context).pop(true),
                      ),
                    ],
                  ),
                ).then((confirmed) {
                  if (confirmed) {
                    Provider.of<TarefasProvider>(context, listen: false)
                        .remove(tarefa!);
                  }
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
