class CarPartTypeModel {
  final int id;
  final String name;
  final String icon;

  CarPartTypeModel({this.id, this.name, this.icon});

  CarPartTypeModel.fromJson(Map<String, dynamic> parsedJson)
      : this.id = parsedJson['id'],
        this.name = parsedJson['name'],
        this.icon = parsedJson['icon'];

  Map<String, dynamic> toJson() => {'id': id, 'name': name, "icon": icon};
}
