class CarPartBrandModel {
  final int id;
  final String name;
  final String description;
  final String image;

  CarPartBrandModel({this.id, this.name, this.description, this.image});

  CarPartBrandModel.fromJson(Map<String, dynamic> parsedJson)
      : this.id = parsedJson['id'] ?? null,
        this.name = parsedJson['name'] ?? null,
        this.description = parsedJson['description'] ?? null,
        this.image = parsedJson['image'] ?? null;

  Map<String, dynamic> toJson() =>
      {'id': id ?? null, 'name': name ?? null, 'description': description ?? null, 'image': image ?? null};
}
