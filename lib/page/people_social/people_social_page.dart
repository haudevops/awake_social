import 'package:awake_social/base/base.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PeopleSocialPage extends BasePage {
  const PeopleSocialPage({Key? key}) : super(key: key);
  static const routeName = '/PeopleSocialPage';

  @override
  State<StatefulWidget> createState() => _PeopleSocialPageState();
}

class _PeopleSocialPageState extends BasePageState<PeopleSocialPage, BaseBloc> {
  @override
  Widget buildWidget(BuildContext context) {
    return const Center(
      child: Text(
        'People',
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  @override
  void onCreate() {
    if (kDebugMode) print('People Page');
  }

  @override
  void onDestroy() {
    // TODO: implement onDestroy
  }
}
