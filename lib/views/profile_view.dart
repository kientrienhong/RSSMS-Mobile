abstract class ProfileView {
  //update views
  // void updateViewStatusButton(String email, String password,
  //     String confirmPassword, String firstname, String lastname, String phone);
  void updateViewPasswordErrorMsg(String error);
  void updateErrorProfile(String error);
  void updateLoadingPassword();
  void updateLoadingProfile();

  void onClickUpdateProfile();
  void onClickChangePassword(
      String oldPassword, String newPassword, String confirmPassword);
}
