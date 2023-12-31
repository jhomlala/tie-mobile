import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:game/src/hamster/model/hamster_tile.dart';

class HamsterDialog {
  static Future<void> showTileQuestionDialog({
    required BuildContext context,
    required HamsterTile tile,
    required void Function() onWrongAnswer,
  }) async {
    final deviceSize = context.deviceSize();
    final imageSize = deviceSize.shortestSide / 4;
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        var isWrongAnswerSelected = false;
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('What is on this image?'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Image.network(tile.config!.imageUrl, width: imageSize),
                    if (isWrongAnswerSelected)
                      const Text(
                        'Wrong answer! Please try again',
                        style: TextStyle(color: Colors.red),
                      ),
                  ],
                ),
              ),
              actions: tile.config?.answers
                  .map(
                    (answer) => TextButton(
                      onPressed: () {
                        if (answer.isCorrect) {
                          Navigator.of(context).pop();
                        } else {
                          setState(() {
                            onWrongAnswer();
                            isWrongAnswerSelected = true;
                          });
                        }
                      },
                      child: Text(
                        answer.name,
                      ),
                    ),
                  )
                  .toList(),
            );
          },
        );
      },
    );
  }

  static Future<void> showHamsterDialog(
    BuildContext context,
    HamsterTile tile,
  ) async {
    final deviceSize = context.deviceSize();
    final imageSize = deviceSize.shortestSide / 4;
    return showDialog<void>(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Congratulations! You have found hamster!'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Image.network(tile.config!.imageUrl, width: imageSize),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
