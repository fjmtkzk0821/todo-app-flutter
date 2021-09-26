import 'dart:isolate';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:todo_app/app_router.dart';
import 'package:todo_app/ui/app_drawer.dart';
import 'package:todo_app/ui/fragments/todo_create_fragment.dart';

class AppHolder extends StatefulWidget {
  static final GlobalKey<ScaffoldState> appKey = GlobalKey();
  @override
  State<StatefulWidget> createState() => _AppHolderState();
}

class _AppHolderState extends State<AppHolder> {
  final GlobalKey<NavigatorState> naviKey = GlobalKey();
  int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: AppHolder.appKey,
      drawer: AppDrawer(),
      body: Focus(
        child: Navigator(
          key: naviKey,
          //initialRoute: '/index',
          onGenerateRoute: (settings) {
            return MaterialPageRoute(
                builder: AppRouter.findRouteByKey(settings.name));
          },
        ),
        onFocusChange: (hasFocus) {
          if(!hasFocus) FocusManager.instance.primaryFocus?.unfocus();
        },
      ),
      bottomNavigationBar: AppBottomAppBar(
        naviKey: naviKey,
        notchMargin: 6,
        fabLocation: FloatingActionButtonLocation.centerDocked,
        shape: AutomaticNotchedShape(
            RoundedRectangleBorder(),
            BeveledRectangleBorder(
                borderRadius: BorderRadius.circular(28))),
      ),
      floatingActionButton: FloatingActionButton(
        shape:
        BeveledRectangleBorder(borderRadius: BorderRadius.circular(25)),
        child: Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              useRootNavigator: true,
              builder: (context) {
                return TodoCreateFragment();
              });
        },
      ),
      floatingActionButtonLocation:
      FloatingActionButtonLocation.centerDocked,
    );
  }
}

class AppBottomAppBar extends StatelessWidget {
  final GlobalKey<NavigatorState> naviKey;
  final FloatingActionButtonLocation fabLocation;
  final NotchedShape shape;
  final double notchMargin;

  AppBottomAppBar({Key key, this.naviKey, this.fabLocation, this.shape, this.notchMargin})
      : super(key: key);


  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      notchMargin: notchMargin,
      shape: shape,
      child: Row(
        children: [
          IconButton(
              icon: Icon(Icons.dehaze),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              }),
          Spacer(),
          IconButton(icon: Icon(Icons.settings), onPressed: () {
            Navigator.of(context,rootNavigator: true).pushNamed('/setting');
          }),
        ],
      ),
    );
  }
}
