import '../models/car_model.dart';
import '../services/firebase_service.dart';

class CarRepository {
  Future<List<CarModel>> getAll() => FirebaseService.getAllCars();

  Future<void> add(CarModel car) => FirebaseService.addCar(car);

  Future<void> updateStatus(String carId, bool status) =>
      FirebaseService.updateCarStatus(carId, status);

  Future<void> update(String carId, CarModel updatedCar) {
    final data = updatedCar.toJson()..remove('id');
    return FirebaseService.updateCar(carId, data);
  }

  Future<void> delete(String carId) => FirebaseService.deleteCar(carId);
}
