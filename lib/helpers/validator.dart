class Validator {
  static dynamic notEmpty(String? value) {
    if (value!.isEmpty) {
      return '* Required';
    }
    return null;
  }

  static dynamic checkPhoneNumber(String? value) {
    String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = RegExp(patttern);
    if (value!.isEmpty) {
      return '* Required';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter valid mobile number';
    }
    return null;
  }

  static dynamic isNumeric(String? string) {
    final numericRegex = RegExp(r'^-?(([0-9]*)|(([0-9]*)\.([0-9]*)))$');

    return numericRegex.hasMatch(string!);
  }
}
