import 'dart:convert';

class HandleResponse {
  static String? handle(response) {
    if (response.statusCode == 200) {
      return null;
    } else if (response.statusCode == 400) {
      return jsonDecode(response.body)['error']['message'];
    } else if (response.statusCode == 404) {
      return jsonDecode(response.body)['error']['message'];
    } else if (response.statusCode == 500) {
      return 'Hệ thống lỗi! Vui lòng thử lại';
    }

    return '';
  }
}
