import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/car_model.dart';
import '../services/firebase_service.dart';

final carByIdProvider = FutureProvider.family<CarModel, String>((
  ref,
  carId,
) async {
  return await FirebaseService.getCarById(carId);
});
