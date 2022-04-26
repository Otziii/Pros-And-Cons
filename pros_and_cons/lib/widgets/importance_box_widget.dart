import 'package:flutter/material.dart';

class ImportanceBoxWidget extends StatelessWidget {
  final int value;
  final bool isProSelected;
  final bool isSelected;

  const ImportanceBoxWidget({
    required this.value,
    required this.isProSelected,
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "$value",
            style: TextStyle(
              color: _getCorrectColor(),
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            _getSubText(),
            style: TextStyle(
              color: _getCorrectColor(),
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }

  Color _getCorrectColor() {
    if (isSelected) {
      if (isProSelected) {
        return const Color(0xFF338162);
      } else {
        return const Color(0xFFD11654);
      }
    } else {
      return Colors.black;
    }
  }

  String _getSubText() {
    switch (value) {
      case 1:
        return "Not very";
      case 2:
        return "A bit";
      case 3:
        return "Very much";
      default:
        return "Extremely";
    }
  }
}

// Green:   Color(0xFF338162)
// Red:     Color(0xFFD11654)
// Purple:  Color(0xFF562B42)
