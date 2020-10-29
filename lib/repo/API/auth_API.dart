import 'package:http/http.dart' as http;

//enum Prop { country, slug, iso2 }

class Auth {
  Future<bool> hasAuthenticated(String token) async {
    try {
      final result = await http.Client()
          .get('https://api.unsplash.com/photos/?client_id=' + token);
      if (result.statusCode == 200)
        return true;
      else
        return false;
    } catch (exception) {
      throw exception;
    }
  }
}
