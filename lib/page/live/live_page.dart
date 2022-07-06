import 'package:awake_social/base/base.dart';
import 'package:awake_social/page/page_export.dart';
import 'package:flutter/material.dart';

class LivePage extends BasePage<LiveBloc> {
  const LivePage({Key? key}) : super(key: key);
  static const routeName = '/LivePage';

  @override
  State<StatefulWidget> createState() => _LivePageState();
}

class _LivePageState extends BasePageState<LivePage, LiveBloc> {
  @override
  void onCreate() {
  }

  @override
  void onDestroy() {
    // TODO: implement onDestroy
  }

  @override
  Widget buildWidget(BuildContext context) {
    return const Center(
      child: Text(
        'Live Page',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
