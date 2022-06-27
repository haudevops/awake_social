import 'package:awake_social/base/base.dart';
import 'package:awake_social/model/story_model/story_model.dart';
import 'package:awake_social/page/page_export.dart';
import 'package:awake_social/utils/screen_util/screen_util.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HomePage extends BasePage<HomeBloc> {
  HomePage({Key? key}) : super(key: key, bloc: HomeBloc());
  static const routeName = '/HomePage';

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends BasePageState<HomePage, HomeBloc> {
  @override
  void onCreate() {
    if (kDebugMode) print('Home Page');
  }

  @override
  void onDestroy() {}

  @override
  Widget buildWidget(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          _storyWidget(),
        ],
      ),
    );
  }

  Widget _storyWidget() {
    return Container(
      height: ScreenUtil().setHeight(200),
      margin: EdgeInsets.symmetric(
        vertical: ScreenUtil().setWidth(8),
      ),
      child: StreamBuilder<List<ItemStory>>(
        stream: getBloc.outStory,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox();
          }
          return ListView.builder(
            itemCount: snapshot.data?.length,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(8),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    snapshot.data?[index].img ?? '',
                    width: ScreenUtil().setHeight(120),
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
