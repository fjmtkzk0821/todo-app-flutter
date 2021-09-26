import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/generated/l10n.dart';
import 'package:todo_app/objects/todo_obj.dart';
import 'package:todo_app/utils/base_message.dart';
import 'package:todo_app/utils/common_tools.dart';
import 'package:todo_app/utils/dialog_manager.dart';
import 'package:todo_app/viewmodels/storage_view_model.dart';

class TodoCreateFragment extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TodoCreateFragmentState();
}

class _TodoCreateFragmentState extends State<TodoCreateFragment> {
  final _titleController = TextEditingController();
  bool onMemo = false;
  TodoObj _todoObj;

  @override
  void initState() {
    super.initState();
    _todoObj = TodoObj.empty();
  }

  Future<BaseMessage> popRepeatDialog(DateTime startDate) async {
    RepeatPeriodObj obj = RepeatPeriodObj(
        json: _todoObj.period, startDate: startDate ?? DateTime.now());

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
                  //schedule in week (chip)
                  FittedBox(
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
                  FittedBox(
                    child: Row(
                      children: [
                        Text('start at'),
                        ElevatedButton(
                            onPressed: () {
                              var tmpDate = DateTime.now();
                              showDatePicker(
                                      context: context,
                                      initialDate:
                                          _todoObj.expiredDate ?? tmpDate,
                                      firstDate: DateTime(tmpDate.year - 25, 1),
                                      lastDate: DateTime(tmpDate.year + 25, 12))
                                  .then((value) {
                                if (value != null) {
                                  setState(() {
                                    obj.startDate = value;
                                  });
                                }
                              });
                            },
                            child: Text(CommonTools.outputTimeFormat
                                .format(obj.startDate)))
                      ],
                    ),
                  ),
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
      return BaseMessage(MessageType.SUCCESS,
          title: "repeat set",
          action: () => {'startDate': obj.startDate, 'period': obj.toJson()});
    } else {
      return BaseMessage(MessageType.WARNING, title: "action cancel");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom), //set widget padding up then keyboard/bottom
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                autofocus: true,
                decoration: InputDecoration(
                    border: InputBorder.none, hintText: S.of(context).phNewTodo),
                onChanged: (val) => _todoObj.title = val,
              ),
              if (onMemo)
                TextFormField(
                  autofocus: false,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                      border: InputBorder.none, hintText: S.of(context).phMemo),
                  initialValue: _todoObj.memo,
                  onChanged: (val) => _todoObj.memo = val,
                ),
              if (_todoObj.expiredDate != null)
                Chip(
                  label: Text(CommonTools.outputTimeFormat
                      .format(_todoObj.expiredDate)),
                  onDeleted: () {
                    setState(() {
                      _todoObj.expiredDate = null;
                    });
                  },
                ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        onMemo = true;
                      });
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                      child: Icon(
                        Icons.message,
                        size: 20,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      var tmpDate = DateTime.now();
                      showDatePicker(
                              context: context,
                              initialDate: _todoObj.expiredDate ?? tmpDate,
                              firstDate: DateTime(tmpDate.year - 25, 1),
                              lastDate: DateTime(tmpDate.year + 25, 12))
                          .then((value) {
                        if (value != null) {
                          setState(() {
                            _todoObj.expiredDate = value;
                            _todoObj.finishedDate = null;
                            _todoObj.isFinish = false;
                          });
                        }
                      });
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                      child: Icon(
                        Icons.calendar_today_sharp,
                        size: 20,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      popRepeatDialog(_todoObj.expiredDate).then((msg) {
                        if (msg.type == MessageType.SUCCESS) {
                          Map<String, dynamic> result = msg.action();
                          setState(() {
                            _todoObj.isRepeat = true;
                            _todoObj.expiredDate = result['startDate'];
                            _todoObj.period = result['period'];
                          });
                        }
                      });
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                      child: Icon(
                        Icons.repeat,
                        size: 20,
                      ),
                    ),
                  ),
                  Expanded(child: Container()),
                  TextButton(
                      style: ElevatedButton.styleFrom(
                          shape: BeveledRectangleBorder()),
                      onPressed: () async {
                        Provider.of<StorageViewModel>(context, listen: false)
                            .insertTodo(_todoObj);
                        Navigator.pop(context);
                      },
                      child: Text(S.of(context).lbSave))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
