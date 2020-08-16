import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/pokemons.dart';
import '../widget/item_grid.dart';

class ListScreen extends StatefulWidget {
  var _isInit = true;
  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  List<int> favoritePokemonIdList = [];

  @override
  void didChangeDependencies() async {
    if (widget._isInit) {
      Provider.of<Pokemons>(context).fetchAndSetPokemons();
      favoritePokemonIdList =
          await Provider.of<Pokemons>(context).getFavoritePokemonIdList();
    }
    widget._isInit = false;
    super.didChangeDependencies();
  }

  Future<void> _refreshList(BuildContext context) async {
    await Provider.of<Pokemons>(context, listen: false).fetchAndSetPokemons();
  }

  @override
  Widget build(BuildContext context) {
    final pokemonProvider = Provider.of<Pokemons>(context);
    final pokemons = pokemonProvider.pokemons;
    favoritePokemonIdList =
        Provider.of<Pokemons>(context).favoritePokemonIdList;
    return RefreshIndicator(
      onRefresh: () => _refreshList(context),
      child: pokemons.length > 0
          ? ItemGrid(pokemons, favoritePokemonIdList, 'all')
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
