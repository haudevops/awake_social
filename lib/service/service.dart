import 'dart:developer';

import 'package:awake_social/model/news_model/news_api.dart';
import 'package:dio/dio.dart';

class Service {
  Service._internal();

  static final Service instance = Service._internal();

  static const String patchGetNews = 'https://newsapi.org/v2/everything?q=apple&from=2022-06-28&to=2022-06-28&sortBy=popularity&apiKey=6f8fa1654c714e498798a314abde0b94';

  Future<NewsAPI> getGetNews() async {
    final response =
    await Dio().get(patchGetNews);

    log('Response API: $response');

    if (response.statusCode != 200) {
      return NewsAPI(status: 'error', message: response.statusMessage);
    }

    return NewsAPI.fromJson(response.data!);
  }
}