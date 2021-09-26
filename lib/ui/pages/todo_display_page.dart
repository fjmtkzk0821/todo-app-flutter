import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/ui/fragments/ipt_todo_fragment.dart';
import 'package:todo_app/ui/fragments/td_todo_fragment.dart';
import 'package:todo_app/ui/fragments/todo_list_fragment.dart';
import 'package:todo_app/viewmodels/storage_view_model.dart';

class TodoDisplayPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<StorageViewModel>(builder: (context, vm, child) {
      switch (vm.currentTodoListId) {
        case TDTodoFragment.label:
          return TDTodoFragment();
        case IPTTodoFragment.label:
          return IPTTodoFragment();
        default:
          return TodoListFragment();
      }
    });
  }
}
