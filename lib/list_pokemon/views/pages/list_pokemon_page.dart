import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gtrng2_alvin/list_pokemon/logics/cubit/list_pokemon_cubit.dart';
import 'package:gtrng2_alvin/list_pokemon/views/widgets/detail_pokemon_bottom_sheet.dart';
import 'package:gtrng2_alvin/service.dart';

class ListPokemonPage extends StatelessWidget {
  static const String routeName = 'list-pokemon';
  const ListPokemonPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: Image.network(
          'https://www.pngmart.com/files/2/Pokeball-PNG-Photos.png',
          width: 45,
          height: 45,
        ),
        title: Text(
          "POKEMON",
          style: Theme.of(context).textTheme.headline6?.copyWith(
                color: Colors.white,
              ),
        ),
      ),
      body: BlocBuilder<ListPokemonCubit, ListPokemonState>(
        builder: (context, state) {
          switch (state.listPokemonStatus) {
            case RequestAPIStatus.initial:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case RequestAPIStatus.success:
              return ListView(
                  children: state.listPokemonData!
                      .map(
                        (pokemonData) => InkWell(
                          onTap: () {
                            context
                                .read<ListPokemonCubit>()
                                .getDetailPokemonData(pokemonData.name);
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(10.0)),
                              ),
                              builder: (context) {
                                return const DetailPokemonBottomSheet();
                              },
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.all(15.0),
                            padding: const EdgeInsets.all(22.0),
                            decoration: BoxDecoration(
                              color: Colors.orange.shade700,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(8.0)),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.green,
                                  blurRadius: 15,
                                  offset: Offset(0, 5),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                pokemonData.name,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    ?.copyWith(
                                      color: Colors.grey.shade200,
                                    ),
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList());
            default:
              return const Center(
                child: CircularProgressIndicator(),
              );
          }
        },
      ),
    );
  }
}
