import 'package:flutter/material.dart';
import 'package:rssms/common/custom_color.dart';

class CustomBottomNavigation extends StatefulWidget {
  final List<dynamic>? listNavigator;
  final List<Widget>? listIndexStack;
  const CustomBottomNavigation(
      {Key? key, this.listNavigator, this.listIndexStack})
      : super(key: key);

  @override
  _CustomBottomNavigationState createState() => _CustomBottomNavigationState();
}

class _CustomBottomNavigationState extends State<CustomBottomNavigation> {
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _index = 0;
  }

  void _tapTab(int index) {
    setState(() {
      _index = index;
    });
  }

  List<BottomNavigationBarItem> mapListBottomNavigationBarItem() {
    return widget.listNavigator!.map((e) {
      return BottomNavigationBarItem(
          icon: ImageIcon(
            AssetImage(e['url']),
          ),
          label: e['label']);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: CustomColor.blue,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: mapListBottomNavigationBarItem(),
        currentIndex: _index,
        selectedItemColor: CustomColor.white,
        onTap: _tapTab,
      ),
      body: Stack(
        children: [
          IndexedStack(
            index: _index,
            children: widget.listIndexStack!,
          ),
        ],
      ),
    );
  }
}
