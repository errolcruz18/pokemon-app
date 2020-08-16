import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

import 'dart:convert';
import '../models/pokemon.dart';

class Pokemons with ChangeNotifier {
  final _apiUrl = 'https://pokeapi.co/api/v2/type/3/';
  List<Pokemon> _pokemons = [];
  List<int> _favoritePokemonIdList = [];
  String _prefFavoriteKey = 'favoritesList';

  List<Pokemon> get pokemons {
    return _pokemons;
  }

  List<Pokemon> get favoritePokemons {
    return _pokemons
        .where((pokemon) => _favoritePokemonIdList.contains(pokemon.id))
        .toList();
    ;
  }

  List<int> get favoritePokemonIdList {
    return _favoritePokemonIdList;
  }

  Future<List<int>> getFavoritePokemonIdList() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<int> listOfFavoritePokemonIds = [];
    if (prefs.containsKey(_prefFavoriteKey)) {
      List<String> mList =
          (prefs.getStringList(_prefFavoriteKey) ?? List<String>());
      listOfFavoritePokemonIds = mList.map((i) => int.parse(i)).toList();
    }
    _favoritePokemonIdList = listOfFavoritePokemonIds;
    return listOfFavoritePokemonIds;
  }

  Future<void> addPokemonToFavorites(int pokemonId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<int> listOfFavoritePokemonIds = [];
    if (prefs.containsKey(_prefFavoriteKey)) {
      List<String> mList =
          (prefs.getStringList(_prefFavoriteKey) ?? List<String>());
      listOfFavoritePokemonIds = mList.map((i) => int.parse(i)).toList();
    }

    if (listOfFavoritePokemonIds.contains(pokemonId)) {
      listOfFavoritePokemonIds.remove(pokemonId);
    } else {
      listOfFavoritePokemonIds.add(pokemonId);
    }
    _favoritePokemonIdList = listOfFavoritePokemonIds;
    List<String> stringsList =
        listOfFavoritePokemonIds.map((i) => i.toString()).toList();
    prefs.setStringList(_prefFavoriteKey, stringsList);
    notifyListeners();
  }

  Pokemon findById(int id) {
    return _pokemons.firstWhere((pokemon) => pokemon.id == id);
  }

  Future<void> fetchAndSetPokemons() async {
    _pokemons = [];
    final response = await http.get(_apiUrl);

    final jsonResponse = json.decode(response.body) as Map<String, dynamic>;

    for (var data in jsonResponse['pokemon']) {
      var detailsApiUrl = data['pokemon']['url'];
      //print(json.decode(data));
      //print(data['url']);
      var details = await http.get(detailsApiUrl);
      var pokemonDetails = json.decode(details.body) as Map<String, dynamic>;
      List<String> types = [];
      List<Stat> stats = [];
      List<String> moves = [];
      for (var type in pokemonDetails['types']) {
        types.add(type['type']['name']);
      }
      for (var move in pokemonDetails['moves']) {
        moves.add(move['move']['name']);
      }
      for (var stat in pokemonDetails['stats']) {
        Stat newStatObj = new Stat(
          name: stat['stat']['name'],
          effort: stat['effort'],
          baseStat: stat['base_stat'],
        );
        stats.add(newStatObj);
      }
      Pokemon newPokemonObj = new Pokemon(
        id: pokemonDetails['id'],
        name:
            '${pokemonDetails['name'][0].toUpperCase()}${pokemonDetails['name'].substring(1)}',
        imageUrl: pokemonDetails['sprites']['other']['official-artwork']
            ['front_default'],
        height: pokemonDetails['height'],
        weight: pokemonDetails['weight'],
        types: types,
        stats: stats,
        moves: moves,
      );

      _pokemons.add(newPokemonObj);

      notifyListeners();
    }
  }
}
