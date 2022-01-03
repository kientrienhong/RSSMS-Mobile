import 'package:http/http.dart' as http;

class ApiServices {
  ApiServices._();
  static const _domain = 'https://localhost:44304';

  static Future<dynamic> logInThirParty(String firebaseId, String deviceToken) {
    try {
      final url = Uri.parse(
          '${_domain}/api/v1/users/thirdparty?firebaseID=${firebaseId}&deviceToken=${deviceToken}');
      return http.post(url);
    } catch (e) {
      throw Exception('Log In failed');
    }
  }
}
