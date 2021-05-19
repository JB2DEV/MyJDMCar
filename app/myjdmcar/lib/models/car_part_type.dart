class CarPartTypeModel {
  final int id;
  final String name;
  final String icon;

  CarPartTypeModel({this.id, this.name, this.icon});

  CarPartTypeModel.fromJson(Map<String, dynamic> parsedJson)
      : this.id = parsedJson['id'] as int ?? null,
        this.name = parsedJson['name'] ?? null,
        this.icon = parsedJson['icon'] ?? null;

  Map<String, dynamic> toJson() =>
      {'id': id ?? null, 'name': name ?? null, "icon": icon ?? null};
}
