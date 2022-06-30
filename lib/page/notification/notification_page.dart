import 'dart:convert';

import 'package:awake_social/base/base_bloc.dart';
import 'package:awake_social/base/base_page.dart';
import 'package:awake_social/model/notification_model/notification_model.dart';
import 'package:awake_social/utils/screen_util/screen_util.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NotificationPage extends BasePage {
  const NotificationPage({Key? key}) : super(key: key);
  static const routeName = '/NotificationPage';

  @override
  State<StatefulWidget> createState() => _NotificationPageState();
}

class _NotificationPageState extends BasePageState<NotificationPage, BaseBloc> {
  String? _data;
  NotificationModel? _notificationModel;

  void _parseJson() async {
    _data = await DefaultAssetBundle.of(context)
        .loadString("assets/data/notification_data.json");
    final jsonResult = jsonDecode(_data!);
    if (kDebugMode) print(jsonResult);
    setState(() {
      _notificationModel = NotificationModel.fromJson(jsonResult);
    });
  }

  @override
  void onCreate() {
    _parseJson();
  }

  @override
  void onDestroy() {
    // TODO: implement onDestroy
  }

  Future<void> _refresh() async {}

  @override
  Widget buildWidget(BuildContext context) {
    return _bodyWidget();
  }

  Widget _bodyWidget() {
    return Container(
      padding: EdgeInsets.only(top: ScreenUtil().setHeight(8)),
      child: RefreshIndicator(
        onRefresh: () async {
          await _refresh();
        },
        color: Colors.black,
        backgroundColor: Colors.white,
        child: ListView.separated(
          itemCount: _notificationModel?.data?.length ?? 0,
          separatorBuilder: (BuildContext context, int index) => const Divider(
            color: Colors.grey,
          ),
          itemBuilder: (context, index) {
            return _itemCard(_notificationModel?.data?[index]);
          },
        ),
      ),
    );
  }

  Widget _itemCard(ItemNotification? itemNotification) {
    return Container(
      width: ScreenUtil().screenWidth,
      height: ScreenUtil().setHeight(80),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.all(
          Radius.circular(
            ScreenUtil().setHeight(8),
          ),
        ),
      ),
      child: Slidable(
        endActionPane: const ActionPane(
          motion: ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: null,
              backgroundColor: Color(0xFFFA1111),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
        child: Center(
          child: ListTile(
            dense: true,
            title: Text(
              '${itemNotification?.content}',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: ScreenUtil().setSp(16),
                  fontWeight: FontWeight.w600),
            ),
            leading: SizedBox(
                height: ScreenUtil().setHeight(25),
                width: ScreenUtil().setWidth(25),
                child: SvgPicture.asset('assets/svg/ic_tensorflow.svg')),
          ),
        ),
      ),
    );
  }
}
