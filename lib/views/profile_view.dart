abstract class ProfileView {
  //update views
  // void updateViewStatusButton(String email, String password,
  //     String confirmPassword, String firstname, String lastname, String phone);
  void updateViewPasswordErrorMsg(String error);
  void updateLoadingPassword();
  void updateLoadingProfile();
  void updateStatusOfButtonChangePassword(
      String oldPassword, String newPassword, String confirmPassword);

  void updateStatusOfButtonUpdateProfile(
      String fullname, String phone, String address);
  // handle events
  void onChangeInput();
  void onChangeInputProfile();
  void onClickUpdateProfile(String fullname, String phone, String birthdate,
      String gender, String address);
  void onClickChangePassword(
      String oldPassword, String newPassword, String confirmPassword);
}
