// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ja locale. All the
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
  String get localeName => 'ja';

  static m0(dateString) => "最初は ${dateString} から始まります";

  static m1(status) => "${status} としてマーク";

  static m2(name) => "仕事 [${name}] の削除を確認しますか?";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "lbCancel" : MessageLookupByLibrary.simpleMessage("キャンセル"),
    "lbCreate" : MessageLookupByLibrary.simpleMessage("作成"),
    "lbDay" : MessageLookupByLibrary.simpleMessage("日"),
    "lbDelete" : MessageLookupByLibrary.simpleMessage("削除"),
    "lbDisplay" : MessageLookupByLibrary.simpleMessage("表示"),
    "lbEvery" : MessageLookupByLibrary.simpleMessage("毎"),
    "lbExpired" : MessageLookupByLibrary.simpleMessage("期限切れ"),
    "lbFinish" : MessageLookupByLibrary.simpleMessage("仕上げ"),
    "lbImportant" : MessageLookupByLibrary.simpleMessage("重要"),
    "lbInterval" : MessageLookupByLibrary.simpleMessage("間隔"),
    "lbMonth" : MessageLookupByLibrary.simpleMessage("月"),
    "lbNo" : MessageLookupByLibrary.simpleMessage("いいえ"),
    "lbSave" : MessageLookupByLibrary.simpleMessage("保存"),
    "lbSort" : MessageLookupByLibrary.simpleMessage("ソート"),
    "lbToday" : MessageLookupByLibrary.simpleMessage("今日"),
    "lbUndefined" : MessageLookupByLibrary.simpleMessage("未定義"),
    "lbUnfinished" : MessageLookupByLibrary.simpleMessage("未完成"),
    "lbWeek" : MessageLookupByLibrary.simpleMessage("週"),
    "lbYear" : MessageLookupByLibrary.simpleMessage("年"),
    "phFirstStart" : m0,
    "phMarkAs" : m1,
    "phNewList" : MessageLookupByLibrary.simpleMessage("新しいリストを作成"),
    "phNewTodo" : MessageLookupByLibrary.simpleMessage("新しい仕事"),
    "phSetExpiryDate" : MessageLookupByLibrary.simpleMessage("有効期限の設定"),
    "phSetRepeat" : MessageLookupByLibrary.simpleMessage("リピート設定"),
    "phTodoDeleteMsg" : m2
  };
}
