import 'package:flutter/material.dart';
import '../providers/pokemons.dart';
import '../widget/item_grid.dart';
import 'package:provider/provider.dart';

class FavoritesScreen extends StatefulWidget {
  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    final pokemonProvider = Provider.of<Pokemons>(context);
    final pokemons = pokemonProvider.favoritePokemons;
    List<int> favoritePokemonIdList =
        Provider.of<Pokemons>(context).favoritePokemonIdList;
    return pokemons.length > 0
        ? ItemGrid(pokemons, favoritePokemonIdList, 'fave')
        : Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
  }
}
