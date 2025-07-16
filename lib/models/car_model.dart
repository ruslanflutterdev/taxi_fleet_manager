class CarModel {
  final String id;
  final String brandModel;
  final String color;
  final String licensePlate;
  final String driverName;
  final bool isAvailable;

  CarModel({
    required this.id,
    required this.brandModel,
    required this.color,
    required this.licensePlate,
    required this.driverName,
    required this.isAvailable,
  });

  factory CarModel.fromJson(Map<String, dynamic> json) {
    return CarModel(
      id: json['id'],
      brandModel: json['brandModel'],
      color: json['color'],
      licensePlate: json['licensePlate'],
      driverName: json['driverName'],
      isAvailable: json['isAvailable'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'brandModel': brandModel,
      'color': color,
      'licensePlate': licensePlate,
      'driverName': driverName,
      'isAvailable': isAvailable,
    };
  }
}
