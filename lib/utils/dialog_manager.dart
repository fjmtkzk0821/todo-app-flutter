import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/generated/l10n.dart';
import 'package:todo_app/utils/base_message.dart';

class DialogManager extends ChangeNotifier {

  Future<dynamic> showCustomDialog(BuildContext context,Widget content, bool dismissible) async {
    return await showDialog(context: context, builder: (_) => content,
    barrierDismissible: dismissible);
  }

  Future<bool> showDefaultDialog(BuildContext context, BaseMessage message,bool decision) async {
    S localization = S.of(context);
    return await showDialog(context: context, builder: (_) => AlertDialog(
      title: Text(message.title),
      content: SingleChildScrollView(
        child: Column(
          children: [Text(message.desc)],
        ),
      ),
      actions: (!decision)? <Widget>[
        TextButton(onPressed: () {
          Navigator.of(context,rootNavigator: true).pop(true);
        }, child: Text('OK'))
      ]: <Widget>[
        TextButton(onPressed: () {
          Navigator.of(context,rootNavigator: true).pop(false);
        }, child: Text(localization.lbNo)),
        ElevatedButton(onPressed: () {
          Navigator.of(context,rootNavigator: true).pop(true);
        }, child: Text(localization.lbYes))
      ],
    ));
  }
}