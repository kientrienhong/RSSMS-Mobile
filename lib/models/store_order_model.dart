import 'package:flutter/cupertino.dart';
import 'package:rssms/models/entity/shelf.dart';

class StoreOrderModel {
  List<Shelf>? listShelf;
  Shelf? selectedShelf;
  TextEditingController? _searchValue;
  FocusNode? _searchfocusNode;

  StoreOrderModel() {
    listShelf = [];
    _searchValue = TextEditingController();
    _searchfocusNode = FocusNode();
  }
  get getListShelf => listShelf;

  set setListShelf(listShelf) => listShelf = listShelf;

  get getSelectedShelf => selectedShelf;

  set setSelectedShelf(selectedShelf) => selectedShelf = selectedShelf;

  get searchValue => _searchValue;

  set setSearchValue(value) => _searchValue!.text = value;

  get searchfocusNode => _searchfocusNode;

  set searchfocusNode(value) => _searchfocusNode = value;
}
