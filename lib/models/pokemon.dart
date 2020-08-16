import 'package:flutter/material.dart';

class Stat {
  final String name;
  final int effort;
  final int baseStat;
  Stat({
    @required this.name,
    @required this.effort,
    @required this.baseStat,
  });
}

class Pokemon {
  final int id;
  final String imageUrl;
  final String name;
  final int weight;
  final int height;
  final List<String> types;
  final List<String> moves;
  final List<Stat> stats;

  Pokemon({
    @required this.id,
    @required this.name,
    @required this.imageUrl,
    @required this.weight,
    @required this.height,
    @required this.types,
    @required this.moves,
    @required this.stats,
  });
}
