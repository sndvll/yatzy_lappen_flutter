import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../constants.dart';
import '../../store/store.dart';

import 'buttons.dart';

class AddPlayerDialog extends StatelessWidget {
  final _textEditingController = TextEditingController();

  void _close(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
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
                    FlatButton(
                      child: Text(AppConstants.BUTTON_CLOSE),
                      color: Colors.black12,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    StoreConnector<GameState, ButtonClickCallback>(
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
}
