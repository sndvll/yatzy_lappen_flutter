import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:yatzy_lappen/store/store.dart';

import '../../constants.dart';
import 'buttons.dart';

class AddPlayerDialog extends StatelessWidget {
  final _textEditingController = TextEditingController();

  void _close(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
        content: SingleChildScrollView(
          child: ListBody(
            children: [
              Text(AppConstants.ADD_PLAYER_DESCRIPTION),
              TextField(
                controller: _textEditingController,
                decoration: const InputDecoration(
                  hintText: AppConstants.NAME,
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircularButton.icon(
                          icon: Icons.exit_to_app,
                          backgroundColor: Colors.black38,
                          onPressed: () => _close(context)),
                      StoreConnector<AppState, ButtonClickCallback>(
                          converter: (store) {
                            return () {
                              store.dispatch(
                                  AddPlayerAction(_textEditingController.text));
                              _close(context);
                            };
                          },
                          builder: (context, callback) => CircularButton.icon(
                                backgroundColor: Colors.black,
                                icon: Icons.add,
                                onPressed: callback,
                              ))
                    ],
                  ))
            ],
          ),
        ),
      );
}
