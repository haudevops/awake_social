import 'package:awake_social/base/base.dart';
import 'package:awake_social/routers/screen_arguments.dart';
import 'package:awake_social/utils/screen_util/screen_util.dart';
import 'package:flutter/material.dart';

class HomeDetailPage extends BasePage {
  const HomeDetailPage({Key? key, required this.data}) : super(key: key);
  final ScreenArguments data;
  static const routeName = '/HomeDetailPage';

  @override
  State<StatefulWidget> createState() => _HomeDetailPageState();
}

class _HomeDetailPageState extends BasePageState<HomeDetailPage, BaseBloc> {
  String? linkImg;
  String? content;

  @override
  void onCreate() {
    linkImg = widget.data.arg1;
    content = widget.data.arg2;
  }

  @override
  void onDestroy() {
    // TODO: implement onDestroy
  }

  @override
  Widget buildWidget(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Chiêm ngưỡng',
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: ScreenUtil().setSp(18),
              color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SizedBox(
        child: Column(
          children: [
            Hero(
              tag: 'dash',
              child: Image.network(
                linkImg ?? '',
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              child: Text(
                content ?? '',
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(16),
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
