import 'package:chatting/core/api/api.dart';
import 'package:chatting/core/models/starwars_character.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final api = API();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<List<StarWarsCharacter>>(
            future: api.getCharacters(),
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
}
