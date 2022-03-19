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
