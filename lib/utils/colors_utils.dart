import 'package:flutter/material.dart';

Color getColorFromName(String color) {
  switch (color.toLowerCase()) {
    case 'red':
      return Colors.red;
    case 'blue':
      return Colors.blue;
    case 'green':
      return Colors.green;
    case 'yellow':
      return Colors.yellow;
    case 'gray':
    case 'grey':
      return Colors.grey;
    default:
      return Colors.black;
  }
}
