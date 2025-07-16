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
      id: json['id'] ?? '',
      brandModel: json['brandModel'] ?? '',
      color: json['color'] ?? 'gray',
      licensePlate: json['licensePlate'] ?? '',
      driverName: json['driverName'] ?? '',
      isAvailable: json['isAvailable'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'brandModel': brandModel,
      'color': color,
      'licensePlate': licensePlate,
      'driverName': driverName,
      'isAvailable': isAvailable,
    };
  }

  CarModel copyWith({
    String? id,
    String? brandModel,
    String? color,
    String? licensePlate,
    String? driverName,
    bool? isAvailable,
  }) {
    return CarModel(
      id: id ?? this.id,
      brandModel: brandModel ?? this.brandModel,
      color: color ?? this.color,
      licensePlate: licensePlate ?? this.licensePlate,
      driverName: driverName ?? this.driverName,
      isAvailable: isAvailable ?? this.isAvailable,
    );
  }
}
