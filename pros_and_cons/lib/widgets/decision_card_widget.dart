import 'package:flutter/material.dart';
import '../colors.dart';

class DecisionCardWidget extends StatelessWidget {
  final String decisionTitle;
  final int prosNumber;
  final int consNumber;

  //const DecisionCardWidget({Key? key}) : super(key: key);
  const DecisionCardWidget({
    Key? key,
    required this.decisionTitle,
    required this.prosNumber,
    required this.consNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 16,
        left: 8,
        right: 8,
        top: 5,
      ),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 2,
                offset: const Offset(
                  0,
                  2,
                )),
          ],
          borderRadius: const BorderRadius.all(
            Radius.circular(5),
          )),
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
                fontSize: 22,
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
                        color: CustomColors.pcGreen,
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "$prosNumber",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: CustomColors.pcGreen,
                        fontSize: 60,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 70,
                  width: 4,
                  decoration: const BoxDecoration(
                    color: CustomColors.pcBackground,
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
                        color: CustomColors.pcRed,
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "$consNumber",
                      style: const TextStyle(
                        color: CustomColors.pcRed,
                        fontSize: 60,
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
      return CustomColors.pcGreen;
    } else if (prosNumber < consNumber) {
      return CustomColors.pcRed;
    } else {
      return CustomColors.pcPurple;
    }
  }
}
