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

  static Future<void> updateCarStatus(String carId, bool newStatus) async {
    final url = Uri.parse('$baseUrl/cars/$carId.json');
    final response = await http.patch(
      url,
      body: json.encode({'isAvailable': newStatus}),
    );
    if (response.statusCode != 200) {
      throw Exception('Ошибка при обновлении статуса машины');
    }
  }

  static Future<CarModel> getCarById(String carId) async {
    final url = Uri.parse('$baseUrl/cars/$carId.json');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data == null) {
        throw Exception('Машина не найдена');
      }
      return CarModel.fromJson({'id': carId, ...data});
    } else {
      throw Exception('Ошибка при загрузке автомобиля');
    }
  }

  static Future<void> deleteCar(String carId) async {
    final url = Uri.parse('$baseUrl/cars/$carId.json');
    final response = await http.delete(url);

    if (response.statusCode != 200) {
      throw Exception('Ошибка при удалении автомобиля');
    }
  }

  static Future<void> updateCar(
    String carId,
    Map<String, dynamic> updatedData,
  ) async {
    final url = Uri.parse('$baseUrl/cars/$carId.json');
    final response = await http.patch(url, body: json.encode(updatedData));

    if (response.statusCode != 200) {
      throw Exception('Ошибка при обновлении машины');
    }
  }
}
