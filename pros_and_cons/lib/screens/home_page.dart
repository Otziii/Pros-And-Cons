import 'package:flutter/material.dart';
import 'package:pros_and_cons/database_helper.dart';
import 'package:pros_and_cons/models/argument.dart';
import 'package:pros_and_cons/widgets/decision_card_widget.dart';
import 'package:pros_and_cons/screens/decision_page.dart';

import '../models/decision.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Map<int, int> _prosSumMap = {};
  Map<int, int> _consSumMap = {};

  @override
  void initState() {
    _updateData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEEEEE),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(
                  top: 16,
                  bottom: 8,
                ),
                child: const Image(
                  image: AssetImage(
                    'assets/images/logo.png',
                  ),
                  height: 60,
                ),
              ),
              Expanded(
                child: FutureBuilder(
                  initialData: List<Decision>.empty(),
                  future: _dbHelper.getAllDecisions(),
                  builder: (context, snapshot) {
                    List<Decision> _list = snapshot.data as List<Decision>? ??
                        List<Decision>.empty();

                    return ListView.builder(
                      itemCount: _list.length,
                      itemBuilder: (context, index) {
                        Decision _decision = _list[index];

                        return GestureDetector(
                          onTap: () {
                            _navigateToDecision(_decision);
                          },
                          child: DecisionCardWidget(
                            decisionTitle: _decision.title.isNotEmpty
                                ? _decision.title
                                : "(No title)",
                            prosNumber: _prosSumMap[_decision.id!] ?? 0,
                            consNumber: _consSumMap[_decision.id!] ?? 0,
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 16,
                ),
                child: ElevatedButton(
                  onPressed: () {
                    _navigateToDecision(null);
                  },
                  child: const Text("New decision"),
                  style: ElevatedButton.styleFrom(
                    onPrimary: Colors.white,
                    primary: Colors.black87,
                    elevation: 10,
                    textStyle: const TextStyle(
                      fontSize: 20,
                    ),
                    minimumSize: const Size(
                      double.infinity,
                      45,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToDecision(Decision? decision) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DecisionPage(
          decision: decision,
        ),
      ),
    ).then((value) {
      _updateData();
    });
  }

  void _updateData() async {
    var _decisions = await _dbHelper.getAllDecisions();

    Map<int, List<Argument>> argumentMap = {};
    for (var decision in _decisions) {
      var arguments = await _dbHelper.getArgumentsForDecision(decision.id!);
      argumentMap[decision.id!] = arguments;
    }

    _updateNumbers(argumentMap);

    setState(() {});
  }

  void _updateNumbers(Map<int, List<Argument>> argumentMap) {
    _prosSumMap = {};
    _consSumMap = {};

    argumentMap.forEach((key, value) {
      var prosSum = 0;
      var consSum = 0;

      for (var arg in value) {
        if (arg.isPro == 0) {
          consSum += arg.value;
        } else {
          prosSum += arg.value;
        }
      }

      _prosSumMap[key] = prosSum;
      _consSumMap[key] = consSum;
    });
  }
}
