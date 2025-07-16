import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/car_provider.dart';
import '../widgets/car_card.dart';
import 'add_car_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cars = ref.watch(carProvider);

    return Scaffold(
      appBar: AppBar(title: Text('Taxi Fleet Manager'), centerTitle: true),
      body: RefreshIndicator(
        onRefresh: () => ref.read(carProvider.notifier).loadCars(),
        child: cars.isEmpty
            ? Center(child: Text('Нет доступных машин'))
            : ListView.builder(
                itemCount: cars.length,
                itemBuilder: (context, index) {
                  final car = cars[index];
                  return CarCard(car: car);
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AddCarScreen()),
          );

          ref.read(carProvider.notifier).loadCars();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
