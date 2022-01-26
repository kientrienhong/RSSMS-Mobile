import 'package:flutter/material.dart';
import 'package:rssms/common/custom_app_bar.dart';
import 'package:rssms/common/custom_text.dart';

class AreaScreen extends StatefulWidget {
  const AreaScreen({Key? key}) : super(key: key);

  @override
  _AreaScreenState createState() => _AreaScreenState();
}

class _AreaScreenState extends State<AreaScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomAppBar(
              isHome: false,
              name: 'Danh sách khu vực',
            ),
          ],
        ),
      ),
    );
  }
}
