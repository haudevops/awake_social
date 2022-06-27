import 'package:awake_social/base/base.dart';
import 'package:flutter/material.dart';

class NotificationPage extends BasePage {
  const NotificationPage({Key? key}) : super(key: key);
  static const routeName ='/NotificationPage';

  @override
  State<StatefulWidget> createState() => _NotificationPageState();
}

class _NotificationPageState extends BasePageState<NotificationPage, BaseBloc> {
  @override
  Widget buildWidget(BuildContext context) {
    return const Center(
      child: Text(
        'Notification Page',
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
