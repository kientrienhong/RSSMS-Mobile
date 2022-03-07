
// ignore_for_file: must_be_immutable

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
  int _currentChoicedBox = -1;
  bool _isFound = false;
  int _currentIndex = -1;

  @override
  void initState() {
    _presenter = StoreOrderPresenter();
    Users user = Provider.of<Users>(context, listen: false);
    _presenter!.loadShelf(user.idToken!);
    _model = _presenter!.model;
    super.initState();
  }

  void onChangeRadio(val) {
    setState(() {
      _currentChoicedBox = val;
    });
  }

  @override
  Widget build(BuildContext context) {

    void onTapBox(int index, int status) {
      setState(() {
        controller.open();
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
                      title: Text("${shelf.name} (${shelf.sizeType})"),
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
          currentChoicedProduct: _currentChoicedBox,
          onChangeRadio: onChangeRadio,
          controller: controller,
          invoice: widget.invoice,
        ),
      ]),
    );
  }
}
