
import 'package:flutter/material.dart';
import 'package:nosso_primeiro_projeto/components/tesk.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({Key? key}) : super(key: key);

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  bool opacidade = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        title: const Text('Acompanhamento de Tarefas'),
      ),
      body: AnimatedOpacity(
        duration: const Duration(microseconds: 800),
        opacity: opacidade ? 1 : 0,
        child: ListView(
          children: const [
            Task(
                'Aprender Flutter',
                'assets/images/dash.png',
                3),
            Task(
                'Andar de Bicicleta',
                'assets/images/bicicleta.jpeg',
                2),
            Task(
                'Ler',
                'assets/images/biblia.jpg',
                5),
            Task(
                'Jogar',
                'assets/images/xadrez.jpg',
                2),
            Task(
                'Caminhada',
                'assets/images/caminhada.jpeg',
                3),
            Task(
                'Esporte',
                'assets/images/sport.png',
                3),
            SizedBox(height: 80,)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            opacidade = !opacidade;
          });
        },
        child: const Icon(Icons.remove_red_eye, color: Colors.white,),
      ),
    );
  }
}