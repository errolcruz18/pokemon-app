import 'package:flutter/material.dart';
import 'package:pokemon_app/models/pokemon.dart';

class StatsWidget extends StatelessWidget {
  final Pokemon pokemonDetails;
  StatsWidget(this.pokemonDetails);
  Widget _getStats(List<Stat> stats, BuildContext context) {
    List<Widget> widgets = new List<Widget>();
    widgets.add(
      Text('STATS', style: Theme.of(context).textTheme.headline5),
    );
    for (Stat stat in stats) {
      widgets.add(
        Row(
          children: <Widget>[
            Expanded(
              child: Text(
                stat.name,
                style: Theme.of(context).textTheme.headline4,
              ),
              flex: 1,
            ),
            SizedBox(
              height: 5,
            ),
            Expanded(
              child: Text(
                ' : ${stat.baseStat}',
                style: Theme.of(context).textTheme.headline4,
              ),
              flex: 2,
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgets,
    );
  }

  @override
  Widget build(BuildContext context) {
    return _getStats(pokemonDetails.stats, context);
  }
}
