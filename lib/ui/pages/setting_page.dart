import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          children: [
            ListTile(leading: Icon(Icons.info),title: Text('about'),)
          ],
        ),
      ),
    );
  }
}