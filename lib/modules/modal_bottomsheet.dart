import 'package:flutter/material.dart';

class ModalButtomSheet {
  BuildContext context1;
  ModalButtomSheet({required this.context1});

  show() async {
    await showModalBottomSheet(
      isDismissible: false,
      context: context1,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          color: Colors.blueGrey,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Text('Modal BottomSheet'),
                ElevatedButton(
                  child: const Text('Close BottomSheet'),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
