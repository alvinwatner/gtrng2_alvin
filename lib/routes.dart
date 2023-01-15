import 'package:flutter/material.dart';
import 'package:gtrng2_alvin/detail_pokemon/views/detail_pokemon_page.dart';
import 'package:gtrng2_alvin/list_pokemon/views/pages/list_pokemon_page.dart';

final Map<String, Widget> routes = {
  ListPokemonPage.routeName : const ListPokemonPage(),
  DetailPokemonPage.routeName: const DetailPokemonPage(),
};