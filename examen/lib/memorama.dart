import 'package:examen/constantes.dart' as cons;
import 'package:flutter/material.dart';

class MemoramaGame extends StatefulWidget {
  const MemoramaGame({super.key});

  @override
  State<MemoramaGame> createState() => _MemoramaGameState();
}

class _MemoramaGameState extends State<MemoramaGame> {
  final int totalCards = 20;
  final int uniqueColors = 10;
  final Color inactiveColor = cons.gris;
  final String myName = "Briones Jacobo Angel Alejandro";

  @override
  void initState() {
    super.initState();
  }

  void _onCardTap(int index) {
  }

  void _resetGame() {
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Memorama'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Text(
              myName,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(10.0),
              itemCount: totalCards,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
              ),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () => _onCardTap(index),
                  child: Container(
                    decoration: BoxDecoration(
                      color: inactiveColor, 
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: _resetGame,
              child: const Text('REINICIAR'),
            ),
          ),
        ],
      ),
    );
  }
}