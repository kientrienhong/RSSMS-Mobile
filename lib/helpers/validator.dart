class Validator {
  static dynamic checkApartment(String? value) {
    if (value!.isEmpty) {
      return '* Vui lòng nhập tầng căn hộ (0 nếu không có)';
    }
    return null;
  }

  static dynamic notEmpty(String? value) {
    if (value!.isEmpty) {
      return '* Vui lòng không bỏ trống';
    }
    return null;
  }

  static dynamic checkAddress(String? value) {
    if (value!.isEmpty) {
      return '* Vui lòng nhập địa chỉ gia hàng';
    }
    return null;
  }

  static dynamic checkEmail(String? value) {
    String patttern = "^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,4}\$";
    RegExp regExp = RegExp(patttern);
    if (!value!.contains(regExp)) {
      return "Vui lòng nhập email đúng dạng";
    }
    return null;
  }

  static dynamic checkPhoneNumber(String? value) {
    String patttern =
        r'^\s*(?:\+?(\d{1,3}))?[-. (]*(\d{3})[-. )]*(\d{3})[-. ]*(\d{4})(?: *x(\d+))?\s*$';
    RegExp regExp = RegExp(patttern);
    if (!value!.contains(regExp)) {
      return "Sai định dạng.";
    }
    return null;
  }

  static dynamic checkFullname(String? value) {
    if (value!.isEmpty) {
      return "Vui lòng nhập đầy đủ họ và tên.";
    } else if (value.length < 5) {
      return "Vui lòng nhập đầy đủ họ và tên.";
    }
    return null;
  }

  static dynamic isNumeric(String? string) {
    final numericRegex = RegExp(r'^-?(([0-9]*)|(([0-9]*)\.([0-9]*)))$');

    return numericRegex.hasMatch(string!);
  }
}
