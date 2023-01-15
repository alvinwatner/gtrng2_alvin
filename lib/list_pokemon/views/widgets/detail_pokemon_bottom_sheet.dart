import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gtrng2_alvin/detail_pokemon/views/detail_pokemon_page.dart';
import 'package:gtrng2_alvin/list_pokemon/logics/cubit/list_pokemon_cubit.dart';
import 'package:gtrng2_alvin/service.dart';

class DetailPokemonBottomSheet extends StatelessWidget {
  const DetailPokemonBottomSheet({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      height: 300,
      child: BlocBuilder<ListPokemonCubit, ListPokemonState>(
        builder: (context, state) {
          switch (state.detailPokemonStatus) {
            case RequestAPIStatus.initial:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case RequestAPIStatus.fail:
              return const Center(
                child: Text("An error has occured!"),
              );
            default:
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.12,
                      child: Divider(
                        thickness: 3,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.network(
                        state.detailPokemonResponse!.sprites.other!.dreamWorld
                            .frontDefault,
                        height: 100,
                      ),
                      Text(
                        state.detailPokemonResponse?.name ?? "",
                        style: Theme.of(context)
                            .textTheme
                            .headline4
                            ?.copyWith(color: Colors.black),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          context.read<ListPokemonCubit>().getInitWishlistValue(state.detailPokemonResponse!.name);
                          Navigator.of(context).pushNamed(
                            DetailPokemonPage.routeName,
                            arguments: state.detailPokemonResponse,
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Detail",
                            style:
                                Theme.of(context).textTheme.headline4?.copyWith(
                                      color: Colors.white,
                                    ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              );
          }
        },
      ),
    );
  }
}
