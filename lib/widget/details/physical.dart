import 'package:flutter/material.dart';
import 'package:pokemon_app/models/pokemon.dart';

class Physical extends StatelessWidget {
  final Pokemon pokemonDetails;
  Physical(this.pokemonDetails);

  String _getType(List<String> types) {
    String formattedTypes = '';
    for (String type in types) {
      formattedTypes += '$type\\';
    }
    if (formattedTypes.length > 0) {
      formattedTypes = formattedTypes.substring(0, formattedTypes.length - 1);
    }
    return formattedTypes;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(
                  color: Colors.blueGrey,
                  width: 1.0,
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  '${(pokemonDetails.height / 10)}m',
                  style: Theme.of(context).textTheme.headline6,
                ),
                Text(
                  "HEIGHT",
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ],
            ),
          ),
          flex: 2,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                _getType(pokemonDetails.types),
                style: Theme.of(context).textTheme.headline6,
              ),
            ],
          ),
          flex: 3,
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(
                  color: Colors.blueGrey,
                  width: 1.0,
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  '${(pokemonDetails.weight / 10)}Kg',
                  style: Theme.of(context).textTheme.headline6,
                ),
                Text(
                  "WEIGHT",
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ],
            ),
          ),
          flex: 2,
        ),
      ],
    );
  }
}
