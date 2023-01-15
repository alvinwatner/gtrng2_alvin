import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gtrng2_alvin/list_pokemon/logics/cubit/list_pokemon_cubit.dart';
import 'package:gtrng2_alvin/list_pokemon/models/detail_pokemon_response.dart';

class DetailPokemonPage extends StatefulWidget {
  static const String routeName = 'detail-pokemon';
  const DetailPokemonPage({super.key});

  @override
  State<DetailPokemonPage> createState() => _DetailPokemonPageState();
}

class _DetailPokemonPageState extends State<DetailPokemonPage> {
  final ScrollController _sliverScrollController = ScrollController();
  bool isWishlist = false;
  bool isPinned = false;

  @override
  void initState() {
    _sliverScrollController.addListener(() {
      if (_sliverScrollController.offset > 400) {
        setState(() {
          isPinned = true;
        });
      } else {
        setState(() {
          isPinned = false;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final DetailPokemonResponse detailPokemonResponse =
        ModalRoute.of(context)!.settings.arguments as DetailPokemonResponse;
    return Scaffold(
      body: CustomScrollView(
        controller: _sliverScrollController,
        slivers: <Widget>[
          SliverAppBar(
            bottom: PreferredSize(
              preferredSize: const Size(0, 20),
              child: Container(),
            ),
            pinned: true,
            expandedHeight: MediaQuery.of(context).size.height * 0.6,
            flexibleSpace: Stack(
              children: [
                if (isPinned == false)
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image(
                        fit: BoxFit.contain,
                        image: NetworkImage(
                          detailPokemonResponse.sprites.other!.home.frontShiny,
                        ),
                      ),
                    ),
                  ),
                Positioned(
                  top: 70,
                  left: 170,
                  child: Text(
                    "Detail",
                    style: Theme.of(context).textTheme.headline6?.copyWith(
                          color: Colors.white,
                        ),
                  ),
                ),
                Positioned(
                  top: 60,
                  right: 20,
                  child: InkWell(
                    onTap: () {
                      context
                          .read<ListPokemonCubit>()
                          .updateWishlist(detailPokemonResponse.name);
                    },
                    child: BlocBuilder<ListPokemonCubit, ListPokemonState>(
                      buildWhen: (previous, current) =>
                          previous.wishlistStatus != current.wishlistStatus,
                      builder: (context, state) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 4, vertical: 3),
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8.0)),
                          child: Icon(
                            Icons.favorite,
                            color:
                                (state.isWishlist) ? Colors.blue : Colors.grey,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Positioned(
                  bottom: -1,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 30,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(50),
                      ),
                    ),
                    child: Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.12,
                        child: Divider(
                          thickness: 3,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              const SizedBox(
                height: 20.0,
              ),
              Center(
                child: Text(
                  detailPokemonResponse.name,
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text(
                        "Height",
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      Text(
                        detailPokemonResponse.height.toString(),
                        style: Theme.of(context).textTheme.headline6?.copyWith(
                              color: Colors.grey.shade700,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 25.0,
                  ),
                  Container(
                    height: 50,
                    width: 2,
                    decoration: const BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 25.0,
                  ),
                  Column(
                    children: [
                      Text(
                        "Width",
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      Text(
                        detailPokemonResponse.weight.toString(),
                        style: Theme.of(context).textTheme.headline6?.copyWith(
                              color: Colors.grey.shade700,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 15.0,
                  ),
                  Container(
                    height: 50,
                    width: 2,
                    decoration: const BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 25.0,
                  ),
                  Column(
                    children: [
                      Text(
                        "Experience",
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      Text(
                        detailPokemonResponse.baseExperience.toString(),
                        style: Theme.of(context).textTheme.headline6?.copyWith(
                              color: Colors.grey.shade700,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 15.0,
                  ),
                ],
              ),
              const SizedBox(
                height: 30.0,
              ),
              Center(
                child: Text(
                  "- Moves -",
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              ...List.generate(
                detailPokemonResponse.moves.length,
                (index) => Container(
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color:
                        (index % 2 == 0) ? Colors.grey.shade400 : Colors.white,
                  ),
                  child: Text(
                    detailPokemonResponse.moves[index].move.name,
                    style: Theme.of(context).textTheme.subtitle2?.copyWith(
                          color: (index % 2 == 0)
                              ? Colors.white
                              : Colors.grey.shade700,
                        ),
                  ),
                ),
              ).toList()
            ]),
          )
        ],
      ),
    );
  }
}
