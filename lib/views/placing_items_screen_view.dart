abstract class PlacingItemsScreenView {
  void onClickConfirm();
  void onClickEmptyPlacing();
  void updateError(String error);
  void updateLoading();
  void onClickPlace(int index);

  void onClickUndo(int index);

  void onClickAcceptImport();
}
