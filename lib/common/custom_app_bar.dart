import '/models/entity/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool? isHome;
  final String? name;
  CustomAppBar({required this.isHome, this.name});

  @override
  Widget build(BuildContext context) {
    var nowParam = DateFormat('yyyyddMMHHmm').format(DateTime.now());

    final deviceSize = MediaQuery.of(context).size;
    return PreferredSize(
      preferredSize: const Size(double.infinity, 80),
      child: Container(
        color: Colors.transparent,
        width: deviceSize.width,
        height: 80,
        child: Row(
            mainAxisAlignment: name == null
                ? MainAxisAlignment.spaceBetween
                : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              isHome == false
                  ? GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Image.asset('assets/images/arrowLeft.png'))
                  : Container()
            ]),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(80);
}
