import 'package:awake_social/base/base.dart';
import 'package:awake_social/utils/screen_util/screen_util.dart';
import 'package:flutter/material.dart';

class HomePage extends BasePage {
  const HomePage({Key? key}) : super(key: key);
  static const routeName = '/HomePage';

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends BasePageState<HomePage, BaseBloc>
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
      children: [
        Container(
          child: Center(
            child: Text('Home', style: TextStyle(color: Colors.white),),
          ),
        ),
        Container(
          child: Center(
            child: Text('People', style: TextStyle(color: Colors.white),),
          ),
        ),
        Container(
          child: Center(
            child: Text('Live', style: TextStyle(color: Colors.white),),
          ),
        ),
        Container(
          child: Center(
            child: Text('Notifications', style: TextStyle(color: Colors.white),),
          ),
        ),
        Container(
          child: Center(
            child: Text('Setting', style: TextStyle(color: Colors.white),),
          ),
        ),
      ],
    );
  }

  @override
  void onCreate() {
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void onDestroy() {
    // TODO: implement onDestroy
  }
}
