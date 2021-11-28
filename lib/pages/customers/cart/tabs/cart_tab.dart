import 'package:flutter/material.dart';
import 'package:rssms/common/custom_color.dart';

class CartTab extends StatelessWidget {
  final Size deviceSize;
  final int index;
  final Function(int) tapTab;
  const CartTab(
      {Key? key,
      required this.deviceSize,
      required this.index,
      required this.tapTab})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: EdgeInsets.only(
            bottom: 16,
            left: deviceSize.width / 7,
            right: deviceSize.width / 7),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 3,
                  blurRadius: 16,
                  offset: Offset(0, 0), // changes position of shadow
                ),
              ],
            ),
            child: Theme(
              data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
              child: BottomNavigationBar(
                selectedItemColor: CustomColor.purple,
                backgroundColor: CustomColor.white,
                type: BottomNavigationBarType.fixed,
                currentIndex: index,
                onTap: tapTab,
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                      icon: ImageIcon(
                        AssetImage('assets/images/box.png'),
                      ),
                      label: 'Giữ đồ thuê'),
                  BottomNavigationBarItem(
                      icon: ImageIcon(
                        AssetImage('assets/images/warehouse.png'),
                      ),
                      label: 'Kho tự quản'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
