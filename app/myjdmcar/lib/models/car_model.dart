

class CarModelModel{

  final int id;
  final String name;
  final String description;
  final String power;
  final String transmission;
  final String image;

  CarModelModel({this.id, this.name, this.description, this.power, this.transmission, this.image});

    CarModelModel.fromJson(Map<String, dynamic> parsedJson)
      : this.id = parsedJson['id'] ?? null,
        this.name = parsedJson['name'] ?? null,
        this.description = parsedJson['description'] ?? null,
        this.power = parsedJson['power'] ?? null,
        this.transmission = parsedJson['transmission'] ?? null,
        this.image = parsedJson['image'] ?? null;

  Map<String, dynamic> toJson() =>
      {'id': id ?? null, 'name': name ?? null, 'description': description ?? null, 'power' : power ?? null, 'transmission' : transmission ?? null, 'image': image ?? null};


}