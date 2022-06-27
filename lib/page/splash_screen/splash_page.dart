import 'package:awake_social/base/base_bloc.dart';
import 'package:awake_social/base/base_page.dart';
import 'package:awake_social/page/page_export.dart';
import 'package:awake_social/res/asset_path.dart';
import 'package:awake_social/utils/constants.dart';
import 'package:awake_social/utils/prefs_util.dart';
import 'package:awake_social/utils/screen_util/size_extension.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SplashPage extends BasePage {
  static const routeName = '/';

  const SplashPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SplashPageState();
}

class _SplashPageState extends BasePageState<SplashPage, BaseBloc> {
  String? token;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  void onCreate() {
    _checkToken();
  }

  @override
  void onDestroy() {}

  Future<void> _checkToken() async {
    final SharedPreferences prefs = await _prefs;
    token = prefs.getString(Constants.LOGIN_TOKEN);
    if(token != null && token!.isNotEmpty){
      if (kDebugMode) print('Token: $token');
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pushReplacementNamed(context, NavigationPage.routeName);
      });
    }else{
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pushReplacementNamed(context, LoginPage.routeName);
      });
    }
  }

  @override
  Widget buildWidget(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: SvgPicture.asset(
          AssetPath.icMachineLearning,
          color: Colors.white,
          width: 150.w,
          height: 150.h,
        ),
      ),
    );
  }
}
