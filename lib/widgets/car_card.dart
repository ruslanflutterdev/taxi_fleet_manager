import 'package:flutter/material.dart';
import '../models/car_model.dart';
import '../utils/colors_utils.dart';

class CarCard extends StatelessWidget {
  final CarModel car;

  const CarCard({super.key, required this.car});


  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 4,
      child: ListTile(
        leading: CircleAvatar(backgroundColor: getColorFromName(car.color)),
        title: Text(car.brandModel),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 4),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(4),
                color: Colors.white,
              ),
              child: Text(car.licensePlate),
            ),
            SizedBox(height: 4),
            Text('Водитель: ${car.driverName}'),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              car.isAvailable ? Icons.check_circle : Icons.cancel,
              color: car.isAvailable ? Colors.green : Colors.red,
            ),
            Text(car.isAvailable ? 'Свободен' : 'Занят'),
          ],
        ),
      ),
    );
  }
}
