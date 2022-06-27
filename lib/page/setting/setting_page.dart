import 'package:awake_social/base/base.dart';
import 'package:flutter/material.dart';

class SettingPage extends BasePage {
  const SettingPage({Key? key}) : super(key: key);
  static const routeName ='/SettingPage';

  @override
  State<StatefulWidget> createState() => _SettingPageState();
}

class _SettingPageState extends BasePageState<SettingPage, BaseBloc> {
  @override
  Widget buildWidget(BuildContext context) {
    return const Center(
      child: Text(
        'Setting Page',
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  @override
  void onCreate() {
    // TODO: implement onCreate
  }

  @override
  void onDestroy() {
    // TODO: implement onDestroy
  }
}
