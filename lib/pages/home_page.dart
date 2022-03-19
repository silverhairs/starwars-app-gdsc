import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<List<StarWarsCharacter>>(
            future: _getCharacters(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  // TODO(boris): What happens if there is an error.
                }
                if (snapshot.hasData) {
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    itemBuilder: (context, i) {
                      final character = snapshot.data![i];
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(character.imagePath!),
                        ),
                        subtitle: Text(character.homeworld ?? 'No homeland'),
                        title: Text(character.name),
                      );
                    },
                    itemCount: snapshot.data!.length,
                  );
                } else {
                  return const Text('No Data');
                }
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }

  Future<List<StarWarsCharacter>> _getCharacters() async {
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

class StarWarsCharacter {
  const StarWarsCharacter({
    required this.name,
    this.height,
    this.homeworld,
    this.species,
    this.imagePath,
  });

  factory StarWarsCharacter.fromMap(Map<String, dynamic> map) =>
      StarWarsCharacter(
        name: map['name'],
        height: map['height'] as num?,
        homeworld: map['homeworld'],
        species: map['species'],
        imagePath: map['image'] as String?,
      );

  final String name;
  final num? height;
  final String? homeworld;
  final String? species;
  final String? imagePath;
}
