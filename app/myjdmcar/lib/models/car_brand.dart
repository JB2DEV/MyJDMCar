class CarBrandModel {
  final int id;
  final String name;
  final String description;
  final String image;

  CarBrandModel({this.id, this.name, this.description, this.image});

  CarBrandModel.fromJson(Map<String, dynamic> parsedJson)
      : this.id = parsedJson['id'],
        this.name = parsedJson['name'],
        this.description = parsedJson['description'],
        this.image = parsedJson['image'];

  Map<String, dynamic> toJson() =>
      {'id': id, 'name': name, 'description': description, 'image': image};
}
