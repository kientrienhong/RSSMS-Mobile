import 'package:bottom_drawer/bottom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:rssms/common/custom_app_bar.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/custom_text.dart';
import 'package:rssms/pages/delivery_staff/store_order/widgets/box_widget.dart';
import 'package:rssms/pages/delivery_staff/store_order/widgets/custom_bottom_sheet.dart';

class StoreOrderScreen extends StatefulWidget {
  const StoreOrderScreen({Key? key}) : super(key: key);

  @override
  _StoreOrderScreenState createState() => _StoreOrderScreenState();
}

class _StoreOrderScreenState extends State<StoreOrderScreen> {
  BottomDrawerController controller = BottomDrawerController();

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
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    void onTapBox(int index, int status) {
      print(status);
      setState(() {
        if (status == 0) {
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
                CustomAppBar(
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
                      decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    prefixIcon: ImageIcon(
                      const AssetImage('assets/images/search.png'),
                      color: CustomColor.black[2]!,
                    ),
                  )),
                  suggestionsCallback: (pattern) async {
                    return listShelves
                        .where((element) => element['name'].contains(pattern))
                        .toList();
                  },
                  itemBuilder: (context, suggestion) {
                    Map<String, dynamic> shelf =
                        suggestion! as Map<String, dynamic>;
                    return ListTile(
                      title: Text(shelf['name']),
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
                            box: listBoxes[i],
                            currentIndex: _currentIndex,
                            index: i,
                            onTap: onTapBox,
                          );
                        },
                        itemCount: listBoxes.length,
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
        CustomBottomSheet(controller: controller),
      ]),
    );
  }
}
