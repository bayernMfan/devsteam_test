import 'package:flutter/foundation.dart';

class PhotoModel {
  final String url;
  final String author;
  final String description;

  PhotoModel(
      {@required this.url, @required this.author, @required this.description})
      : assert(url != null),
        assert(author != null),
        assert(description != null);

  factory PhotoModel.fromJson(Map<String, dynamic> json) {
    return PhotoModel(
        url: json["urls"]["regular"],
        author: json["user"]["username"],
        description: json["alt_description"]);
  }
}
