import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:awake_social/base/base.dart';
import 'package:awake_social/page/page_export.dart';
import 'package:awake_social/res/res.dart';
import 'package:awake_social/utils/constants.dart';
import 'package:awake_social/utils/prefs_util.dart';
import 'package:awake_social/utils/screen_util/screen_util.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginPage extends BasePage {
  const LoginPage({Key? key}) : super(key: key);
  static const routeName = '/LoginPage';

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends BasePageState<LoginPage, BaseBloc> {
  final _userNameController = TextEditingController();
  final _userPasswordController = TextEditingController();

  final _userNameKey = GlobalKey<FormState>();
  final _userPasswordKey = GlobalKey<FormState>();

  final _userNameFocus = FocusNode();
  final _userPasswordFocus = FocusNode();

  late String _token;
  late String _password;

  @override
  void onCreate() {
    _hiddenKeyBoard();
  }

  @override
  void onDestroy() {
    // TODO: implement onDestroy
  }

  List<Color> colorizeColors = [
    Colors.white,
    Colors.black,
    Colors.white,
    Colors.grey,
    Colors.white,
  ];

  void _hiddenKeyBoard() {
    Future.delayed(const Duration(),
        () => SystemChannels.textInput.invokeMethod('TextInput.hide'));
  }

  @override
  Widget buildWidget(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColor.backgroundPage,
      body: _bodyWidget(),
    );
  }

  Widget _bodyWidget() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(50)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: AnimatedTextKit(
              repeatForever: true,
              animatedTexts: [
                ColorizeAnimatedText(
                  'Awake Foods',
                  speed: const Duration(milliseconds: 500),
                  textStyle: TextStyle(
                    fontSize: ScreenUtil().setSp(40),
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                  colors: colorizeColors,
                ),
              ],
            ),
          ),
          SizedBox(height: ScreenUtil().setHeight(50)),
          Form(
            key: _userNameKey,
            child: TextFormField(
              focusNode: _userNameFocus,
              autofocus: true,
              controller: _userNameController,
              cursorColor: Colors.white,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Nhập tài khoản',
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
                if (_userNameKey.currentState!.validate()) {
                  FocusScope.of(context).unfocus();
                  FocusScope.of(context).requestFocus(_userPasswordFocus);
                } else {
                  FocusScope.of(context).requestFocus(_userNameFocus);
                }
              },
              validator: (value) {
                if (value!.isEmpty ||
                    RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
                  return 'Nhập tài khoản';
                } else {
                  return null;
                }
              },
            ),
          ),
          SizedBox(height: ScreenUtil().setHeight(20)),
          Form(
            key: _userPasswordKey,
            child: TextFormField(
              focusNode: _userPasswordFocus,
              autofocus: false,
              controller: _userPasswordController,
              cursorColor: Colors.white,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Nhập mật khẩu',
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
              validator: (value) {
                if (value!.isEmpty ||
                    RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
                  return 'Sai mật khẩu';
                } else {
                  return null;
                }
              },
            ),
          ),
          SizedBox(height: ScreenUtil().setHeight(20)),
          Center(
            child: SizedBox(
              width: ScreenUtil().setWidth(250),
              child: ElevatedButton(
                  onPressed: () {
                    if (_userNameKey.currentState!.validate() &&
                        _userPasswordKey.currentState!.validate()) {
                      _token = _userNameController.text +
                          _userPasswordController.text;
                      _password = _userPasswordController.text;
                      if (kDebugMode) {
                        print('Token: $_token');
                      }
                      PrefsUtil.putString(Constants.LOGIN_TOKEN, _token);
                      PrefsUtil.putString(Constants.LOGIN_PASSWORD, _password);
                      Navigator.pushNamed(context, HomePage.routeName)
                          .then((value) {
                        _userPasswordController.clear();
                        FocusScope.of(context).requestFocus(_userPasswordFocus);
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    elevation: 1,
                  ),
                  child: Text(
                    'Đăng nhập',
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(16),
                      color: Colors.black,
                    ),
                  )),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Bạn chưa có tài khoản? ',
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(16),
                  color: Colors.white,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Đăng ký',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: ScreenUtil().setSp(16),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
