

class CarModelModel{

  final int id;
  final String name;
  final String description;
  final String power;
  final String transmission;
  final String image;

  CarModelModel({this.id, this.name, this.description, this.power, this.transmission, this.image});

    CarModelModel.fromJson(Map<String, dynamic> parsedJson)
      : this.id = parsedJson['id'],
        this.name = parsedJson['name'],
        this.description = parsedJson['description'],
        this.power = parsedJson['power'],
        this.transmission = parsedJson['transmission'],
        this.image = parsedJson['image'];

  Map<String, dynamic> toJson() =>
      {'id': id, 'name': name, 'description': description, 'power' : power, 'transmission' : transmission, 'image': image};


}