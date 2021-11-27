import 'package:flutter/material.dart';
import 'package:rssms/common/custom_color.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: CustomColor.white,
      body: Center(
        child: Text('Profile'),
      ),
    );
  }
}
