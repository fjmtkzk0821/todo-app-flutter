import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/generated/l10n.dart';
import 'package:todo_app/objects/todo_obj.dart';
import 'package:todo_app/ui/tap_focus_detector.dart';
import 'package:todo_app/utils/base_message.dart';
import 'package:todo_app/utils/common_tools.dart';
import 'package:todo_app/utils/dialog_manager.dart';
import 'package:todo_app/viewmodels/storage_view_model.dart';

class TodoDetailPage extends StatefulWidget {
  final TodoObj todoObj;

  const TodoDetailPage({Key key, this.todoObj}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TodoDetailPageState();
}

class _TodoDetailPageState extends State<TodoDetailPage> {
  TodoObj _tmpTodoObj;

  @override
  void initState() {
    super.initState();
    _tmpTodoObj = TodoObj.fromMap(widget.todoObj.toMap());
  }

  Future<bool> _onWillPop() async {
    // FocusManager.instance.primaryFocus?.unfocus();
    Provider.of<StorageViewModel>(context, listen: false)
        .updateTodo(widget.todoObj, _tmpTodoObj);
    return true;
  }

  void popSelectBelongDialog() {
    Provider.of<DialogManager>(context, listen: false).showCustomDialog(
        context,
        AlertDialog(
          title: Text('[select list]'),
          content: Container(
            height: MediaQuery.of(context).size.height / 2,
            width: MediaQuery.of(context).size.width * 0.8,
            child: ListView(
              shrinkWrap: true,
              children: [],
            ),
          ),
          actions: [],
        ),
        true);
  }

