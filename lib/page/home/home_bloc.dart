import 'package:awake_social/base/base.dart';
import 'package:awake_social/model/news_model/news_api.dart';
import 'package:awake_social/model/story_model/story_model.dart';
import 'package:awake_social/service/repository_service.dart';
import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc extends BaseBloc {
  final _getStoryController = BehaviorSubject<List<ItemStory>>();
  final _getNewsController = BehaviorSubject<NewsAPI>();

  Stream<List<ItemStory>> get outStory => _getStoryController.stream;
  Stream<NewsAPI> get outNews => _getNewsController.stream;

  final List<ItemStory> _data = [];

  Future<void> getStory() async {
    _data.addAll(
      [
        ItemStory(
            img:
            "https://c0.wallpaperflare.com/preview/285/409/234/landscape-travel-night-city.jpg"),
        ItemStory(
            img:
            "https://i.pinimg.com/originals/49/70/95/49709513a60e6ed50b9ca9e2f0f36d6a.jpg"),
        ItemStory(
            img:
            "https://images.unsplash.com/photo-1503410759647-41040b696833?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTN8fHR1cm58ZW58MHx8MHx8&w=1000&q=80"),
        ItemStory(img: "https://wallpaperaccess.com/full/4132185.jpg"),
        ItemStory(img: "https://wallpaperaccess.com/full/4132507.jpg"),
        ItemStory(
            img:
            "https://windows10spotlight.com/wp-content/uploads/2021/01/44f0ba090b0faddc627218601798a02a.jpg"),
        ItemStory(img: "https://file.vfo.vn/hinh/2018/05/thanh-pho-da-lat.jpg"),
      ]
    );

    _getStoryController.sink.add(_data);
  }

  Future<void> getNews() async {
    showLoading();
    await Repository.instance.getNews().then((value) {
      if(value.status == 'ok'){
        _getNewsController.sink.add(value);
      }
    }).catchError((e){
      if (kDebugMode) print(e.toString());
    });
    hiddenLoading();
  }



  @override
  void onCreate() {
    getStory();
    getNews();
  }

  @override
  void dispose() {
    _getStoryController.close();
  }
}
