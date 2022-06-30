import 'dart:convert';

import 'package:awake_social/base/base.dart';
import 'package:awake_social/model/news_model/news_api.dart';
import 'package:awake_social/model/news_model/news_model.dart';
import 'package:awake_social/page/page_export.dart';
import 'package:awake_social/res/colors.dart';
import 'package:awake_social/routers/screen_arguments.dart';
import 'package:awake_social/utils/screen_util/screen_util.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends BasePage<HomeBloc> {
  HomePage({Key? key}) : super(key: key, bloc: HomeBloc());
  static const routeName = '/HomePage';

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends BasePageState<HomePage, HomeBloc> {
  String? _data;
  NewsModel? _newsModel;

  @override
  void onCreate() {
    if (kDebugMode) print('Home Page');
    _parseJson();
  }

  @override
  void onDestroy() {}

  void _parseJson() async {
    _data = await DefaultAssetBundle.of(context)
        .loadString("assets/data/news_data.json");
    final jsonResult = jsonDecode(_data!);
    if (kDebugMode) print(jsonResult);
    setState(() {
      _newsModel = NewsModel.fromJson(jsonResult);
    });
  }

  Future<void> _refresh() async{
    await getBloc.getNews();
  }

  @override
  Widget buildWidget(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(
          ScreenUtil().setWidth(8),
        ),
        child: RefreshIndicator(
          onRefresh: () async {
            await _refresh();
          },
          color: Colors.black,
          backgroundColor: Colors.white,
          child: ListView(
            shrinkWrap: true,
            children: [
              _storyWidget(),
              _listNewItems(),
            ],
          ),
        ));
  }

  Widget _storyWidget() {
    return Container(
      height: ScreenUtil().setHeight(200),
      margin: EdgeInsets.only(
        right: ScreenUtil().setWidth(8),
      ),
      child: ListView.builder(
        itemCount: _newsModel?.data?.length ?? 0,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(
              right: ScreenUtil().setWidth(8),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                _newsModel!.data?[index].linkImg ?? '',
                width: ScreenUtil().setHeight(120),
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _listNewItems() {
    return Container(
      child: StreamBuilder<NewsAPI>(
        stream: getBloc.outNews,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox();
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(
              color: Colors.white,
              backgroundColor: AppColor.backgroundCard,
            );
          }
          return Expanded (
            child: ListView.builder(
              itemCount: snapshot.data?.articles?.length,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return _newsWidget(snapshot.data?.articles?[index]);
              },
            ),
          );
        },
      ),
    );
  }

  Widget _newsWidget(Articles? data) {
    return Container(
      width: ScreenUtil().screenWidth,
      padding: EdgeInsets.all(ScreenUtil().setHeight(10)),
      margin: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(10)),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.all(
          Radius.circular(
            ScreenUtil().setHeight(8),
          ),
        ),
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(
            context,
            HomeDetailPage.routeName,
            arguments:
                ScreenArguments(arg1: data?.urlToImage, arg2: data?.content),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              child: Row(
                children: [
                  SizedBox(
                      height: ScreenUtil().setHeight(25),
                      width: ScreenUtil().setWidth(25),
                      child: SvgPicture.asset('assets/svg/ic_tensorflow.svg')),
                  SizedBox(
                    width: ScreenUtil().setWidth(10),
                  ),
                  Text(
                    data?.author ?? 'Incognito',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: ScreenUtil().setSp(16),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(10),
            ),
            SizedBox(
              child: data?.urlToImage != null ? Image.network('${data?.urlToImage}') : const SizedBox(),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(10),
            ),
            SizedBox(
              child: Text(
                '${data?.description}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: ScreenUtil().setSp(16),
                ),
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ),
      ),
    );
  }
}
