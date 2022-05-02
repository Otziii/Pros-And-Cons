import 'package:flutter/material.dart';
import 'package:pros_and_cons/database_helper.dart';
import 'package:pros_and_cons/models/argument.dart';
import 'package:pros_and_cons/models/decision.dart';
import 'package:pros_and_cons/screens/argument_page.dart';
import 'package:pros_and_cons/widgets/argument_row_widget.dart';

import '../colors.dart';

class DecisionPage extends StatefulWidget {
  final Decision? decision;

  const DecisionPage({
    this.decision,
  });

  @override
  State<DecisionPage> createState() => _DecisionPageState();
}

class _DecisionPageState extends State<DecisionPage> {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  List<Argument> _arguments = [];
  final TextEditingController _textController = TextEditingController();

  int _newDecisionId = -1;
  int _prosSum = 0;
  int _consSum = 0;

  @override
  void initState() {
    if (widget.decision != null) {
      _textController.text = widget.decision?.title ?? "";
      _fetchArguments();
    } else if (_newDecisionId > 0) {
      _fetchArguments();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.pcBackground,
        elevation: 0,
        foregroundColor: Colors.black,
        automaticallyImplyLeading: false,
        leadingWidth: 500,
        leading: InkWell(
          onTap: _saveAndExit,
          child: Row(
            children: const [
              Icon(
                Icons.chevron_left,
                color: Colors.black,
                size: 50,
              ),
              Text(
                "Save",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
        actions: [
          Visibility(
            visible: widget.decision != null || _newDecisionId > 0,
            child: IconButton(
              icon: const Icon(
                Icons.delete_forever_rounded,
                color: Colors.black,
                size: 30,
              ),
              onPressed: () {
                _showDialog(context);
              },
            ),
          ),
        ],
      ),
      backgroundColor: CustomColors.pcBackground,
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Column(
              children: [
                TextField(
                  controller: _textController,
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                    hintText: "Whats your decision?",
                    border: InputBorder.none,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: const TextStyle(
                    fontSize: 25,
                    color: Colors.black,
                  ),
                ),
                Visibility(
                  visible: _arguments.isNotEmpty,
                  child: Text(
                    _getResultText(),
                    style: TextStyle(
                      fontSize: 60,
                      fontWeight: FontWeight.bold,
                      color: _getResultColor(),
                    ),
                  ),
                ),
                Flexible(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
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
                                ),
                                Text(
                                  "$_prosSum",
                                  style: const TextStyle(
                                    color: CustomColors.pcGreen,
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              height: 55,
                              width: 4,
                              decoration: const BoxDecoration(
                                color: Colors.white,
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
                                ),
                                Text(
                                  "$_consSum",
                                  style: const TextStyle(
                                    color: CustomColors.pcRed,
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Flexible(
                        child: ListView(
                          children: [
                            Visibility(
                              visible: _prosSum > 0,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  bottom: 8,
                                ),
                                child: Row(
                                  children: const [
                                    Text(
                                      "Pros",
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                    Spacer(),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        right: 34,
                                      ),
                                      child: Text(
                                        "Score",
                                        style: TextStyle(
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            _getListColumn(true),
                            Visibility(
                              visible: _consSum > 0,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  top: 16,
                                  bottom: 8,
                                ),
                                child: Row(
                                  children: const [
                                    Text(
                                      "Cons",
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                    Spacer(),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        right: 34,
                                      ),
                                      child: Text(
                                        "Score",
                                        style: TextStyle(
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            _getListColumn(false),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 8,
                    bottom: 16,
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      _navigateToArgument(null);
                    },
                    child: const Text("New argument"),
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
      ),
    );
  }

  void _navigateToArgument(Argument? argument) {
    if (widget.decision == null && _newDecisionId <= 0) {
      _dbHelper
          .insertDecision(Decision(
        title: _textController.text,
      ))
          .then((decisionId) {
        _newDecisionId = decisionId;

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ArgumentPage(
              decisionId: decisionId,
              argument: argument,
            ),
          ),
        ).then((value) {
          _fetchArguments();
        });
      });
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ArgumentPage(
            decisionId: widget.decision?.id ?? _newDecisionId,
            argument: argument,
          ),
        ),
      ).then((value) {
        _fetchArguments();
      });
    }
  }

  String _getResultText() {
    if (_prosSum > _consSum) {
      return "YES";
    } else if (_prosSum < _consSum) {
      return "NO";
    } else {
      return "MAYBE";
    }
  }

  Color _getResultColor() {
    if (_prosSum > _consSum) {
      return CustomColors.pcGreen;
    } else if (_prosSum < _consSum) {
      return CustomColors.pcRed;
    } else {
      return Colors.black87;
    }
  }

  Widget _getListColumn(bool pros) {
    List<Argument> _list = _arguments.where((arg) {
      return arg.isPro == (pros ? 1 : 0);
    }).toList();

    return Column(
      children: _list
          .map(
            (item) => GestureDetector(
              onTap: () {
                _navigateToArgument(item);
              },
              child: ArgumentRowWidget(
                isPro: pros,
                title: item.title.isNotEmpty ? item.title : "(No title)",
                score: item.value,
              ),
            ),
          )
          .toList(),
    );
  }

  void _fetchArguments() async {
    _arguments = await _dbHelper
        .getArgumentsForDecision(widget.decision?.id ?? _newDecisionId);

    _setNumbers();
    setState(() {});
  }

  void _setNumbers() {
    _prosSum = 0;
    _consSum = 0;

    for (var arg in _arguments.toList()) {
      if (arg.isPro == 0) {
        _consSum += arg.value;
      } else {
        _prosSum += arg.value;
      }
    }
  }

  void _saveAndExit() {
    if (widget.decision != null) {
      _dbHelper.updateDecision(widget.decision!.id!, _textController.text);
    } else if (_newDecisionId > 0) {
      if (_textController.text.isNotEmpty || _arguments.isNotEmpty) {
        _dbHelper.updateDecision(_newDecisionId, _textController.text);
      } else {
        _dbHelper.deleteDecision(_newDecisionId);
      }
    } else if (_textController.text.isNotEmpty || _arguments.isNotEmpty) {
      _dbHelper.insertDecision(
        Decision(title: _textController.text),
      );
    }

    Navigator.pop(context);
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete decision'),
          content: const Text('Are you sure you want to delete?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'No',
                style: TextStyle(color: Colors.black),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();

                if (widget.decision != null) {
                  _dbHelper.deleteDecision(widget.decision!.id!).then((value) {
                    Navigator.pop(context);
                  });
                } else if (_newDecisionId > 0) {
                  _dbHelper.deleteDecision(_newDecisionId).then((value) {
                    Navigator.pop(context);
                  });
                } else {
                  Navigator.pop(context);
                }
              },
              child: const Text(
                'Yes',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        );
      },
    );
  }
}
