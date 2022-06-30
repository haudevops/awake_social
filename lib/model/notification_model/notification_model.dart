class NotificationModel{
  NotificationModel({this.status, this.data});

  factory NotificationModel.fromJson(Map<String, dynamic> json){
    return NotificationModel(
      status: json['status'],
      data: (json['data'] != null)
          ? List<ItemNotification>.from(
          json['data'].map((x) => ItemNotification.fromJson(x)))
          : null,
    );
  }

  bool? status;
  List<ItemNotification>? data;
}

class ItemNotification {

  ItemNotification({this.avatar, this.content, this.timeSend});

  factory ItemNotification.fromJson(Map<String, dynamic> json){
    return ItemNotification(
      avatar: json['avatar'],
      content: json['content'],
      timeSend: json['timeSend'],
    );
  }

  String? avatar;
  String? content;
  String? timeSend;
}