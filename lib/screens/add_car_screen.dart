import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/car_model.dart';
import '../providers/car_provider.dart';
import '../widgets/color_picker.dart';

class AddCarScreen extends ConsumerStatefulWidget {
  const AddCarScreen({super.key});

  @override
  ConsumerState<AddCarScreen> createState() => _AddCarScreenState();
}

class _AddCarScreenState extends ConsumerState<AddCarScreen> {
  final _brandModelController = TextEditingController();
  final _licensePlateController = TextEditingController();
  final _driverNameController = TextEditingController();
  String _selectedColor = 'red';

  void _showError(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  void _submit() async {
    final brandModel = _brandModelController.text.trim();
    final licensePlate = _licensePlateController.text.trim();
    final driverName = _driverNameController.text.trim();

    if (brandModel.isEmpty || licensePlate.isEmpty || driverName.isEmpty) {
      _showError('Пожалуйста, заполните все поля');
      return;
    }

    final newCar = CarModel(
      id: '',
      brandModel: brandModel,
      color: _selectedColor,
      licensePlate: licensePlate,
      driverName: driverName,
      isAvailable: false,
    );

    await ref.read(carProvider.notifier).addCar(newCar);
    if (mounted) Navigator.pop(context);
  }

  @override
  void dispose() {
    _brandModelController.dispose();
    _licensePlateController.dispose();
    _driverNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Добавить автомобиль')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _brandModelController,
              decoration: InputDecoration(labelText: 'Марка и модель'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _licensePlateController,
              decoration: InputDecoration(labelText: 'Гос номер'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _driverNameController,
              decoration: InputDecoration(labelText: 'Имя водителя'),
            ),
            SizedBox(height: 20),
            ColorPicker(
              selectedColor: _selectedColor,
              onColorSelected: (color) {
                setState(() {
                  _selectedColor = color;
                });
              },
            ),
            SizedBox(height: 30),
            ElevatedButton(onPressed: _submit, child: Text('Добавить')),
          ],
        ),
      ),
    );
  }
}
