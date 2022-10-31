import 'package:nosso_primeiro_projeto/data/database.dart';
import 'package:sqflite/sqflite.dart';

import '../components/tesk.dart';

class TaskDao {
  static const String tableSql = 'CREATE TABLE $_tablename('
      '$_name TEXT, '
      '$_difficulty INTEGER,'
      '$_image TEXT)';

  static const String _tablename = 'taskTable';
  static const String _name = 'name';
  static const String _difficulty = 'dificuldade';
  static const String _image = 'image';

  save(Task tarefa) async {
    print('Iniciando o save:');
    final Database bancoDeDados = await getDatabase();
    var itemExists = await find(tarefa.nome);
    Map<String, dynamic> taskMap = toMap(tarefa);
    if (itemExists.isEmpty) {
      print('a tarefa não Existia.');
      return await bancoDeDados.insert(_tablename, taskMap);
    } else {
      print('A Tarefa já existia');
      return await bancoDeDados.update(_tablename, taskMap,
          where: '$_name = ?', whereArgs: [tarefa.nome]);
    }
  }

  Map<String, dynamic> toMap(Task tarefa) {
    print('Convertendo Tarefa em Map: ');
    final Map<String, dynamic> mapaDetarefas = Map();
    mapaDetarefas[_name] = tarefa.nome;
    mapaDetarefas[_difficulty] = tarefa.dificuldade;
    mapaDetarefas[_image] = tarefa.foto;
    print('Mapa de Tarefas: $mapaDetarefas');
    return mapaDetarefas;
  }

  Future<List<Task>> findAll() async {
    print('Acessando o indAll:');
    final Database bancoDeDados = await getDatabase();
    final List<Map<String, dynamic>> result =
        await bancoDeDados.query(_tablename);
    print('Procurado dados no banco de dados... encontrado: $result');
    return toList(result);
  }

  List<Task> toList(List<Map<String, dynamic>> mapaDeTarefas) {
    print('Convertendo to List');
    final List<Task> tarefas = [];
    for (Map<String, dynamic> linha in mapaDeTarefas) {
      final Task tarefa = Task(linha[_name], linha[_image], linha[_difficulty]);
      tarefas.add(tarefa);
    }
    print('Lista de tarefas $tarefas');
    return tarefas;
  }

  Future<List<Task>> find(String nomeDaTarefa) async {
    print('Acessando find');
    final Database bancoDeDados = await getDatabase();
    final List<Map<String, dynamic>> result = await bancoDeDados.query(
      _tablename,
      where: '$_name = ?',
      whereArgs: [nomeDaTarefa],
    );
    print('Tarefa Encontrada: ${toList(result)}');
    return toList(result);
  }

  delete(String nomeDaTarefa) async {
    print('Deletando tarefa: $nomeDaTarefa');
    final Database bancoDeDados = await getDatabase();
    return bancoDeDados.delete(
      _tablename,
      where: '$_name = ?',
      whereArgs: [nomeDaTarefa],
    );
  }
}
