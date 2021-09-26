import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/ui/app_holder.dart';
import 'package:todo_app/utils/app_config.dart';
import 'package:todo_app/utils/mixin/after_layout_mixin.dart';
import 'package:todo_app/viewmodels/splash_view_model.dart';

class SplashPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SplashPageState();
}
class _SplashPageState extends State<SplashPage> with AfterLayoutMixin {
  SplashViewModel _splashViewModel;

  @override
  void initState() {
    super.initState();
    _splashViewModel = SplashViewModel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: ChangeNotifierProvider<SplashViewModel>.value(
              value: _splashViewModel,
              child: Consumer<SplashViewModel>(
                builder: (context, viewModel, child) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FlutterLogo(
                        size: 120,
                      ),
                      if (viewModel.isLoading)
                        CircularProgressIndicator(),
                      if(viewModel.message != null)
                        Text(viewModel.message.title)
                    ],
                  );
                },
              )),
        ),
      ),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) async {
    await Provider.of<AppConfig>(context, listen: false).init();
    await _splashViewModel.loadData();
    Navigator.pushReplacementNamed(context, '/index');
  }
}