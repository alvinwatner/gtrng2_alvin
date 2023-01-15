// To parse this JSON data, do
//
//     final listPokemon = listPokemonFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ListPokemonResponse listPokemonResponseFromJson(String str) => ListPokemonResponse.fromJson(json.decode(str));

String listPokemonResponseToJson(ListPokemonResponse data) => json.encode(data.toJson());

class ListPokemonResponse {
    ListPokemonResponse({
        required this.count,
        required this.next,
        required this.previous,
        required this.listPokemonData,
    });

    final int count;
    final String next;
    final dynamic previous;
    final List<PokemonData> listPokemonData;

    factory ListPokemonResponse.fromJson(Map<String, dynamic> json) => ListPokemonResponse(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        listPokemonData: List<PokemonData>.from(json["results"].map((x) => PokemonData.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(listPokemonData.map((x) => x.toJson())),
    };
}

class PokemonData {
    PokemonData({
        required this.name,
        required this.url,
    });

    final String name;
    final String url;

    factory PokemonData.fromJson(Map<String, dynamic> json) => PokemonData(
        name: json["name"],
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
    };
}
