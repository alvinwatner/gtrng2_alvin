import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gtrng2_alvin/list_pokemon/logics/cubit/list_pokemon_cubit.dart';
import 'package:gtrng2_alvin/list_pokemon/views/pages/list_pokemon_page.dart';
import 'package:gtrng2_alvin/routes.dart';
import 'package:gtrng2_alvin/transition.dart';

void main() {
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => ListPokemonCubit()..getListPokemonData(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokemon App',
      theme: ThemeData(
        primarySwatch: Colors.red,
        textTheme: GoogleFonts.ubuntuTextTheme(
          Theme.of(context).textTheme,
        )
      ),
      onGenerateRoute: (settings) {
        return FadeRoute(page: routes[settings.name]!, settings: settings);
      },
      home: const ListPokemonPage(),
    );
  }
}
