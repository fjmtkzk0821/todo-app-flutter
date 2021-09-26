import 'package:flutter/widgets.dart';

Widget tapFocusDetector({
  BuildContext context,
  Widget child
}) {
  return GestureDetector(
    onTap: () {
      FocusManager.instance.primaryFocus?.unfocus();
      // FocusScopeNode currentFocus = FocusScope.of(context);
      // if(!currentFocus.hasPrimaryFocus) currentFocus.unfocus();
    },
    child: child,
  );
}