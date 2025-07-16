import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/car_model.dart';
import '../services/firebase_service.dart';

class CarNotifier extends StateNotifier<List<CarModel>> {
  CarNotifier() : super([]);

  Future<void> loadCars() async {
    try {
      final cars = await FirebaseService.getAllCars();
      state = cars;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> addCar(CarModel car) async {
    try {
      await FirebaseService.addCar(car);
      await loadCars();
    } catch (e) {
      throw Exception(e);
    }
  }
}


