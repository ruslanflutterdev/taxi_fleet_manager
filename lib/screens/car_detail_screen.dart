import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/car_provider.dart';
import '../providers/single_machine_provider.dart';
import '../utils/colors_utils.dart';
import 'edit_car_screen.dart';

class CarDetailScreen extends ConsumerWidget {
  final String carId;

  const CarDetailScreen({super.key, required this.carId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final carAsync = ref.watch(carByIdProvider(carId));

    return Scaffold(
      appBar: AppBar(title: Text('Информация о машине')),
      body: carAsync.when(
        data: (car) {
          return Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: getColorFromName(car.color),
                ),
                SizedBox(height: 16),
                Text(
                  'Водитель: ${car.driverName}',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 8),
                Text(
                  'Номер: ${car.licensePlate}',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 20),
                Text(
                  'Статус: ${car.isAvailable ? "Свободен" : "Занят"}',
                  style: TextStyle(
                    fontSize: 18,
                    color: car.isAvailable ? Colors.green : Colors.red,
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton.icon(
                  icon: Icon(Icons.sync),
                  label: Text(
                    car.isAvailable ? 'Сделать занятым' : 'Сделать свободным',
                  ),
                  onPressed: () async {
                    await ref
                        .read(carProvider.notifier)
                        .updateCarStatus(
                          carId: car.id,
                          newStatus: !car.isAvailable,
                        );
                    ref.invalidate(carByIdProvider(carId));
                    ref.read(carProvider.notifier).loadCars();
                  },
                ),
                SizedBox(height: 12),
                ElevatedButton.icon(
                  icon: Icon(Icons.edit),
                  label: Text('Редактировать'),
                  onPressed: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => EditCarScreen(car: car),
                      ),
                    );
                    ref.invalidate(carByIdProvider(carId));
                    ref.read(carProvider.notifier).loadCars();
                  },
                ),
                SizedBox(height: 12),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  icon: Icon(Icons.delete, color: Colors.white),
                  label: Text(
                    'Удалить машину',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    final confirmed = await showDialog<bool>(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: Text('Удалить автомобиль'),
                        content: Text(
                          'Вы уверены, что хотите удалить эту машину?',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(ctx, false),
                            child: Text('Отмена'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(ctx, true),
                            child: Text('Удалить'),
                          ),
                        ],
                      ),
                    );

                    if (confirmed == true) {
                      await ref.read(carProvider.notifier).deleteCar(carId);
                      if (context.mounted) {
                        Navigator.pop(context);
                      }
                    }
                  },
                ),
              ],
            ),
          );
        },
        loading: () => Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Ошибка: $e')),
      ),
    );
  }
}
