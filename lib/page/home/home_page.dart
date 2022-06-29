import 'dart:convert';

import 'package:awake_social/base/base.dart';
import 'package:awake_social/model/news_model/news_model.dart';
import 'package:awake_social/page/page_export.dart';
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

  @override
  Widget buildWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(
        ScreenUtil().setWidth(8),
      ),
      child: ListView(
        shrinkWrap: true,
        children: [
          _storyWidget(),
          _listNewItems(),
        ],
      )
    );
  }
  Widget _storyWidget() {
    return SizedBox(
      height: ScreenUtil().setHeight(200),
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

  // Widget _storyWidget() {
  //   return SizedBox(
  //     height: ScreenUtil().setHeight(200),
  //     child: StreamBuilder<List<ItemStory>>(
  //       stream: getBloc.outStory,
  //       builder: (context, snapshot) {
  //         if (!snapshot.hasData) {
  //           return const SizedBox();
  //         }
  //         return ListView.builder(
  //           itemCount: snapshot.data?.length,
  //           shrinkWrap: true,
  //           scrollDirection: Axis.horizontal,
  //           itemBuilder: (context, index) {
  //             return Container(
  //               margin: EdgeInsets.only(
  //                 right: ScreenUtil().setWidth(8),
  //               ),
  //               child: ClipRRect(
  //                 borderRadius: BorderRadius.circular(8),
  //                 child: Image.network(
  //                   snapshot.data?[index].img ?? '',
  //                   width: ScreenUtil().setHeight(120),
  //                   fit: BoxFit.cover,
  //                 ),
  //               ),
  //             );
  //           },
  //         );
  //       },
  //     ),
  //   );
  // }

  Widget _listNewItems() {
    return SizedBox(
      child: ListView.builder(
        itemCount: _newsModel?.data?.length ?? 0,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return _newsWidget(_newsModel!.data?[index]);
        },
      ),
    );
  }

  Widget _newsWidget(ItemNews? data) {
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(
                  height: ScreenUtil().setHeight(25),
                  width: ScreenUtil().setWidth(25),
                  child: SvgPicture.asset('${data?.avatar}')),
              SizedBox(
                width: ScreenUtil().setWidth(10),
              ),
              Text(
                '${data?.userName}',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: ScreenUtil().setSp(16),
                ),
              ),
            ],
          ),
          SizedBox(
            height: ScreenUtil().setHeight(10),
          ),
          SizedBox(
            child: Image.network('${data?.linkImg}'),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(10),
          ),
          Text(
            '${data?.content}',
            style: TextStyle(
              color: Colors.white,
              fontSize: ScreenUtil().setSp(16),
            ),
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}
