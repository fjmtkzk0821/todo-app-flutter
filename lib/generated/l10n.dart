// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values

class S {
  S();
  
  static S current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      S.current = S();
      
      return S.current;
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Today`
  String get lbToday {
    return Intl.message(
      'Today',
      name: 'lbToday',
      desc: 'The conventional newborn programmer greeting',
      args: [],
    );
  }

  /// `Important`
  String get lbImportant {
    return Intl.message(
      'Important',
      name: 'lbImportant',
      desc: '',
      args: [],
    );
  }

  /// `save`
  String get lbSave {
    return Intl.message(
      'save',
      name: 'lbSave',
      desc: '',
      args: [],
    );
  }

  /// `sort`
  String get lbSort {
    return Intl.message(
      'sort',
      name: 'lbSort',
      desc: '',
      args: [],
    );
  }

  /// `display`
  String get lbDisplay {
    return Intl.message(
      'display',
      name: 'lbDisplay',
      desc: '',
      args: [],
    );
  }

  /// `finish`
  String get lbFinish {
    return Intl.message(
      'finish',
      name: 'lbFinish',
      desc: '',
      args: [],
    );
  }

  /// `unfinished`
  String get lbUnfinished {
    return Intl.message(
      'unfinished',
      name: 'lbUnfinished',
      desc: '',
      args: [],
    );
  }

  /// `undefined`
  String get lbUndefined {
    return Intl.message(
      'undefined',
      name: 'lbUndefined',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get lbDelete {
    return Intl.message(
      'Delete',
      name: 'lbDelete',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get lbYes {
    return Intl.message(
      'Yes',
      name: 'lbYes',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get lbNo {
    return Intl.message(
      'No',
      name: 'lbNo',
      desc: '',
      args: [],
    );
  }

  /// `cancel`
  String get lbCancel {
    return Intl.message(
      'cancel',
      name: 'lbCancel',
      desc: '',
      args: [],
    );
  }

  /// `create`
  String get lbCreate {
    return Intl.message(
      'create',
      name: 'lbCreate',
      desc: '',
      args: [],
    );
  }

  /// `expired`
  String get lbExpired {
    return Intl.message(
      'expired',
      name: 'lbExpired',
      desc: '',
      args: [],
    );
  }

  /// `every`
  String get lbEvery {
    return Intl.message(
      'every',
      name: 'lbEvery',
      desc: '',
      args: [],
    );
  }

  /// `interval`
  String get lbInterval {
    return Intl.message(
      'interval',
      name: 'lbInterval',
      desc: '',
      args: [],
    );
  }

  /// `Day`
  String get lbDay {
    return Intl.message(
      'Day',
      name: 'lbDay',
      desc: '',
      args: [],
    );
  }

  /// `Week`
  String get lbWeek {
    return Intl.message(
      'Week',
      name: 'lbWeek',
      desc: '',
      args: [],
    );
  }

  /// `Month`
  String get lbMonth {
    return Intl.message(
      'Month',
      name: 'lbMonth',
      desc: '',
      args: [],
    );
  }

  /// `Year`
  String get lbYear {
    return Intl.message(
      'Year',
      name: 'lbYear',
      desc: '',
      args: [],
    );
  }

  /// `new todo`
  String get phNewTodo {
    return Intl.message(
      'new todo',
      name: 'phNewTodo',
      desc: '',
      args: [],
    );
  }

  /// `Create new list`
  String get phNewList {
    return Intl.message(
      'Create new list',
      name: 'phNewList',
      desc: '',
      args: [],
    );
  }

  /// `mark as {status}`
  String phMarkAs(Object status) {
    return Intl.message(
      'mark as $status',
      name: 'phMarkAs',
      desc: '',
      args: [status],
    );
  }

  /// `set expiry date`
  String get phSetExpiryDate {
    return Intl.message(
      'set expiry date',
      name: 'phSetExpiryDate',
      desc: '',
      args: [],
    );
  }

  /// `set repeat`
  String get phSetRepeat {
    return Intl.message(
      'set repeat',
      name: 'phSetRepeat',
      desc: '',
      args: [],
    );
  }

  /// `memo`
  String get phMemo {
    return Intl.message(
      'memo',
      name: 'phMemo',
      desc: '',
      args: [],
    );
  }

  /// `Confirm delete todo [{name}]?`
  String phTodoDeleteMsg(Object name) {
    return Intl.message(
      'Confirm delete todo [$name]?',
      name: 'phTodoDeleteMsg',
      desc: '',
      args: [name],
    );
  }

  /// `First will start at {dateString}`
  String phFirstStart(Object dateString) {
    return Intl.message(
      'First will start at $dateString',
      name: 'phFirstStart',
      desc: '',
      args: [dateString],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ja'),
      Locale.fromSubtags(languageCode: 'zh'),
      Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hans'),
      Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hant'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}