abstract class InvoiceView {
  void setChangeList();
  void onHandleChangeInput();
  void refreshList(String searchValue);
  void updateIsLoadingInvoice();
  Future<void> refresh();
}
