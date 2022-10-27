import 'package:flutter/material.dart';
import 'package:nosso_primeiro_projeto/data/task_dao.dart';

import 'difficulty.dart';

class Task extends StatefulWidget {
  final String nome;
  final String foto;
  final int dificuldade;

  Task(this.nome, this.foto, this.dificuldade, {Key? key}) : super(key: key);

  int nivel = 0;
  int dificultyCounter = 0;

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  bool assetOrNetwork() {
    if (widget.foto.contains('http')) {
      return false;
    }
    return true;
  }

  Color colorSet() {
    if (widget.dificultyCounter == 1) {
      return const Color.fromARGB(255, 39, 87, 219);
    } else if (widget.dificultyCounter == 2) {
      return const Color.fromARGB(217, 191, 137, 112);
    } else if (widget.dificultyCounter == 3) {
      return const Color.fromARGB(255, 130, 130, 130);
    } else if (widget.dificultyCounter >= 4) {
      return const Color.fromARGB(218, 115, 105, 12);
    }
    return Colors.blue;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4), color: colorSet()),
            height: 140,
          ),
          Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.white,
                ),
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: Colors.black26),
                      width: 80,
                      height: 100,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: assetOrNetwork()
                            ? Image.asset(
                                widget.foto,
                                fit: BoxFit.cover,
                              )
                            : Image.network(
                                widget.foto,
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                            width: 200,
                            child: Text(
                              widget.nome,
                              style: const TextStyle(
                                  fontSize: 24,
                                  overflow: TextOverflow.ellipsis),
                            )),
                        Difficulty(
                          dificultyLevel: widget.dificuldade,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 52,
                      width: 52,
                      child: ElevatedButton(
                          //onLongPress para deletar uma tarefa!
                          onLongPress: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    //novo Widget para confirmar se iremos deletar de fato
                                    title: Row(
                                      children: const [
                                        Text('Deletar'),
                                        Icon(Icons.delete_forever),
                                      ],
                                    ),
                                    content: const Text(
                                        'Tem certeza de que deseja deletar essa Tarefa?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Não'),
                                      ),
                                      TextButton(
                                        onPressed: () async {
                                          await TaskDao().delete(widget.nome);
                                          // print('Tarefa ${widget.nome} deletada');
                                          // ignore: use_build_context_synchronously
                                          Navigator.pop(
                                              context); // aqui não conseguimos forçar um setState a acontecer lá na tela inicial. Para resolver isso precisamos de um bom gerenciamento de estado.
                                        },
                                        child: const Text('Sim'),
                                      ),
                                    ],
                                  );
                                });
                          },
                          onPressed: () {
                            setState(() {
                              widget.nivel++;
                              if (((widget.nivel / widget.dificuldade) / 10) >=
                                  1) {
                                widget.dificultyCounter++;
                                widget.nivel = 0;
                              }
                            });

                            //print(nivel);
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: const [
                              Icon(Icons.arrow_drop_up),
                              Text(
                                'UP',
                                style: TextStyle(fontSize: 12),
                              )
                            ],
                          )),
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: SizedBox(
                      width: 200,
                      child: LinearProgressIndicator(
                        color: Colors.white,
                        value: (widget.dificuldade > 0)
                            ? (widget.nivel / widget.dificuldade) / 10
                            : 1,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Nivel: ${widget.nivel}',
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
