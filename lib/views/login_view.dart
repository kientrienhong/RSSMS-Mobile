abstract class LoginView {
  //update views
  void updateViewStatusButton(String email, String password);
  void updateViewErrorMsg(String error);
  void updateLoading();

  // handle events
  void onChangeInput();
  void onClickSignIn(String email, String password);
  void onClickSignInGoogle();
  void onClickSignInFaceBook();
}
