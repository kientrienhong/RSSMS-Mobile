abstract class ProfileView {
  //update views
  // void updateViewStatusButton(String email, String password,
  //     String confirmPassword, String firstname, String lastname, String phone);
  void updateViewPasswordErrorMsg(String error);
  void updateLoadingPassword();
  void updateStatusOfButtonChangePassword(
      String oldPassword, String newPassword, String confirmPassword);
  // handle events
  void onChangeInput();
  void onClickSignIn(String email, String password, String confirmPassword,
      String firstname, String lastname, String phone);
  void onClickChangePassword(
      String oldPassword, String newPassword, String confirmPassword);
}
