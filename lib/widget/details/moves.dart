import 'package:flutter/material.dart';
import 'package:pokemon_app/models/pokemon.dart';

class MovesWidget extends StatelessWidget {
  final Pokemon pokemonDetails;
  MovesWidget(this.pokemonDetails);

  String _getMoves(List<String> moves) {
    String formattedMoves = '';
    for (String move in moves) {
      formattedMoves += '$move | ';
    }
    if (formattedMoves.length > 0) {
      formattedMoves = formattedMoves.substring(0, formattedMoves.length - 2);
    }
    return formattedMoves;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Moves', style: Theme.of(context).textTheme.headline5),
        Text(
          _getMoves(pokemonDetails.moves),
          style: Theme.of(context).textTheme.headline4,
        ),
      ],
    );
  }
}
