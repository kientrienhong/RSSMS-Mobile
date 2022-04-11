import 'dart:convert';

class HandleResponse {
  static Map<String, dynamic> handle(response) {
    if (response.statusCode == 200) {
      return {
        'status': 'success',
        'data': jsonDecode(response.body),
      };
    } else if (response.statusCode >= 400 && response.statusCode < 500) {
      return {
        'status': 'failed',
        'data': jsonDecode(response.body)['error']['message']
      };
    } else if (response.statusCode >= 500) {
      return {
        'status': 'failed',
        'data': 'Hệ thống xảy ra lỗi. Vui lòng thử lại sau'
      };
    }

    return {
      'status': 'failed',
      'data': 'Hệ thống xảy ra lỗi. Vui lòng thử lại sau'
    };
  }
}
