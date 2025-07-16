import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/car_repository.dart';
import '../models/car_model.dart';

class CarNotifier extends StateNotifier<List<CarModel>> {
  final CarRepository repository;

  CarNotifier(this.repository) : super([]);

  Future<void> loadCars() async {
    state = await repository.getAll();
  }

  Future<void> addCar(CarModel car) async {
    await repository.add(car);
    await loadCars();
  }

  Future<void> updateCarStatus({
    required String carId,
    required bool newStatus,
  }) async {
    await repository.updateStatus(carId, newStatus);
    await loadCars();
  }

  Future<void> updateCar(String carId, CarModel updatedCar) async {
    await repository.update(carId, updatedCar);
    await loadCars();
  }

  Future<void> deleteCar(String carId) async {
    await repository.delete(carId);
    await loadCars();
  }
}
