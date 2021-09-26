// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a zh_Hans locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'zh_Hans';

  static m0(dateString) => "首先将从 ${dateString} 开始";

  static m1(status) => "标记为 ${status}";

  static m2(name) => "确认删除待办事项 [${name}]?";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "lbCancel" : MessageLookupByLibrary.simpleMessage("取消"),
    "lbCreate" : MessageLookupByLibrary.simpleMessage("创建"),
    "lbDay" : MessageLookupByLibrary.simpleMessage("天"),
    "lbDelete" : MessageLookupByLibrary.simpleMessage("删除"),
    "lbDisplay" : MessageLookupByLibrary.simpleMessage("显示"),
    "lbEvery" : MessageLookupByLibrary.simpleMessage("每"),
    "lbExpired" : MessageLookupByLibrary.simpleMessage("过期"),
    "lbFinish" : MessageLookupByLibrary.simpleMessage("完成"),
    "lbImportant" : MessageLookupByLibrary.simpleMessage("重要"),
    "lbInterval" : MessageLookupByLibrary.simpleMessage("间隔"),
    "lbMonth" : MessageLookupByLibrary.simpleMessage("月"),
    "lbNo" : MessageLookupByLibrary.simpleMessage("否"),
    "lbSave" : MessageLookupByLibrary.simpleMessage("保存"),
    "lbSort" : MessageLookupByLibrary.simpleMessage("排序"),
    "lbToday" : MessageLookupByLibrary.simpleMessage("今天"),
    "lbUndefined" : MessageLookupByLibrary.simpleMessage("未定义"),
    "lbUnfinished" : MessageLookupByLibrary.simpleMessage("未完成"),
    "lbWeek" : MessageLookupByLibrary.simpleMessage("周"),
    "lbYear" : MessageLookupByLibrary.simpleMessage("年"),
    "lbYes" : MessageLookupByLibrary.simpleMessage("是"),
    "phFirstStart" : m0,
    "phMarkAs" : m1,
    "phMemo" : MessageLookupByLibrary.simpleMessage("备忘录"),
    "phNewList" : MessageLookupByLibrary.simpleMessage("创建新列表"),
    "phNewTodo" : MessageLookupByLibrary.simpleMessage("新作品"),
    "phSetExpiryDate" : MessageLookupByLibrary.simpleMessage("设置到期日期"),
    "phSetRepeat" : MessageLookupByLibrary.simpleMessage("设置重复"),
    "phTodoDeleteMsg" : m2
  };
}
