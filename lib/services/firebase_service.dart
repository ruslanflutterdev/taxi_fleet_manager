import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/car_model.dart';

const String baseUrl =
    'https://taxifleetmanager-aa0f3-default-rtdb.europe-west1.firebasedatabase.app/';

class FirebaseService {
  static Future<List<CarModel>> getAllCars() async {
    final url = Uri.parse('$baseUrl/cars.json');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data == null) return [];
      final List<CarModel> cars = [];
      data.forEach((key, value) {
        final car = CarModel.fromJson({'id': key, ...value});
        cars.add(car);
      });

      return cars;
    } else {
      throw Exception('Ошибка при загрузке данных: ${response.statusCode}');
    }
  }

  static Future<void> addCar(CarModel car) async {
    final url = Uri.parse('$baseUrl/cars.json');
    final Map<String, dynamic> carData = {
      'brandModel': car.brandModel,
      'color': car.color,
      'licensePlate': car.licensePlate,
      'driverName': car.driverName,
      'isAvailable': car.isAvailable,
    };

    final response = await http.post(url, body: json.encode(carData));
    if (response.statusCode != 200) {
      throw Exception('Ошибка при добавлении машины');
    }
  }
}
