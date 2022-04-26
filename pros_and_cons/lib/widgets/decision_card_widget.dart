import 'package:flutter/material.dart';

class DecisionCardWidget extends StatelessWidget {
  final String decisionTitle;
  final int prosNumber;
  final int consNumber;

  //const DecisionCardWidget({Key? key}) : super(key: key);
  const DecisionCardWidget({
    required this.decisionTitle,
    required this.prosNumber,
    required this.consNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 16,
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 8,
            ),
            decoration: BoxDecoration(
              color: _getHeaderColor(),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(5),
                topRight: Radius.circular(5),
              ),
            ),
            child: Text(
              decisionTitle,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 25,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 16,
            ),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(5),
                bottomRight: Radius.circular(5),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    const Text(
                      "Pros",
                      style: TextStyle(
                        color: Color(0xFF338162),
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "$prosNumber",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Color(0xFF338162),
                        fontSize: 70,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 70,
                  width: 4,
                  decoration: const BoxDecoration(
                    color: Color(0xFFEEEEE5),
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                ),
                Column(
                  children: [
                    const Text(
                      "Cons",
                      style: TextStyle(
                        color: Color(0xFFD11654),
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "$consNumber",
                      style: const TextStyle(
                        color: Color(0xFFD11654),
                        fontSize: 70,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getHeaderColor() {
    if (prosNumber > consNumber) {
      return const Color(0xFF338162);
    } else if (prosNumber < consNumber) {
      return const Color(0xFFD11654);
    } else {
      return Colors.black87;
    }
  }
}
