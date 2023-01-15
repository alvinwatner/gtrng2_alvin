part of 'list_pokemon_cubit.dart';

enum WishlistStatus{
  updated,
  standby,
}

class ListPokemonState extends Equatable {
  final RequestAPIStatus listPokemonStatus;
  final RequestAPIStatus detailPokemonStatus;
  final List<PokemonData>? listPokemonData;
  final DetailPokemonResponse? detailPokemonResponse;
  final bool isWishlist;
  final WishlistStatus wishlistStatus;

  const ListPokemonState({
    this.listPokemonStatus = RequestAPIStatus.initial,
    this.detailPokemonStatus = RequestAPIStatus.initial,
    this.listPokemonData,
    this.detailPokemonResponse,
    this.isWishlist = false,
    this.wishlistStatus = WishlistStatus.standby,
  });

  ListPokemonState copyWith({
    RequestAPIStatus? listPokemonStatus,
    RequestAPIStatus? detailPokemonStatus,
    List<PokemonData>? listPokemonData,
    DetailPokemonResponse? detailPokemonResponse,
    bool? isWishlist,
    WishlistStatus? wishlistStatus,
  }) {
    return ListPokemonState(
      listPokemonStatus: listPokemonStatus ?? this.listPokemonStatus,
      detailPokemonStatus: detailPokemonStatus ?? this.detailPokemonStatus,
      listPokemonData: listPokemonData ?? this.listPokemonData,
      detailPokemonResponse: detailPokemonResponse ?? this.detailPokemonResponse,
      isWishlist: isWishlist ?? this.isWishlist,
      wishlistStatus: wishlistStatus ?? this.wishlistStatus,
    );
  }

  @override
  List<dynamic> get props => [
        listPokemonStatus,
        detailPokemonStatus,
        listPokemonData,
        detailPokemonResponse,
        isWishlist,
        wishlistStatus,
      ];
}
