import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gtrng2_alvin/list_pokemon/models/detail_pokemon_response.dart';
import 'package:gtrng2_alvin/list_pokemon/models/list_pokemon_response.dart';
import 'package:gtrng2_alvin/service.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'list_pokemon_state.dart';

class ListPokemonCubit extends Cubit<ListPokemonState> {
  ListPokemonCubit() : super(const ListPokemonState());

  void getInitWishlistValue(String pokemonName) async {
    final prefs = await SharedPreferences.getInstance();
    final bool? isWishlist = prefs.getBool(pokemonName);
    if (isWishlist == null) {
      // set default wislist value to false
      await prefs.setBool(pokemonName, false);
      emit(
        state.copyWith(
          isWishlist: false,
          wishlistStatus: WishlistStatus.updated,
        ),
      );
    } else {
      // retrieve wishlist value from disk
      emit(
        state.copyWith(
          isWishlist: isWishlist,
          wishlistStatus: WishlistStatus.updated,
        ),
      );
    }
  }

  void updateWishlist(String pokemonName) async {
    final prefs = await SharedPreferences.getInstance();
    final bool? isWishlist = prefs.getBool(pokemonName);
    final bool updatedIsWishlist = !isWishlist!;
    await prefs.setBool(pokemonName, updatedIsWishlist);
    emit(
      state.copyWith(
        isWishlist: updatedIsWishlist,
        wishlistStatus: WishlistStatus.updated,
      ),
    );
    emit(
      state.copyWith(
        wishlistStatus: WishlistStatus.standby,
      ),
    );
  }

  void getListPokemonData() async {
    emit(state.copyWith(listPokemonStatus: RequestAPIStatus.initial));

    try {
      final Map<String, dynamic> result = await getData(
        url: 'https://pokeapi.co/api/v2/pokemon/',
        decode: true,
      );

      final ListPokemonResponse listPokemonResponse =
          listPokemonResponseFromJson(json.encode(result));

      emit(state.copyWith(
        listPokemonStatus: RequestAPIStatus.success,
        listPokemonData: listPokemonResponse.listPokemonData,
      ));
    } catch (e) {
      emit(state.copyWith(listPokemonStatus: RequestAPIStatus.fail));
    }
  }

  void getDetailPokemonData(String pokemonName) async {
    emit(state.copyWith(detailPokemonStatus: RequestAPIStatus.initial));

    try {
      final Map<String, dynamic> result = await getData(
        url: 'https://pokeapi.co/api/v2/pokemon/$pokemonName',
        decode: true,
      );

      final DetailPokemonResponse detailPokemonResponse =
          detailPokemonResponseFromJson(json.encode(result));

      emit(state.copyWith(
        detailPokemonStatus: RequestAPIStatus.success,
        detailPokemonResponse: detailPokemonResponse,
      ));
    } catch (e) {
      emit(state.copyWith(detailPokemonStatus: RequestAPIStatus.fail));
    }
  }
}
