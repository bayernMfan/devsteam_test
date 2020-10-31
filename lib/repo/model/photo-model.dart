import 'package:flutter/foundation.dart';

class PhotoModel {
  final String url;
  final String author;
  final String description;

  PhotoModel({@required this.url, @required this.author, this.description})
      : assert(url != null),
        assert(author != null);

  factory PhotoModel.fromJson(Map<String, dynamic> json) {
    try {
      return PhotoModel(
          url: json["urls"]["regular"],
          author: json["user"]["username"],
          description: json["alt_description"]);
    } catch (e) {}
  }
}
