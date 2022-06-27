import 'package:awake_social/base/base.dart';
import 'package:awake_social/page/page_export.dart';
import 'package:awake_social/utils/screen_util/screen_util.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingPage extends BasePage {
  const SettingPage({Key? key}) : super(key: key);
  static const routeName = '/SettingPage';

  @override
  State<StatefulWidget> createState() => _SettingPageState();
}

class _SettingPageState extends BasePageState<SettingPage, BaseBloc> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> _logout() async {
    final SharedPreferences prefs = await _prefs;
    prefs.clear();
  }

  @override
  Widget buildWidget(BuildContext context) {
    return _bodyWidget();
  }

  Widget _bodyWidget() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _cardFunctions(
            title: 'Logout',
            checkTrailing: true,
            widget: const Icon(Icons.logout),
            onTap: () async {
              _logout();
              await Navigator.pushNamedAndRemoveUntil(context, SplashPage.routeName, (route) => false);
            },
          ),
        ],
      ),
    );
  }

  Widget _cardFunctions(
      {String? title,
      bool checkTrailing = false,
      Widget? widget,
      GestureTapCallback? onTap}) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 1,
      child: ListTile(
        leading: widget,
        title: Text(
          title ?? 'User',
          style: TextStyle(fontSize: ScreenUtil().setSp(16)),
        ),
        trailing: checkTrailing
            ? Icon(
                Icons.navigate_next,
                size: ScreenUtil().setHeight(26),
              )
            : const SizedBox(),
        onTap: onTap,
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
