class CarBrandModel {
  final int id;
  final String name;
  final String description;
  final String image;

  CarBrandModel({this.id, this.name, this.description, this.image});

  CarBrandModel.fromJson(Map<String, dynamic> parsedJson)
      : this.id = (parsedJson['id'] as int) ?? null,
        this.name = parsedJson['name'] ?? null,
        this.description = parsedJson['description'] ?? null,
        this.image = parsedJson['image'] ?? null;

  Map<String, dynamic> toJson() => {
        'id': id ?? null,
        'name': name ?? null,
        'description': description ?? null,
        'image': image ?? null
      };
}
