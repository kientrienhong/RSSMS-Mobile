class Validator {
  static dynamic notEmpty(String? value) {
    if (value!.isEmpty) {
      return '* Vui lòng nhập';
    }
    return null;
  }

  static dynamic checkPhoneNumber(String? value) {
    String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = RegExp(patttern);
    if (value!.isEmpty) {
      return '* Vui lòng nhập';
    } else if (!regExp.hasMatch(value)) {
      return '* Vui lòng nhập đúng số điện thoại';
    }
    return null;
  }

  static dynamic isNumeric(String? string) {
    final numericRegex = RegExp(r'^-?(([0-9]*)|(([0-9]*)\.([0-9]*)))$');

    return numericRegex.hasMatch(string!);
  }
}
