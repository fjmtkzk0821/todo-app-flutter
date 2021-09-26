import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TodoSection extends StatefulWidget {
  final String section;
  final List<Widget> children;

  const TodoSection({Key key, this.section, this.children}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TodoSectionState();
}

class _TodoSectionState extends State<TodoSection> {
  bool isExpanded;

  @override
  void initState() {
    super.initState();
    isExpanded = true;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.section != null)
          ElevatedButton(
            style: ElevatedButton.styleFrom(shape: BeveledRectangleBorder()),
            onPressed: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('${widget.section} ${widget.children.length}'),
                SizedBox(
                  width: 10,
                ),
                (isExpanded)
                    ? Icon(Icons.expand_more)
                    : Icon(Icons.expand_less),
              ],
            ),
          ),
        if (isExpanded)
          Column(
            children: widget.children,
          )
      ],
    );
  }
}
