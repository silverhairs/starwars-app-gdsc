import 'dart:convert';

import 'package:chatting/core/models/starwars_character.dart';
import 'package:http/http.dart';

class API {
  Future<List<StarWarsCharacter>> getCharacters() async {
    final uri = Uri.https(
      'awesome-star-wars-api.herokuapp.com',
      '/characters',
    );
    late final Response response;
    try {
      response = await get(uri);
    } catch (e) {
      // ignore: avoid_print
      print('Request failed');
      rethrow;
    }

    final Map jsonData = json.decode(response.body);
    final rawCharacters = jsonData['data'] as List;
    final List<StarWarsCharacter> characters = [];

    for (final char in rawCharacters) {
      characters.add(StarWarsCharacter.fromMap(char as Map<String, dynamic>));
    }
    return characters;
  }
}
