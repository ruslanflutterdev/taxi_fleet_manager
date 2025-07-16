import 'package:flutter/material.dart';
import '../utils/colors_utils.dart';
import '../utils/constants.dart';

class ColorPicker extends StatelessWidget {
  final String selectedColor;
  final Function(String) onColorSelected;

  const ColorPicker({
    super.key,
    required this.selectedColor,
    required this.onColorSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('Цвет: '),
        ...carColors.map((color) {
          final isSelected = color == selectedColor;

          return GestureDetector(
            onTap: () => onColorSelected(color),
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
    );
  }
}
