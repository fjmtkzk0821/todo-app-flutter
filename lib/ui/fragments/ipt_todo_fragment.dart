import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/objects/todo_display_setting_config.dart';
import 'package:todo_app/objects/todo_obj.dart';
import 'package:todo_app/ui/app_holder.dart';
import 'package:todo_app/ui/pages/todo_detail_page.dart';
import 'package:todo_app/ui/widgets/todo_list_tile.dart';
import 'package:todo_app/ui/widgets/todo_section.dart';
import 'package:todo_app/utils/base_message.dart';
import 'package:todo_app/utils/dialog_manager.dart';
import 'package:todo_app/viewmodels/storage_view_model.dart';

class IPTTodoFragment extends StatefulWidget {
  static const String label = 'ipt';

  @override
  State<StatefulWidget> createState() => _IPTTodoFragmentState();
}

class _IPTTodoFragmentState extends State<IPTTodoFragment> {
  ScrollController _scrollController;
  bool shrinkStatus;

  _scrollListener() {
    if (isShrink != shrinkStatus)
      setState(() {
        shrinkStatus = isShrink;
      });
  }

  bool get isShrink {
    return _scrollController.hasClients &&
        _scrollController.offset > (82 - kToolbarHeight);
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Consumer<StorageViewModel>(
      builder: (context, vm, child) {
        BaseMessage msg = vm.getAllImportantTodo();
        Map<String, List<TodoObj>> objsMap = msg.action();

        return CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverAppBar(
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  'Important',
                  style: TextStyle(fontSize: 16),
                ),
                titlePadding:
                    EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                collapseMode: CollapseMode.pin,
                centerTitle: false,
              ),
              actions: [
                IconButton(
                  onPressed: () async {
                    var action = await showMenu(
                        context: AppHolder.appKey.currentContext,
                        position:
                            RelativeRect.fromLTRB(double.maxFinite, 0, 0, 0),
                        items: [
                          PopupMenuItem(
                              value: () async {
                                SortType sortType = await Provider.of<
                                        DialogManager>(context, listen: false)
                                    .showCustomDialog(
                                        context,
                                        AlertDialog(
                                          title: Text('Sort'),
                                          content: SingleChildScrollView(
                                            child: Column(
                                              children: [
                                                ListTile(
                                                  title: Text('Date ASC'),
                                                  onTap: () {
                                                    Navigator.of(context,
                                                            rootNavigator: true)
                                                        .pop(SortType.DATE_ASC);
                                                  },
                                                ),
                                                ListTile(
                                                  title: Text('Date DESC'),
                                                  onTap: () {
                                                    Navigator.of(context,
                                                            rootNavigator: true)
                                                        .pop(
                                                            SortType.DATE_DESC);
                                                  },
                                                ),
                                                ListTile(
                                                  title: Text('Important'),
                                                  onTap: () {
                                                    Navigator.of(context,
                                                            rootNavigator: true)
                                                        .pop(
                                                            SortType.IMPORTANT);
                                                  },
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        true);
                                if (sortType != null) {
                                  vm.changeSortSetting(sortType);
                                }
                              },
                              child: Text('sort setting')),
                          PopupMenuItem(
                              value: () async {
                                int displayRange = await Provider.of<
                                        DialogManager>(context, listen: false)
                                    .showCustomDialog(
                                        context,
                                        AlertDialog(
                                          title: Text('display'),
                                          content: SingleChildScrollView(
                                            child: Column(
                                              children: [
                                                ListTile(
                                                  title: Text('7'),
                                                  onTap: () {
                                                    Navigator.of(context,
                                                            rootNavigator: true)
                                                        .pop(7);
                                                  },
                                                ),
                                                ListTile(
                                                  title: Text('30'),
                                                  onTap: () {
                                                    Navigator.of(context,
                                                            rootNavigator: true)
                                                        .pop(30);
                                                  },
                                                ),
                                                ListTile(
                                                  title: Text('365'),
                                                  onTap: () {
                                                    Navigator.of(context,
                                                            rootNavigator: true)
                                                        .pop(365);
                                                  },
                                                ),
                                                ListTile(
                                                  title: Text('-1'),
                                                  onTap: () {
                                                    Navigator.of(context,
                                                            rootNavigator: true)
                                                        .pop(-1);
                                                  },
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        true);
                                if (displayRange != null) {
                                  vm.changeDisplaySetting(displayRange);
                                }
                              },
                              child: Text('display setting')),
                        ]);
                    if (action != null) action();
                  },
                  icon: Icon(Icons.more_vert),
                )
              ],
              backgroundColor: isShrink ? null : Colors.transparent,
              foregroundColor: Colors.transparent,
              expandedHeight: 82,
              automaticallyImplyLeading: false,
              floating: false,
              pinned: true,
              snap: false,
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TodoSection(
                      children: [
                        if (objsMap['todo'].length > 0)
                          ...objsMap['todo']
                              .map((e) => todoListTile(
                              todoObj: e,
                              onTap: () {
                                Navigator.of(context, rootNavigator: true)
                                    .push(MaterialPageRoute(
                                    builder: (_) => TodoDetailPage(
                                      todoObj: e,
                                    )));
                              },
                              onFinishTap: () {
                                vm.updateTodoFinishStatus(e);
                              },
                              onImportantTap: () {
                                vm.updateTodoImportantStatus(e);
                              }))
                              .toList()
                      ],
                    ),
                    if (objsMap['expired'].length > 0)
                      TodoSection(
                        section: 'expired',
                        children: [
                          ...objsMap['expired']
                              .map((e) => todoListTile(
                              todoObj: e,
                              onTap: () {
                                Navigator.of(context, rootNavigator: true)
                                    .push(MaterialPageRoute(
                                    builder: (_) => TodoDetailPage(
                                      todoObj: e,
                                    )));
                              },
                              onFinishTap: () {
                                vm.updateTodoFinishStatus(e);
                              },
                              onImportantTap: () {
                                vm.updateTodoImportantStatus(e);
                              }))
                              .toList()
                        ],
                      ),
                    if (objsMap['finish'].length > 0)
                      TodoSection(
                        section: 'finish',
                        children: [
                          ...objsMap['finish']
                              .map((e) => todoListTile(
                              todoObj: e,
                              onTap: () {
                                Navigator.of(context, rootNavigator: true)
                                    .push(MaterialPageRoute(
                                    builder: (_) => TodoDetailPage(
                                      todoObj: e,
                                    )));
                              },
                              onFinishTap: () {
                                vm.updateTodoFinishStatus(e);
                              },
                              onImportantTap: () {
                                vm.updateTodoImportantStatus(e);
                              }))
                              .toList()
                        ],
                      ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                )
              ),
            )
          ],
        );
      },
    ));
  }
}
