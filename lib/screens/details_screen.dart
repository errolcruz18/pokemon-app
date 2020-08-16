import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/pokemons.dart';
import '../widget/details/moves.dart';
import '../widget/details/physical.dart';
import '../widget/details/stats.dart';

class DetailsScreen extends StatefulWidget {
  static const routeName = '/pokemon-detail';

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final pokemonId = ModalRoute.of(context).settings.arguments as int;
    final pokemonDetails = Provider.of<Pokemons>(
      context,
      listen: false,
    ).findById(pokemonId);
    List<int> favoritePokemonIdList =
        Provider.of<Pokemons>(context).favoritePokemonIdList;
    void _addToFavorites() async {
      Provider.of<Pokemons>(context, listen: false)
          .addPokemonToFavorites(pokemonId);
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(pokemonDetails.name),
              background: Hero(
                tag: pokemonDetails.id,
                child: Image.network(
                  pokemonDetails.imageUrl,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              SizedBox(height: 10),
              Container(
                width: deviceSize.width * .7,
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Physical(pokemonDetails),
                    Divider(
                      height: 30,
                      color: Colors.blueGrey,
                    ),
                    StatsWidget(pokemonDetails),
                    Divider(
                      height: 30,
                      color: Colors.blueGrey,
                    ),
                    MovesWidget(pokemonDetails),
                  ],
                ),
              )
            ]),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addToFavorites();
        },
        child: Icon(
            favoritePokemonIdList.contains(pokemonId)
                ? Icons.favorite
                : Icons.favorite_border,
            color: Colors.white),
        backgroundColor: Colors.amberAccent,
      ),
    );
  }
}
