import 'package:flutter/material.dart';

class Singleton {
  static final Singleton _instance = Singleton._internal();
  factory Singleton() => _instance;
  Singleton._internal();

  List<CardItem> cards = [];
  bool isProcessing = false;
  List<int> flippedIndices = [];
}

class CardItem {
  final int id;
  final Color color;
  bool isFlipped;
  bool isFound;

  CardItem({
    required this.id,
    required this.color,
    this.isFlipped = false,
    this.isFound = false,
  });
}