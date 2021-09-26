import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/generated/l10n.dart';
import 'package:todo_app/objects/todo_list_obj.dart';
import 'package:todo_app/ui/fragments/ipt_todo_fragment.dart';
import 'package:todo_app/ui/fragments/td_todo_fragment.dart';
import 'package:todo_app/utils/base_message.dart';
import 'package:todo_app/utils/dialog_manager.dart';
import 'package:todo_app/viewmodels/storage_view_model.dart';

class AppDrawer extends StatelessWidget {
  void popNewTodoListDialog(BuildContext context, StorageViewModel viewModel) {
    TodoListObj listObj = TodoListObj.empty();
    Provider.of<DialogManager>(context, listen: false)
        .showCustomDialog(
            context,
            StatefulBuilder(
                builder: (context, setState) => AlertDialog(
                      title: Text('new list'),
                      content: Container(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextFormField(
                              autofocus: true,
                              decoration: InputDecoration(
                                  hintText: 'input todo list title'),
                              initialValue: listObj.title,
                              onChanged: (value) {
                                listObj.title = value;
                              },
                            ),
                          ],
                        ),
                      ),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context, false);
                            },
                            child: Text('cancel')),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context, true);
                            },
                            child: Text('create'))
                      ],
                    )),
            true)
        .then((value) async {
      if (value ?? false) {
        BaseMessage result = await viewModel.insertTodoList(listObj);
        if (result.type == MessageType.SUCCESS) {
          viewModel.changeCurrentTodoList(listObj.id);
          Navigator.of(context, rootNavigator: true)
              .popUntil((route) => route.isFirst);
          Navigator.pop(context);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    S localization = S.of(context);
    return Container(
      width: MediaQuery.of(context).size.width * 0.6,
      child: Drawer(
        child: Consumer<StorageViewModel>(
          builder: (context, vm, child) {
            Map<String, TodoListObj> todoListMap = vm.storageModel.todoListMap;
            return Column(
              children: [
                SizedBox(
                  height: 45,
                ),
                Divider(
                  height: 1,
                ),
                ListTile(
                  onTap: () {
                    vm.changeCurrentTodoList(TDTodoFragment.label);
                    Navigator.pop(context);
                  },
                  leading: Icon(Icons.wb_sunny_sharp),
                  title: Text(localization.lbToday),
                  // trailing: Text(
                  //     '${vm.getTodoByDateTime(DateTime.now()).length}'),
                ),
                ListTile(
                  leading: Icon(Icons.star_border_sharp),
                  onTap: () {
                    vm.changeCurrentTodoList(IPTTodoFragment.label);
                    Navigator.pop(context);
                  },
                  title: Text(localization.lbImportant),
                ),
                Divider(
                  height: 1,
                ),
                Expanded(
                    child: ListView.builder(
                        itemCount: todoListMap.keys.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: Icon(Icons.list),
                            onTap: () {
                              vm.changeCurrentTodoList(
                                  todoListMap.keys.elementAt(index));
                              Navigator.pop(context);
                            },
                            title: Text((todoListMap.values
                                        .elementAt(index)
                                        .id ==
                                    'undefined')
                                ? localization.lbUndefined
                                : todoListMap.values.elementAt(index).title),
                            trailing: Text(
                                '${todoListMap.values.elementAt(index).todoObjs.length}'),
                          );
                        })),
                ListTile(
                  tileColor: Theme.of(context).accentColor,
                  title: Text(
                    localization.phNewList,
                    style: TextStyle(color: Colors.black),
                  ),
                  trailing: Icon(
                    Icons.post_add,
                    color: Colors.black,
                  ),
                  onTap: () {
                    popNewTodoListDialog(context, vm);
                  },
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
