import 'package:flutter/material.dart';
import '../providers/pokemons.dart';
import '../screens/details_screen.dart';
import 'package:provider/provider.dart';
import '../models/pokemon.dart';

class ItemGrid extends StatelessWidget {
  final List<Pokemon> pokemons;
  final List<int> favoritePokemonIdList;
  final String tagPrefix;
  ItemGrid(this.pokemons, this.favoritePokemonIdList, this.tagPrefix);

  void _addToFavorites(BuildContext context, int pokemonId) async {
    Provider.of<Pokemons>(context, listen: false)
        .addPokemonToFavorites(pokemonId);
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.only(top: 7),
      itemCount: pokemons.length,
      itemBuilder: (ctx, index) => ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: GridTile(
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(DetailsScreen.routeName,
                  arguments: pokemons[index].id);
            },
            child: Hero(
              tag: '${tagPrefix}_${pokemons[index].id}',
              child: FadeInImage(
                placeholder: AssetImage('assets/images/whos_that_pokemon.png'),
                image: NetworkImage(pokemons[index].imageUrl),
                fit: BoxFit.fill,
              ),
            ),
          ),
          footer: GridTileBar(
            trailing: IconButton(
              icon: Icon(favoritePokemonIdList.contains(pokemons[index].id)
                  ? Icons.favorite
                  : Icons.favorite_border),
              color: Theme.of(context).accentColor,
              onPressed: () {
                _addToFavorites(
                  context,
                  pokemons[index].id,
                );
              },
            ),
            backgroundColor: Colors.black54,
            title: Text(
              pokemons[index].name,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}
