// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
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
  String get localeName => 'en';

  static m0(dateString) => "First will start at ${dateString}";

  static m1(status) => "mark as ${status}";

  static m2(name) => "Confirm delete todo [${name}]?";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "lbCancel" : MessageLookupByLibrary.simpleMessage("cancel"),
    "lbCreate" : MessageLookupByLibrary.simpleMessage("create"),
    "lbDay" : MessageLookupByLibrary.simpleMessage("Day"),
    "lbDelete" : MessageLookupByLibrary.simpleMessage("Delete"),
    "lbDisplay" : MessageLookupByLibrary.simpleMessage("display"),
    "lbEvery" : MessageLookupByLibrary.simpleMessage("every"),
    "lbExpired" : MessageLookupByLibrary.simpleMessage("expired"),
    "lbFinish" : MessageLookupByLibrary.simpleMessage("finish"),
    "lbImportant" : MessageLookupByLibrary.simpleMessage("Important"),
    "lbInterval" : MessageLookupByLibrary.simpleMessage("interval"),
    "lbMonth" : MessageLookupByLibrary.simpleMessage("Month"),
    "lbNo" : MessageLookupByLibrary.simpleMessage("No"),
    "lbSave" : MessageLookupByLibrary.simpleMessage("save"),
    "lbSort" : MessageLookupByLibrary.simpleMessage("sort"),
    "lbToday" : MessageLookupByLibrary.simpleMessage("Today"),
    "lbUndefined" : MessageLookupByLibrary.simpleMessage("undefined"),
    "lbUnfinished" : MessageLookupByLibrary.simpleMessage("unfinished"),
    "lbWeek" : MessageLookupByLibrary.simpleMessage("Week"),
    "lbYear" : MessageLookupByLibrary.simpleMessage("Year"),
    "lbYes" : MessageLookupByLibrary.simpleMessage("Yes"),
    "phFirstStart" : m0,
    "phMarkAs" : m1,
    "phMemo" : MessageLookupByLibrary.simpleMessage("memo"),
    "phNewList" : MessageLookupByLibrary.simpleMessage("Create new list"),
    "phNewTodo" : MessageLookupByLibrary.simpleMessage("new todo"),
    "phSetExpiryDate" : MessageLookupByLibrary.simpleMessage("set expiry date"),
    "phSetRepeat" : MessageLookupByLibrary.simpleMessage("set repeat"),
    "phTodoDeleteMsg" : m2
  };
}
