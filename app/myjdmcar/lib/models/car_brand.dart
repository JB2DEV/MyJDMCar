class CarBrandModel {
  final int id;
  final String name;
  final String image;

  CarBrandModel({this.id, this.name,this.image});

  CarBrandModel.fromJson(Map<String, dynamic> parsedJson)
      : this.id = (parsedJson['id'] as int) ?? null,
        this.name = parsedJson['name'] ?? null,
        this.image = parsedJson['image'] ?? null;

  Map<String, dynamic> toJson() => {
        'id': id ?? null,
        'name': name ?? null,
        'image': image ?? null
      };
}
