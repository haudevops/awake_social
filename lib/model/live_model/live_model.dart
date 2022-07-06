class LiveModel {
  LiveModel({this.name, this.year, this.bookId, this.status, this.message});

  factory LiveModel.fromJson(Map<String, dynamic> json) {
    return LiveModel(
      name: json['name'],
      year: json['year'],
      bookId: json['_id'],
    );
  }

  String? name;
  String? year;
  String? bookId;
  String? status;
  String? message;
}
