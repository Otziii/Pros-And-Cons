import 'package:flutter/material.dart';

import '../colors.dart';

class ProOrConBoxWidget extends StatelessWidget {
  final bool isPro;
  final bool isSelected;

  const ProOrConBoxWidget({
    Key? key,
    required this.isPro,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 90,
      decoration: BoxDecoration(
        border: Border.all(
          color: _getCorrectColor(),
          width: 2,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(5),
        ),
        color: isSelected ? Colors.white : Colors.transparent,
      ),
      child: Text(
        isPro ? "Pro" : "Con",
        style: TextStyle(
          color: _getCorrectColor(),
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Color _getCorrectColor() {
    if (isSelected) {
      if (isPro) {
        return CustomColors.pcGreen;
      } else {
        return CustomColors.pcRed;
      }
    } else {
      return Colors.black;
    }
  }
}
