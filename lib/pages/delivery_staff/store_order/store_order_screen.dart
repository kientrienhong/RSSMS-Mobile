import 'dart:math';

import 'package:bottom_drawer/bottom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';
import 'package:rssms/common/custom_app_bar.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/custom_text.dart';
import 'package:rssms/models/entity/invoice.dart';
import 'package:rssms/models/entity/shelf.dart';
import 'package:rssms/models/entity/user.dart';
import 'package:rssms/models/store_order_model.dart';
import 'package:rssms/pages/delivery_staff/store_order/widgets/box_widget.dart';
import 'package:rssms/pages/delivery_staff/store_order/widgets/custom_bottom_sheet.dart';
import 'package:rssms/presenters/store_order_presenter.dart';

class StoreOrderScreen extends StatefulWidget {
  Invoice? invoice;
  StoreOrderScreen({Key? key, required this.invoice}) : super(key: key);

  @override
  _StoreOrderScreenState createState() => _StoreOrderScreenState();
}

class _StoreOrderScreenState extends State<StoreOrderScreen> {
  BottomDrawerController controller = BottomDrawerController();
  StoreOrderPresenter? _presenter;
  StoreOrderModel? _model;

  List<Map<String, dynamic>> listShelves = [
    {
      'name': 'Shelf - 1 (Bolo)',
    },
    {
      'name': 'Shelf - 2 (Bolo)',
    },
    {
      'name': 'Shelf - 3 (Bolo)',
    },
    {
      'name': 'Shelf - 4 (Size S)',
    },
    {
      'name': 'Shelf - 5 (Size XL)',
    },
    {
      'name': 'Shelf - 6 (Bolo)',
    },
    {
      'name': 'Shelf - 7 (Bolo)',
    },
    {
      'name': 'Shelf - 8 (Bolo)',
    },
    {
      'name': 'Shelf - 9 (Bolo)',
    },
  ];
  bool _isFound = false;
  int _currentIndex = -1;
  List<Map<String, dynamic>> listBoxes = [
    {'name': 'Bolo - 1', 'status': 0, 'id': 0},
    {'name': 'Bolo - 2', 'status': 0, 'id': 1},
    {'name': 'Bolo - 3', 'status': 1, 'id': 2},
    {'name': 'Bolo - 4', 'status': 2, 'id': 3},
    {'name': 'Bolo - 5', 'status': 3, 'id': 4},
    {'name': 'Bolo - 6', 'status': 0, 'id': 5},
    {'name': 'Bolo - 7', 'status': 0, 'id': 6},
    {'name': 'Bolo - 8', 'status': 0, 'id': 7},
    {'name': 'Bolo - 9', 'status': 0, 'id': 8},
  ];

  @override
  void initState() {
    _presenter = StoreOrderPresenter();
    Users user = Provider.of<Users>(context, listen: false);
    _presenter!.loadShelf(user.idToken!);
    _model = _presenter!.model;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    void onTapBox(int index, int status) {
      setState(() {
        if (status != null) {
          controller.open();
        }
        _currentIndex = index;
      });
    }

    return Scaffold(
      backgroundColor: CustomColor.white,
      body: Stack(children: [
        SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               const CustomAppBar(
                  isHome: false,
                  name: '',
                ),
                CustomText(
                  text: 'Tìm kệ',
                  color: CustomColor.black,
                  context: context,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                CustomSizedBox(
                  context: context,
                  height: 8,
                ),
                TypeAheadField(
                  textFieldConfiguration: TextFieldConfiguration(
                    controller: _model!.searchValue,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      prefixIcon: ImageIcon(
                        const AssetImage('assets/images/search.png'),
                        color: CustomColor.black[2]!,
                      ),
                    ),
                  ),
                  suggestionsCallback: (pattern) async {
                    return _model!.listShelf!
                        .where((element) => element.name.contains(pattern))
                        .toList();
                  },
                  itemBuilder: (context, suggestion) {
                    Shelf shelf = suggestion! as Shelf;
                    return ListTile(
                      title: Text(shelf.name),
                    );
                  },
                  noItemsFoundBuilder: (context) => Center(
                    child: CustomText(
                        text: 'No shelf found!',
                        color: CustomColor.black,
                        context: context,
                        fontSize: 16),
                  ),
                  onSuggestionSelected: (suggestion) {
                    setState(() {
                      _isFound = true;
                      _model!.selectedShelf = suggestion as Shelf;
                      _model!.searchValue.text = suggestion.name;
                    });
                  },
                ),
                if (_isFound)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomSizedBox(
                        context: context,
                        height: 16,
                      ),
                      CustomText(
                        text: 'Tìm vị trí trên kệ',
                        color: CustomColor.black,
                        context: context,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      CustomSizedBox(
                        context: context,
                        height: 8,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(5),
                            prefixIcon: ImageIcon(
                              const AssetImage('assets/images/search.png'),
                              color: CustomColor.black[2]!,
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(
                                  color: CustomColor.black,
                                ))),
                      ),
                      CustomSizedBox(
                        context: context,
                        height: 8,
                      ),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1,
                          crossAxisSpacing: 16.0,
                        ),
                        itemBuilder: (ctx, i) {
                          return BoxWidget(
                            box: _model!.selectedShelf!.boxes[i],
                            currentIndex: _currentIndex,
                            index: i,
                            onTap: onTapBox,
                          );
                        },
                        itemCount: _model!.selectedShelf!.boxes.length,
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
        CustomBottomSheet(
          controller: controller,
          invoice: widget.invoice,
        ),
      ]),
    );
  }
}
