import 'package:flutter/material.dart';

class ProOrConBoxWidget extends StatelessWidget {
  final bool isPro;
  final bool isSelected;

  const ProOrConBoxWidget({
    required this.isPro,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 105,
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
        return const Color(0xFF338162);
      } else {
        return const Color(0xFFD11654);
      }
    } else {
      return Colors.black;
    }
  }
}

// Green:   Color(0xFF338162)
// Red:     Color(0xFFD11654)
// Purple:  Color(0xFF562B42)
