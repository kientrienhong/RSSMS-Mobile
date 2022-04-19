import 'package:flutter/material.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/custom_text.dart';
import 'package:rssms/models/entity/area.dart';
import 'package:rssms/constants/constants.dart' as constants;
import 'package:rssms/pages/office_staff/detail_area_screen/detail_area_screen.dart';

class AreaWidget extends StatelessWidget {
  final Area area;
  const AreaWidget({Key? key, required this.area}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    Widget buildInformation(String title, String value) {
      return Row(
        children: [
          CustomText(
            text: title,
            color: CustomColor.black,
            context: context,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          CustomSizedBox(
            context: context,
            width: 4,
          ),
          CustomText(
            text: value,
            color: CustomColor.black,
            context: context,
            fontSize: 16,
          ),
        ],
      );
    }

    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailAreaScreen(
                      idArea: area.id,
                      nameArea: area.name,
                    )));
      },
      child: Container(
        width: deviceSize.width - 48,
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: CustomColor.white,
            boxShadow: [
              BoxShadow(
                  blurRadius: 14,
                  color: const Color(0x00000000).withOpacity(0.16),
                  offset: const Offset(0, 1)),
            ]),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: (deviceSize.width - 48 - 16) * 3 / 4,
              child: Column(
                children: [
                  Row(
                    children: [
                      CustomText(
                          text: constants.listAreaType[area.type]['name']
                              as String,
                          color: constants.listAreaType[area.type]['color']
                              as Color,
                          context: context,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                      CustomSizedBox(
                        context: context,
                        width: 8,
                      ),
                      Container(
                        width: 2,
                        height: 16,
                        color: CustomColor.black,
                      ),
                      CustomSizedBox(
                        context: context,
                        width: 8,
                      ),
                      CustomText(
                        text: area.name,
                        color: CustomColor.black,
                        context: context,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      )
                    ],
                  ),
                  CustomSizedBox(
                    context: context,
                    height: 16,
                  ),
                  buildInformation('Kích thước',
                      '${area.width}m x ${area.length}m x ${area.height}'),
                  CustomSizedBox(
                    context: context,
                    height: 16,
                  ),
                  buildInformation('Mô tả:', area.description),
                ],
              ),
            ),
            SizedBox(
                height: 24,
                width: 24,
                child: Image.asset('assets/images/rightIcon.png')),
          ],
        ),
      ),
    );
  }
}
