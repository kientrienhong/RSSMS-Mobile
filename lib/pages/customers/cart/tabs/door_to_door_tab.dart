import 'package:flutter/material.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/pages/customers/cart/tabs/handy_tab.dart';
import 'package:rssms/pages/customers/cart/tabs/self_storage_tab.dart';
import 'package:rssms/pages/customers/cart/widgets/product_widget.dart';
import 'package:rssms/pages/customers/cart/widgets/title_tab.dart';
import 'package:rssms/views/door_to_door_view.dart';
import '../../../../constants/constants.dart' as constants;

class DoorToDoorTab extends StatefulWidget {
  const DoorToDoorTab({Key? key}) : super(key: key);

  @override
  _DoorToDoorTabState createState() => _DoorToDoorTabState();
}

class _DoorToDoorTabState extends State<DoorToDoorTab>
    implements DoorToDoorView {
  late int _index;

  @override
  void initState() {
    super.initState();
    _index = 0;
  }

  @override
  void onChangeTab(int index) {
    setState(() {
      _index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final List<Map<String, dynamic?>> listProduct = constants.LIST_PRODUCT
        .map<Map<String, dynamic>>((e) => {...e, 'quantity': 0})
        .toList();
    List<TitleTab> mapListTab() {
      int index = 0;

      return constants.TAB_DOOR_TO_DOOR
          .map<TitleTab>((e) => TitleTab(
                title: e,
                index: index++,
                deviceSize: deviceSize,
                currentIndex: _index,
                onChangeTab: onChangeTab,
              ))
          .toList();
    }

    return SizedBox(
      width: deviceSize.width,
      height: deviceSize.height,
      child: ListView(
        children: [
          CustomSizedBox(
            context: context,
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: mapListTab(),
          ),
          _index == 0 ? HandyTab() : SelfStorageTab()
        ],
      ),
    );
  }
}
