abstract class SignUpView {
  //update views
  void updateViewStatusButton(String email, String password,
      String confirmPassword, String firstname, String lastname, String phone);
  void updateViewErrorMsg(String error);
  void updateLoading();

  // handle events
  void onChangeInput();
  void onClickSignIn(String email, String password, String confirmPassword,
      String firstname, String lastname, String phone);
}
