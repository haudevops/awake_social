class NewsAPI {
  NewsAPI({this.status, this.totalResults, this.articles, this.message});

  factory NewsAPI.fromJson(Map<String, dynamic> json){
    return NewsAPI(
      status: json['status'],
      totalResults: json['totalResults'],
      articles: (json['articles'] != null)
          ? List<Articles>.from(
          json['articles'].map((x) => Articles.fromJson(x)))
          : null,
      message: json['message']
    );
  }

  String? status;
  int? totalResults;
  List<Articles>? articles;
  String? message;
}

class Articles {
  Articles(
      {this.author,
      this.title,
      this.description,
      this.url,
      this.urlToImage,
      this.publishedAt,
      this.content});

  factory Articles.fromJson(Map<String, dynamic> json){
    return Articles(
      author: json['author'],
      title: json['title'],
      description: json['description'],
      url: json['url'],
      urlToImage: json['urlToImage'],
      publishedAt: json['publishedAt'],
      content: json['content']
    );
  }

  String? author;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  String? publishedAt;
  String? content;
}
