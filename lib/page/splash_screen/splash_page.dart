import 'package:awake_social/base/base_bloc.dart';
import 'package:awake_social/base/base_page.dart';
import 'package:awake_social/page/page_export.dart';
import 'package:awake_social/res/asset_path.dart';
import 'package:awake_social/utils/screen_util/size_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class SplashPage extends BasePage {
  static const routeName = '/';

  const SplashPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SplashPageState();
}

class _SplashPageState extends BasePageState<SplashPage, BaseBloc> {
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

  @override
  void onCreate() {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, LoginPage.routeName);
    });
  }

  @override
  void onDestroy() {}
}
