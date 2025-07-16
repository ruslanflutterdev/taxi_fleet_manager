import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/car_notifier.dart';
import '../data/car_repository.dart';
import '../models/car_model.dart';

final carProvider = StateNotifierProvider<CarNotifier, List<CarModel>>(
  (ref) => CarNotifier(CarRepository()),
);
