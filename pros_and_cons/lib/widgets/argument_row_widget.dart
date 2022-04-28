import 'package:flutter/material.dart';

class ArgumentRowWidget extends StatelessWidget {
  final bool isPro;
  final String title;
  final int score;

  const ArgumentRowWidget({
    Key? key,
    required this.isPro,
    required this.title,
    required this.score,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        bottom: 4,
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                color: Colors.white,
                child: Text(
                  title,
                  style: TextStyle(
                    backgroundColor: Colors.white,
                    color: isPro
                        ? const Color(0xFF338162)
                        : const Color(0xFFD11654),
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                left: 4,
              ),
              width: 90,
              //height: double.infinity,
              alignment: Alignment.center,
              padding: const EdgeInsets.all(16),
              color: Colors.white,
              child: Text(
                "$score",
                style: TextStyle(
                  color:
                      isPro ? const Color(0xFF338162) : const Color(0xFFD11654),
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Green:   Color(0xFF338162)
// Red:     Color(0xFFD11654)
// Purple:  Color(0xFF562B42)
