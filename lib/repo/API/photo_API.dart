import 'package:devsteam_test/repo/model/photo-model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

enum Prop { url, author, description }

class Photo {
  Future<List<PhotoModel>> getPhotosList() async {
    try {
      final result = await http.Client().get(
          'https://api.unsplash.com/photos/?client_id=cf49c08b444ff4cb9e4d126b7e9f7513ba1ee58de7906e4360afc1a33d1bf4c0');
      List<PhotoModel> photos = [];

      if (result.statusCode == 200)
        for (var item in json.decode(result.body)) {
          photos.add(PhotoModel.fromJson(item));
        }
      return photos;
    } catch (exception) {
      throw exception;
    }
  }
}
