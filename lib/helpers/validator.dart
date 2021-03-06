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
      return '* Vui lòng nhập địa chỉ giao hàng';
    }
    return null;
  }

  static dynamic checkEmail(String? value) {
    String patttern = "^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,4}\$";
    RegExp regExp = RegExp(patttern);
    if (!value!.contains(regExp)) {
      return "* Vui lòng nhập email đúng dạng";
    }
    return null;
  }

  static dynamic checkPhoneNumber(String? value) {
    String patttern = r'^(0|\+84)(\s|\.)?[0-9]{9}$';
    RegExp regExp = RegExp(patttern);
    if (!value!.contains(regExp)) {
      return "* Sai định dạng.";
    }
    return null;
  }

  static dynamic checkFullname(String? value) {
    if (value!.isEmpty) {
      return "* Vui lòng nhập";
    } else if (value.isEmpty) {
      return "* Vui lòng nhập";
    }
    return null;
  }

  static dynamic isNumeric(String? string) {
    final numericRegex = RegExp(r'^-?(([0-9]*)|(([0-9]*)\.([0-9]*)))$');

    return numericRegex.hasMatch(string!);
  }
}
