import 'package:awake_social/model/news_model/news_api.dart';
import 'package:awake_social/service/service.dart';

class Repository {
  Repository._internal();

  static final Repository instance = Repository._internal();

  Future<NewsAPI> getNews() async {
    return await Service.instance.getGetNews();
  }
}
