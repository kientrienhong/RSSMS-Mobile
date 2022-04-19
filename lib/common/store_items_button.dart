import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:provider/provider.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/models/entity/placing_items.dart';
import 'package:rssms/pages/office_staff/placing_items_screen.dart/placing_items_screen.dart';

class StoreItemsButton extends StatelessWidget {
  const StoreItemsButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const PlacingItemsScreen(
                      areaName: '',
                      floorId: '',
                      floorName: '',
                      isView: true,
                    )));
      },
      child: Consumer<PlacingItems>(
        builder: (_, items, child) => Badge(
          badgeContent: Text(items.storedItems['totalQuantity'].toString()),
          child: Container(
            width: 40,
            height: 40,
            padding: const EdgeInsets.all(8),
            decoration:
                BoxDecoration(border: Border.all(color: CustomColor.black[3]!)),
            child: Image.asset(
              'assets/images/product.png',
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
