import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/car_model.dart';
import '../providers/car_provider.dart';
import '../utils/colors_utils.dart';
import '../utils/constants.dart';

class EditCarScreen extends ConsumerStatefulWidget {
  final CarModel car;

  const EditCarScreen({super.key, required this.car});

  @override
  ConsumerState<EditCarScreen> createState() => _EditCarScreenState();
}

class _EditCarScreenState extends ConsumerState<EditCarScreen> {
  late TextEditingController _brandController;
  late TextEditingController _plateController;
  late TextEditingController _driverController;
  late String _selectedColor;

  @override
  void initState() {
    super.initState();
    _brandController = TextEditingController(text: widget.car.brandModel);
    _plateController = TextEditingController(text: widget.car.licensePlate);
    _driverController = TextEditingController(text: widget.car.driverName);
    _selectedColor = widget.car.color;
  }

  @override
  void dispose() {
    _brandController.dispose();
    _plateController.dispose();
    _driverController.dispose();
    super.dispose();
  }

  void _submit() async {
    final updatedCar = widget.car.copyWith(
      brandModel: _brandController.text.trim(),
      licensePlate: _plateController.text.trim(),
      driverName: _driverController.text.trim(),
      color: _selectedColor,
    );

    await ref.read(carProvider.notifier).updateCar(widget.car.id, updatedCar);
    if (context.mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Редактировать машину')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _brandController,
              decoration: InputDecoration(labelText: 'Марка и модель'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _plateController,
              decoration: InputDecoration(labelText: 'Гос номер'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _driverController,
              decoration: InputDecoration(labelText: 'Имя водителя'),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Text('Цвет: '),
                ...carColors.map((color) {
                  final isSelected = color == _selectedColor;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedColor = color;
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 4),
                      width: isSelected ? 36 : 30,
                      height: isSelected ? 36 : 30,
                      decoration: BoxDecoration(
                        color: getColorFromName(color),
                        shape: BoxShape.circle,
                        border: isSelected
                            ? Border.all(color: Colors.black, width: 2)
                            : null,
                      ),
                    ),
                  );
                }),
              ],
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: _submit,
              child: Text('Сохранить изменения'),
            ),
          ],
        ),
      ),
    );
  }
}
