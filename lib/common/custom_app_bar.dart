import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/custom_text.dart';

import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool? isHome;
  final String? name;
  const CustomAppBar({Key? key, required this.isHome, this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return PreferredSize(
      preferredSize: const Size(double.infinity, 80),
      child: Container(
        color: Colors.transparent,
        width: deviceSize.width,
        height: 80,
        child: Row(
            mainAxisAlignment: name != null
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
                  : Container(),
              CustomText(
                text: name!,
                color: CustomColor.black,
                context: context,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              CustomSizedBox(
                context: context,
                width: 8,
              ),
            ]),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}
