import 'package:awake_social/base/base.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HomePage extends BasePage {
  const HomePage({Key? key}) : super(key: key);
  static const routeName = '/HomePage';

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends BasePageState<HomePage, BaseBloc> {
  @override
  Widget buildWidget(BuildContext context) {
    return const Center(
      child: Text(
        'Hello',
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  @override
  void onCreate() {
    if (kDebugMode) print('Home Page');
  }

  @override
  void onDestroy() {
    // TODO: implement onDestroy
  }
}