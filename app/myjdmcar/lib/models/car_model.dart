class CarModelModel {
  final String id;
  final String name;
  final String description;
  final String engine;
  final String power;
  final String transmission;
  final String image;

  CarModelModel(
      {this.id,
      this.name,
      this.description,
      this.engine,
      this.power,
      this.transmission,
      this.image});

  CarModelModel.fromJson(Map<String, dynamic> parsedJson)
      : this.id = parsedJson['id'] ?? null,
        this.name = parsedJson['nombre'] ?? null,
        this.description = parsedJson['descripcion'] ?? null,
        this.engine = parsedJson['motor'] ?? null,
        this.power = parsedJson['potencia'] ?? null,
        this.transmission = parsedJson['transmision'] ?? null,
        this.image = parsedJson['imagen'] ?? null;

  Map<String, dynamic> toJson() => {
        'id': id ?? null,
        'name': name ?? null,
        'description': description ?? null,
        'engine': engine ?? null,
        'power': power ?? null,
        'transmission': transmission ?? null,
        'image': image ?? null
      };
}
