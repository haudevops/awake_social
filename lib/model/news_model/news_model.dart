class NewsModel{
  NewsModel({this.status, this.data});

  factory NewsModel.fromJson(Map<String, dynamic> json){
    return NewsModel(
      status: json['status'],
      data: (json['data'] != null)
        ? List<ItemNews>.from(
        json['data'].map((x) => ItemNews.fromJson(x)))
        : null,
    );
  }

  bool? status;
  List<ItemNews>? data;
}

class ItemNews{
  ItemNews({this.userName, this.avatar, this.content, this.linkImg});

  factory ItemNews.fromJson(Map<String, dynamic> json){
    return ItemNews(
      userName: json['userName'],
      avatar: json['avatar'],
      content: json['content'],
      linkImg: json['linkImg']
    );
  }

  String? userName;
  String? avatar;
  String? content;
  String? linkImg;
}