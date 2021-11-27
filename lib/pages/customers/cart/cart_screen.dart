import 'package:flutter/material.dart';
import 'package:rssms/common/custom_color.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: CustomColor.white,
      body: Center(
        child: Text('Home'),
      ),
    );
  }
}
