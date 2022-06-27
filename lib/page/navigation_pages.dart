import 'package:awake_social/base/base.dart';
import 'package:awake_social/page/home/home_page.dart';
import 'package:awake_social/page/page_export.dart';
import 'package:awake_social/page/people_social/people_social_page.dart';
import 'package:awake_social/utils/screen_util/screen_util.dart';
import 'package:flutter/material.dart';

class NavigationPage extends BasePage {
  const NavigationPage({Key? key}) : super(key: key);
  static const routeName = '/NavigationPage';

  @override
  State<StatefulWidget> createState() => _NavigationPageState();
}

class _NavigationPageState extends BasePageState<NavigationPage, BaseBloc>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  Widget buildWidget(BuildContext context) {
    return DefaultTabController(
      length: 5,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            'Awake Foods',
            style: TextStyle(
                fontSize: ScreenUtil().setSp(25),
                color: Colors.white,
                fontWeight: FontWeight.w600),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.search,
                size: ScreenUtil().setSp(25),
                color: Colors.white,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.message,
                size: ScreenUtil().setSp(25),
                color: Colors.white,
              ),
            ),
          ],
          bottom: TabBar(
            controller: _tabController,
            tabs: [
              SizedBox(
                height: ScreenUtil().setHeight(50),
                child: Icon(
                  Icons.home,
                  size: ScreenUtil().setSp(25),
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(50),
                child: Icon(
                  Icons.person,
                  size: ScreenUtil().setSp(25),
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(50),
                child: Icon(
                  Icons.live_tv,
                  size: ScreenUtil().setSp(25),
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(50),
                child: Icon(
                  Icons.notifications,
                  size: ScreenUtil().setSp(25),
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(50),
                child: Icon(
                  Icons.list_outlined,
                  size: ScreenUtil().setSp(25),
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        body: _bodyWidget(),
      ),
    );
  }

  Widget _bodyWidget() {
    return TabBarView(
      controller: _tabController,
      children: const [
        HomePage(),
        PeopleSocialPage(),
        LivePage(),
        NotificationPage(),
        SettingPage(),
      ],
    );
  }

  @override
  void onCreate() {
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void onDestroy() {
    _tabController.dispose();
  }
}
