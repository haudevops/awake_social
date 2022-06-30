import 'package:awake_social/base/base.dart';
import 'package:flutter/material.dart';

import '../../utils/constants.dart';
import '../../utils/prefs_util.dart';

class ChangePasswordPage extends BasePage {
  const ChangePasswordPage({Key? key}) : super(key: key);
  static const routeName = '/ChangePasswordPage';

  @override
  State<StatefulWidget> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState
    extends BasePageState<ChangePasswordPage, BaseBloc> {
  final _currentPassController = TextEditingController();
  final _newPassController = TextEditingController();
  final _retypePassController = TextEditingController();

  final _currentPassKey = GlobalKey<FormState>();
  final _newPassKey = GlobalKey<FormState>();
  final _retypePassKey = GlobalKey<FormState>();

  final _currentPassFocus = FocusNode();
  final _newPassFocus = FocusNode();
  final _retypePassFocus = FocusNode();

  String? _oldPass;

  @override
  void onCreate() {
    _oldPass = PrefsUtil.getString(Constants.LOGIN_PASSWORD);
  }

  @override
  void onDestroy() {
    // TODO: implement onDestroy
  }

  @override
  Widget buildWidget(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
    );
  }
}
