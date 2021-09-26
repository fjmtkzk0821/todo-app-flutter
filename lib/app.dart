import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/generated/l10n.dart';
import 'package:todo_app/ui/app_holder.dart';
import 'package:todo_app/ui/pages/setting_page.dart';
import 'package:todo_app/ui/pages/splash_page.dart';
import 'package:todo_app/ui/tap_focus_detector.dart';
import 'package:todo_app/utils/app_config.dart';
import 'package:todo_app/utils/dialog_manager.dart';
import 'package:todo_app/viewmodels/storage_view_model.dart';

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider<AppConfig>(
          create: (_) => AppConfig()),
      ChangeNotifierProvider<DialogManager>(create: (_) => DialogManager()),
      ChangeNotifierProvider<StorageViewModel>(
          create: (_) => StorageViewModel()),
    ],
    child: tapFocusDetector(
        context: context,
        child: Consumer<AppConfig>(builder: (context, appConfig, child) {
          return MaterialApp(
            title: 'Flutter Demo',
            localizationsDelegates: [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            theme: (appConfig.getThemeMode())?ThemeData(
                brightness: Brightness.dark,
                primarySwatch: Colors.orange,
                accentColor: Colors.orange,
                floatingActionButtonTheme: FloatingActionButtonThemeData(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.orange
                )
            ):ThemeData(
                brightness: Brightness.light,
                primarySwatch: Colors.orange,
                scaffoldBackgroundColor: Colors.grey
            ),
            initialRoute: '/splash',
            routes: {
              '/splash': (_) => SplashPage(),
              '/index': (_) => AppHolder(),
              '/setting': (_) => SettingPage()
            },
          );
        })
    ));
  }
}
