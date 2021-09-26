// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a zh_Hant locale. All the
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
  String get localeName => 'zh_Hant';

  static m0(dateString) => "將從 ${dateString} 開始";

  static m1(status) => "標記為 ${status}";

  static m2(name) => "確認刪除待辦事項 [${name}]?";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "lbCancel" : MessageLookupByLibrary.simpleMessage("取消"),
    "lbCreate" : MessageLookupByLibrary.simpleMessage("創建"),
    "lbDay" : MessageLookupByLibrary.simpleMessage("天"),
    "lbDelete" : MessageLookupByLibrary.simpleMessage("刪除"),
    "lbDisplay" : MessageLookupByLibrary.simpleMessage("顯示"),
    "lbEvery" : MessageLookupByLibrary.simpleMessage("每"),
    "lbExpired" : MessageLookupByLibrary.simpleMessage("過期"),
    "lbFinish" : MessageLookupByLibrary.simpleMessage("完成"),
    "lbImportant" : MessageLookupByLibrary.simpleMessage("重要"),
    "lbInterval" : MessageLookupByLibrary.simpleMessage("間隔"),
    "lbMonth" : MessageLookupByLibrary.simpleMessage("月"),
    "lbNo" : MessageLookupByLibrary.simpleMessage("否"),
    "lbSave" : MessageLookupByLibrary.simpleMessage("保存"),
    "lbSort" : MessageLookupByLibrary.simpleMessage("排序"),
    "lbToday" : MessageLookupByLibrary.simpleMessage("今天"),
    "lbUndefined" : MessageLookupByLibrary.simpleMessage("未定義"),
    "lbUnfinished" : MessageLookupByLibrary.simpleMessage("未完成"),
    "lbWeek" : MessageLookupByLibrary.simpleMessage("週"),
    "lbYear" : MessageLookupByLibrary.simpleMessage("年"),
    "lbYes" : MessageLookupByLibrary.simpleMessage("是"),
    "phFirstStart" : m0,
    "phMarkAs" : m1,
    "phMemo" : MessageLookupByLibrary.simpleMessage("備忘錄"),
    "phNewList" : MessageLookupByLibrary.simpleMessage("創建新列表"),
    "phNewTodo" : MessageLookupByLibrary.simpleMessage("新待辦事項"),
    "phSetExpiryDate" : MessageLookupByLibrary.simpleMessage("設置到期日"),
    "phSetRepeat" : MessageLookupByLibrary.simpleMessage("設置重複"),
    "phTodoDeleteMsg" : m2
  };
}
