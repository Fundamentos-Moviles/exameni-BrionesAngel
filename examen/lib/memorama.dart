import 'package:examen/constantes.dart' as cons;
import 'package:examen/utils/singleton.dart';
import 'package:flutter/material.dart';

class MemoramaGame extends StatefulWidget {
  const MemoramaGame({super.key});

  @override
  State<MemoramaGame> createState() => _MemoramaGameState();
}

class _MemoramaGameState extends State<MemoramaGame> {
  Singleton singleton = Singleton();
  final int totalCards = 20;
  final int uniqueColors = 10;
  final Color inactiveColor = cons.gris;
  final String myName = "Briones Jacobo Angel Alejandro";

  late List<Color> cardColors;
  late List<bool> isFlipped;
  late List<bool> isFound;
  List<int> flippedIndices = [];

  @override
  void initState() {
    super.initState();
    _initializeGame();
  }

  void _initializeGame() {
    final List<Color> colors = List.generate(
      uniqueColors,
      (index) => cons.gameColors[index],
    );

    final List<Color> allColors = [...colors, ...colors];
    allColors.shuffle();

    cardColors = allColors;
    isFlipped = List.generate(totalCards, (index) => false);
    isFound = List.generate(totalCards, (index) => false);
    flippedIndices.clear();
  }

  void _onCardTap(int index) {
    if (isFound[index] || isFlipped[index] || flippedIndices.length == 2) {
      return;
    }

    setState(() {
      isFlipped[index] = true;
      flippedIndices.add(index);
    });

    if (flippedIndices.length == 2) {
      final int card1Index = flippedIndices[0];
      final int card2Index = flippedIndices[1];

      if (cardColors[card1Index] == cardColors[card2Index]) {
        setState(() {
          isFound[card1Index] = true;
          isFound[card2Index] = true;
        });
        flippedIndices.clear();
        _checkWinCondition();
      } else {
        Future.delayed(const Duration(milliseconds: 700), () {
          setState(() {
            isFlipped[card1Index] = false;
            isFlipped[card2Index] = false;
            flippedIndices.clear();
          });
        });
      }
    }
  }

  void _checkWinCondition() {
    if (isFound.every((found) => found)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Ganaste! Felicidades!"),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  void _resetGame() {
    setState(() {
      _initializeGame();
    });
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
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    decoration: BoxDecoration(
                      color: isFlipped[index] || isFound[index]
                          ? cardColors[index]
                          : inactiveColor,
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