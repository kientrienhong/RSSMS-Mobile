import 'package:flutter/material.dart';
import 'package:rssms/common/custom_color.dart';

class RequestScreen extends StatefulWidget {
  const RequestScreen({Key? key}) : super(key: key);

  @override
  _RequestScreenState createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.white,
      body: Container(
        child: Center(
          child: Text('Request delivery screen'),
        ),
      ),
    );
  }
}