  Future<BaseMessage> popRepeatDialog(DateTime startDate) async {
    RepeatPeriodObj obj = RepeatPeriodObj(
        json: _tmpTodoObj.period, startDate: startDate ?? DateTime.now());

    void _onSchClipTap(Function setState, int value) {
      if (obj.scheduleInWeek.contains(value)) {
        setState(() {
          obj.scheduleInWeek.remove(value);
        });
      } else {
        obj.scheduleInWeek.add(value);
        setState(() {
          obj.scheduleInWeek.sort((a, b) => a < b ? 0 : 1);
        });
      }
    }

    bool status = await Provider.of<DialogManager>(context, listen: false)
        .showCustomDialog(context,
            StatefulBuilder(builder: (context, setState) {
      DateTime firstSchDate = obj.startDate.add(Duration()) ?? DateTime.now();
      int firstStartWeekday = -1;
      for (int weekday in obj.scheduleInWeek) {
        if (firstStartWeekday != -1) {
          firstStartWeekday = (firstSchDate.weekday - weekday).abs() <
                  (firstSchDate.weekday - firstStartWeekday).abs()
              ? weekday
              : firstStartWeekday;
        } else {
          firstStartWeekday = weekday;
        }
      }
      firstSchDate = firstSchDate.add(Duration(
          days: firstStartWeekday >= firstSchDate.weekday
              ? (firstSchDate.weekday - firstStartWeekday).abs()
              : (firstSchDate.weekday - (firstStartWeekday + 7)).abs()));
      return Center(
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width * (0.8),
            child: Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 6),
                    child: FittedBox(
                      child: Row(
                        children: [
                          Text('every'),
                          ...[1, 2, 3]
                              .map((e) => ActionChip(
                                    backgroundColor:
                                        obj.scheduleInWeek.contains(e)
                                            ? Colors.blueAccent
                                            : null,
                                    label: Text('$e'),
                                    onPressed: () => _onSchClipTap(setState, e),
                                  ))
                              .toList()
                        ],
                      ),
                    ),
                  )
                  //schedule in week (chip)
                  ,
                  FittedBox(
                    child: Row(
                      children: [4, 5, 6, 7]
                          .map((e) => ActionChip(
                                backgroundColor: obj.scheduleInWeek.contains(e)
                                    ? Colors.blueAccent
                                    : null,
                                label: Text('$e'),
                                onPressed: () => _onSchClipTap(setState, e),
                              ))
                          .toList(),
                    ),
                  ),
                  //interval
                  FittedBox(
                    child: Row(
                      children: [
                        Text('interval'),
                        SizedBox(
                          width: 6,
                        ),
                        DropdownButton<int>(
                          value: obj.interval,
                          items: [1, 2, 3, 4, 5, 6, 7, 8, 9]
                              .map((e) => DropdownMenuItem(
                                    child: Text('$e'),
                                    value: e,
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              obj.interval = value;
                            });
                          },
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        DropdownButton<String>(
                          value: obj.type,
                          items: ['day', 'week', 'month', 'year']
                              .map((e) => DropdownMenuItem(
                                    child: Text('$e'),
                                    value: e,
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              obj.type = value;
                            });
                          },
                        )
                      ],
                    ),
                  ),
                  //set start day
                  // FittedBox(
                  //   child: Row(
                  //     children: [
                  //       Text('start at'),
                  //       ElevatedButton(
                  //           onPressed: () {
                  //             var tmpDate = DateTime.now();
                  //             showDatePicker(
                  //                 context: context,
                  //                 initialDate: _tmpTodoObj.expiredDate,
                  //                 firstDate: DateTime(tmpDate.year - 25, 1),
                  //                 lastDate: DateTime(tmpDate.year + 25, 12))
                  //                 .then((value) {
                  //               if (value != null) {
                  //                 setState(() {
                  //                   obj.startDate = value;
                  //                 });
                  //               }
                  //             });
                  //           },
                  //           child: Text(CommonTools.outputTimeFormat
                  //               .format(obj.startDate)))
                  //     ],
                  //   ),
                  // ),
                  Text(
                      'First will start at [${CommonTools.outputTimeFormat.format(firstSchDate)}]'),
                  ButtonBar(
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context, false);
                          },
                          child: Text('cancel')),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context, true);
                          },
                          child: Text('finish'))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      );
    }), true);
    if (status != null && status) {
      _tmpTodoObj.period = obj.toJson();
      return BaseMessage(MessageType.SUCCESS,
          title: "repeat set", action: () => obj.startDate);
    } else {
      return BaseMessage(MessageType.WARNING, title: "action cancel");
    }
  }

  @override
  Widget build(BuildContext context) {
    S localization = S.of(context);
    return WillPopScope(
        child: Consumer<StorageViewModel>(builder: (context, vm, child) {
          return tapFocusDetector(
              context: context,
              child: Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  foregroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.close),
                  ),
                  bottom: PreferredSize(
                    preferredSize: Size(double.maxFinite, 52),
                    child: ListTile(
                      title: Text(
                        _tmpTodoObj.title,
                        style: (_tmpTodoObj.isFinish)
                            ? TextStyle(decoration: TextDecoration.lineThrough)
                            : null,
                      ),
                    ),
                  ),
                  actions: [
                    IconButton(
                        icon: Icon(Icons.delete_sharp),
                        onPressed: () {
                          Provider.of<DialogManager>(context, listen: false)
                              .showDefaultDialog(
                                  context,
                                  BaseMessage(MessageType.DIALOG,
                                      title: localization.lbDelete, desc: localization.phTodoDeleteMsg(_tmpTodoObj.title)),
                                  true)
                              .then((value) {
                            if (value ?? false) {
                              vm.deleteTodo(widget.todoObj);
                              Navigator.pop(context);
                            }
                          });
                        })
                  ],
                ),
                body: Container(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ListTile(
                          dense: true,
                          leading: Icon(Icons.view_list_sharp),
                          title: Text((_tmpTodoObj.belong == 'undefined')?localization.lbUndefined: _tmpTodoObj.belong),
                          // onTap: () {
                          //   popSelectBelongDialog();
                          // },
                        ),
                        ListTile(
                          dense: true,
                          leading: Icon(Icons.calendar_today_sharp),
                          title: Text(_tmpTodoObj.expiredDate != null
                              ? DateFormat.yMMMMEEEEd(Intl.getCurrentLocale()).format(_tmpTodoObj.expiredDate)
                              : localization.phSetExpiryDate),
                          onTap: () {
                            var tmpDate = DateTime.now();
                            showDatePicker(
                                    context: context,
                                    initialDate:
                                        _tmpTodoObj.expiredDate ?? tmpDate,
                                    firstDate: DateTime(tmpDate.year - 25, 1),
                                    lastDate: DateTime(tmpDate.year + 25, 12))
                                .then((value) {
                              if (value != null) {
                                _tmpTodoObj.expiredDate = DateTime(value.year,
                                    value.month, value.day, 23, 59, 59);
                                _tmpTodoObj.finishedDate = null;
                                _tmpTodoObj.isFinish = false;
                                vm
                                    .updateTodo(widget.todoObj, _tmpTodoObj)
                                    .then((value) => null);
                                setState(() {});
                              }
                            });
                          },
                          trailing: (_tmpTodoObj.expiredDate != null)
                              ? IconButton(
                                  icon: Icon(Icons.close),
                                  onPressed: () {
                                    _tmpTodoObj.expiredDate = null;
                                    _tmpTodoObj.isRepeat = false;
                                    _tmpTodoObj.period = null;
                                    vm
                                        .updateTodo(widget.todoObj, _tmpTodoObj)
                                        .then((value) => null);
                                    setState(() {});
                                  },
                                )
                              : null,
                        ),
                        ListTile(
                          dense: true,
                          leading: Icon(Icons.repeat_sharp),
                          title: Text((_tmpTodoObj.isRepeat)
                              ? '${localization.lbInterval} ${_tmpTodoObj.period['itv']} ${_tmpTodoObj.period['type']}'
                              : localization.phSetRepeat),
                          subtitle: (_tmpTodoObj.isRepeat)
                              ? Text(_tmpTodoObj.period['sch'].join(','))
                              : null,
                          onTap: () {
                            popRepeatDialog(_tmpTodoObj.expiredDate)
                                .then((msg) {
                              if (msg.type == MessageType.SUCCESS) {
                                setState(() {
                                  _tmpTodoObj.isRepeat = true;
                                  _tmpTodoObj.expiredDate = msg.action();
                                });
                                vm.updateTodo(widget.todoObj, _tmpTodoObj);
                              }
                            });
                          },
                          trailing: (_tmpTodoObj.isRepeat)
                              ? IconButton(
                                  icon: Icon(Icons.close),
                                  onPressed: () {
                                    _tmpTodoObj.isRepeat = false;
                                    _tmpTodoObj.period = null;
                                    vm
                                        .updateTodo(widget.todoObj, _tmpTodoObj)
                                        .then((value) => null);
                                    setState(() {});
                                  },
                                )
                              : null,
                        ),
                        if (_tmpTodoObj.expiredDate != null)
                          PopupMenuButton(
                            itemBuilder: (context) => [],
                            child: ListTile(
                              dense: true,
                              leading: Icon(Icons.notifications_sharp),
                              title: Text('set alarm'),
                              onTap: () async {
                                DateTime sch;
                                if (_tmpTodoObj.expiredDate
                                        .difference(DateTime.now())
                                        .inDays <
                                    1) {
                                  sch =
                                      DateTime.now().add(Duration(seconds: 30));
                                } else {
                                  sch = DateTime(
                                      _tmpTodoObj.expiredDate.year,
                                      _tmpTodoObj.expiredDate.month,
                                      _tmpTodoObj.expiredDate.day,
                                      0,
                                      0,
                                      5);
                                }
                                if (_tmpTodoObj.notification == -1)
                                  vm.setNotification(
                                      widget.todoObj, _tmpTodoObj, sch);
                                else
                                  vm.cancelNotification(
                                      widget.todoObj, _tmpTodoObj);
                              },
                            ),
                          ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Focus(
                            child: TextFormField(
                              autofocus: false,
                              maxLines: null,
                              keyboardType: TextInputType.multiline,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: localization.phMemo),
                              initialValue: _tmpTodoObj.memo,
                              onChanged: (val) => _tmpTodoObj.memo = val,
                              onEditingComplete: () {
                                if (_tmpTodoObj.memo.length != 0)
                                  vm
                                      .updateTodo(widget.todoObj, _tmpTodoObj)
                                      .then((value) => null);
                              },
                            ),
                            onFocusChange: (hasFocus) {
                              if (!hasFocus) {
                                FocusManager.instance.primaryFocus?.unfocus();
                                vm
                                    .updateTodo(widget.todoObj, _tmpTodoObj)
                                    .then((value) => null);
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                bottomNavigationBar: BottomAppBar(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      children: [
                        if (widget.todoObj.finishedDate != null)
                          Text('[finish time]'),
                        Spacer(),
                        TextButton(
                            onPressed: () {
                              setState(() {
                                _tmpTodoObj.isFinish = !_tmpTodoObj.isFinish;
                              });
                              vm
                                  .updateTodoFinishStatus(widget.todoObj)
                                  .then((value) {
                                if (_tmpTodoObj.isFinish)
                                  Navigator.pop(context);
                              });
                            },
                            child: Text((_tmpTodoObj.isFinish)
                                ? localization.phMarkAs(localization.lbUnfinished)
                                : localization.phMarkAs(localization.lbFinish)))
                      ],
                    ),
                  ),
                ),
              ));
        }),
        onWillPop: _onWillPop);
  }
}
