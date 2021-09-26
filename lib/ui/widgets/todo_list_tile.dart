import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:todo_app/objects/todo_obj.dart';

Widget todoListTile({
  TodoObj todoObj,
  Function onTap,
  Function onFinishTap,
  Function onImportantTap,
}) {
  return Card(
    margin: EdgeInsets.symmetric(horizontal: 0, vertical: 4),
    shape: BeveledRectangleBorder(),
    child: InkWell(
      onTap: onTap,
      child: Row(
        children: [
          IconButton(
            icon: Icon((todoObj.isFinish)
                ? Icons.check_circle
                : Icons.radio_button_unchecked),
            onPressed: onFinishTap,
          ),
          Expanded(
              child: Text(
            todoObj.title,
            style: (todoObj.isFinish)
                ? TextStyle(decoration: TextDecoration.lineThrough)
                : null,
          )),
          IconButton(
            icon: Icon((todoObj.isImportant) ? Icons.star : Icons.star_border),
            onPressed: (!todoObj.isFinish)?onImportantTap: null,
          ),
        ],
      ),
    ),
  );
}
