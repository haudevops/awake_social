import 'package:awake_social/base/base.dart';
import 'package:awake_social/utils/screen_util/screen_util.dart';
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
      body: Container(
        height: ScreenUtil().screenHeight,
        width: ScreenUtil().screenWidth,
        padding: EdgeInsets.all(ScreenUtil().setHeight(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(
                  top: ScreenUtil().setHeight(100),
                  bottom: ScreenUtil().setHeight(20)),
              child: Text(
                'Change Password'.toUpperCase(),
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: ScreenUtil().setSp(35),
                  color: Colors.white,
                ),
              ),
            ),
            _changePassword(),
          ],
        ),
      ),
    );
  }

  Widget _changePassword() {
    return Column(
      children: [
        SizedBox(height: ScreenUtil().setHeight(20)),
        Form(
          key: _currentPassKey,
          child: TextFormField(
            focusNode: _currentPassFocus,
            autofocus: true,
            controller: _currentPassController,
            cursorColor: Colors.white,
            decoration: InputDecoration(
              labelText: 'Enter old password',
              labelStyle: const TextStyle(color: Colors.white),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 1.5, color: Colors.grey),
                borderRadius: BorderRadius.circular(15),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 2, color: Colors.white),
                borderRadius: BorderRadius.circular(15),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 2, color: Colors.red),
                borderRadius: BorderRadius.circular(15),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 2, color: Colors.red),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            onFieldSubmitted: (value) {
              if (_currentPassKey.currentState!.validate()) {
                FocusScope.of(context).unfocus();
                FocusScope.of(context).requestFocus(_newPassFocus);
              } else {
                FocusScope.of(context).requestFocus(_currentPassFocus);
              }
            },
            validator: (value) {
              if (value!.isEmpty ||
                  RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
                if (_currentPassController.text != _oldPass) {
                  return 'Do not the same password';
                }
                return 'Wrong password';
              } else {
                return null;
              }
            },
          ),
        ),
        SizedBox(height: ScreenUtil().setHeight(20)),
        Form(
          key: _newPassKey,
          child: TextFormField(
            focusNode: _newPassFocus,
            autofocus: false,
            controller: _newPassController,
            cursorColor: Colors.white,
            decoration: InputDecoration(
              labelText: 'Enter new password',
              labelStyle: const TextStyle(color: Colors.white),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 1.5, color: Colors.grey),
                borderRadius: BorderRadius.circular(15),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 2, color: Colors.white),
                borderRadius: BorderRadius.circular(15),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 2, color: Colors.red),
                borderRadius: BorderRadius.circular(15),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 2, color: Colors.red),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            onFieldSubmitted: (value) {
              if (_newPassKey.currentState!.validate()) {
                FocusScope.of(context).unfocus();
                FocusScope.of(context).requestFocus(_retypePassFocus);
              } else {
                FocusScope.of(context).requestFocus(_newPassFocus);
              }
            },
            validator: (value) {
              if (value!.isEmpty ||
                  RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
                return 'Wrong password';
              } else {
                return null;
              }
            },
          ),
        ),
        SizedBox(height: ScreenUtil().setHeight(20)),
        Form(
          key: _retypePassKey,
          child: TextFormField(
            focusNode: _retypePassFocus,
            autofocus: false,
            controller: _retypePassController,
            cursorColor: Colors.white,
            decoration: InputDecoration(
              labelText: 'Enter new password again',
              labelStyle: const TextStyle(color: Colors.white),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 1.5, color: Colors.grey),
                borderRadius: BorderRadius.circular(15),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 2, color: Colors.white),
                borderRadius: BorderRadius.circular(15),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 2, color: Colors.red),
                borderRadius: BorderRadius.circular(15),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 2, color: Colors.red),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            onFieldSubmitted: (value) {
              if (_retypePassKey.currentState!.validate()) {
                FocusScope.of(context).unfocus();
              } else {
                FocusScope.of(context).requestFocus(_retypePassFocus);
              }
            },
            validator: (value) {
              if (value!.isEmpty ||
                  RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
                return 'Wrong password';
              } else {
                return null;
              }
            },
          ),
        ),
        SizedBox(height: ScreenUtil().setHeight(20)),
        Center(
          child: Container(
            width: ScreenUtil().setWidth(200),
            child: ElevatedButton(
                onPressed: () {
                  if (_currentPassKey.currentState!.validate() &&
                      _newPassKey.currentState!.validate() &&
                      _retypePassKey.currentState!.validate()) {}
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  elevation: 1,
                ),
                child: Text(
                  'Change password'.toUpperCase(),
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(16),
                    color: Colors.black
                  ),
                )),
          ),
        ),
      ],
    );
  }
}
