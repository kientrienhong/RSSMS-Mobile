abstract class SignUpView {
  //update views
  void updateViewStatusButton(
      String email,
      String password,
      String confirmPassword,
      String address,
      String name,
      String phone,
      String birthDay);
  void updateViewErrorMsg(String error);
  void updateLoading();

  // handle events
  void onChangeInput();
  void onClickSignUp(String email, String password, String confirmPassword,
      String address, String name, String phone, String birthDay);
}
