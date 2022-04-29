import 'package:flutter/material.dart';
import 'package:pros_and_cons/models/argument.dart';
import 'package:pros_and_cons/widgets/argument_selection_box_widget.dart';
import 'package:pros_and_cons/widgets/importance_box_widget.dart';

import '../database_helper.dart';

class ArgumentPage extends StatefulWidget {
  final int decisionId;
  final Argument? argument;

  const ArgumentPage({required this.decisionId, this.argument});

  @override
  State<ArgumentPage> createState() => _ArgumentPageState();
}

class _ArgumentPageState extends State<ArgumentPage> {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  bool? _isProSelected;
  int? _valueSelected;

  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    if (widget.argument != null) {
      _textEditingController.text = widget.argument?.title ?? "";
      _isProSelected = widget.argument?.isPro == 1;
      _valueSelected = widget.argument?.value;
    }

    _textEditingController.addListener(_textFieldChanged);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFEEEEEE),
        elevation: 0,
        foregroundColor: Colors.black,
        actions: [
          Visibility(
            visible: widget.argument != null,
            child: IconButton(
              icon: const Icon(
                Icons.delete_forever_rounded,
                color: Colors.black,
                size: 30,
              ),
              onPressed: () {
                if (widget.argument != null) {
                  _dbHelper.deleteArgument(widget.argument!.id!);
                }

                Navigator.pop(context, true);
              },
            ),
          ),
        ],
      ),
      backgroundColor: Color(0xFFEEEEEE),
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Container(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      TextField(
                        controller: _textEditingController,
                        keyboardType: TextInputType.multiline,
                        maxLines: 2,
                        decoration: const InputDecoration(
                          hintText: "Whats your argument?",
                          border: InputBorder.none,
                        ),
                        style: const TextStyle(
                          fontSize: 30,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(
                          bottom: 8,
                        ),
                        child: Text(
                          "Is it a pro or a con?",
                          style: TextStyle(
                            fontSize: 22,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                right: 9,
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  _isProSelected = true;
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  setState(() {});
                                },
                                child: ProOrConBoxWidget(
                                  isPro: true,
                                  isSelected: _isProSelected == true,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: 9,
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  _isProSelected = false;
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  setState(() {});
                                },
                                child: ProOrConBoxWidget(
                                  isPro: false,
                                  isSelected: _isProSelected == false,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.only(
                          top: 32,
                          bottom: 8,
                        ),
                        child: Text(
                          "How important is it?",
                          style: TextStyle(
                            fontSize: 22,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      /*
                      Container(
                        margin: const EdgeInsets.only(
                          top: 20,
                          left: 20,
                          right: 20,
                        ),
                        padding: const EdgeInsets.all(
                          16,
                        ),
                        child: const Text("1"),
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                              width: 2
                            ),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(5),
                            ),
                        ),
                      ),
                      */
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                right: 9,
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  _valueSelected = 1;
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  setState(() {});
                                },
                                child: ImportanceBoxWidget(
                                  value: 1,
                                  isProSelected: _isProSelected ?? true,
                                  isSelected: _valueSelected == 1,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: 9,
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  _valueSelected = 2;
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  setState(() {});
                                },
                                child: ImportanceBoxWidget(
                                  value: 2,
                                  isProSelected: _isProSelected ?? true,
                                  isSelected: _valueSelected == 2,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),

                      Padding(
                        padding: const EdgeInsets.only(
                          top: 18,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  right: 9,
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    _valueSelected = 3;
                                    FocusManager.instance.primaryFocus?.unfocus();
                                    setState(() {});
                                  },
                                  child: ImportanceBoxWidget(
                                    value: 3,
                                    isProSelected: _isProSelected ?? true,
                                    isSelected: _valueSelected == 3,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 9,
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    _valueSelected = 4;
                                    FocusManager.instance.primaryFocus?.unfocus();
                                    setState(() {});
                                  },
                                  child: ImportanceBoxWidget(
                                    value: 4,
                                    isProSelected: _isProSelected ?? true,
                                    isSelected: _valueSelected == 4,
                                  ),
                                ),
                              ),
                            )
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
                    onPressed: _isValidFilled() ? _saveArgumentAndGoBack : null,
                    child: const Text("Save"),
                    style: ElevatedButton.styleFrom(
                      onPrimary: Colors.white,
                      primary: _getButtonColor(),
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

  void _saveArgumentAndGoBack() {
    if (_textEditingController.text.isNotEmpty) {
      if (_valueSelected != null && _isProSelected != null) {
        Argument _newArgument = Argument(
          decisionId: widget.decisionId,
          title: _textEditingController.text,
          value: _valueSelected!,
          isPro: _isProSelected! ? 1 : 0,
        );

        if (widget.argument != null) {
          _dbHelper
              .updateArgument(
                widget.argument!.id!,
                widget.decisionId,
                _newArgument.title,
                _newArgument.value,
                _newArgument.isPro,
              )
              .then((value) => {Navigator.pop(context)});
        } else {
          _dbHelper
              .insertArgument(_newArgument)
              .then((value) => {Navigator.pop(context)});
        }
      }
    }
  }

  bool _isValidFilled() {
    return _textEditingController.text.isNotEmpty &&
        _isProSelected != null &&
        _valueSelected != null;
  }

  void _textFieldChanged() {
    setState(() {});
  }

  Color _getButtonColor() {
    if (_isProSelected == true) {
      return const Color(0xFF338162);
    } else if (_isProSelected == false) {
      return const Color(0xFFD11654);
    } else {
      return Colors.grey;
    }
  }
}
