
class CarPartsTypeModel {
  final int id;
  final String name;
  final String icon;

  CarPartsTypeModel({
    this.id,
    this.name,
    this.icon
  });

  CarPartsTypeModel.fromJson(Map<String, dynamic> parsedJson)
      : this.id = parsedJson['id'],
        this.name = parsedJson['name'],
        this.icon = parsedJson['icon'];
}