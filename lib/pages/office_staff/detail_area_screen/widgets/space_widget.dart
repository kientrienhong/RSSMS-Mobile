import 'package:flutter/material.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/custom_text.dart';
import 'package:rssms/models/entity/area.dart';
import 'package:rssms/models/entity/space.dart';
import 'package:rssms/constants/constants.dart' as constants;
import 'package:rssms/pages/office_staff/detail_area_screen/widgets/floor_widget.dart';

class SpaceWidget extends StatefulWidget {
  final Space space;
  final String areaName;
  final Function getListSpace;
  final Area area;
  const SpaceWidget(
      {Key? key,
      required this.getListSpace,
      required this.space,
      required this.area,
      required this.areaName})
      : super(key: key);

  @override
  State<SpaceWidget> createState() => _SpaceWidgetState();
}

class _SpaceWidgetState extends State<SpaceWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: CustomColor.white,
            boxShadow: [
              BoxShadow(
                  blurRadius: 14,
                  color: const Color(0x00000000).withOpacity(0.16),
                  offset: const Offset(0, 1)),
            ]),
        child: ExpansionTile(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Flexible(
                    child: CustomText(
                      text: constants.listSpaceType[widget.space.type]['name']
                          as String,
                      color: constants.listSpaceType[widget.space.type]['color']
                          as Color,
                      context: context,
                      fontSize: 16,
                      maxLines: 3,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
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
                      maxLines: 2,
                      text: widget.space.name,
                      color: CustomColor.black,
                      context: context,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ],
              ),
              CustomSizedBox(
                context: context,
                height: 8,
              ),
              CustomText(
                  text:
                      'Kích thước tầng: (${widget.space.floors[0].width}m x ${widget.space.floors[0].length}m x ${widget.space.floors[0].height}m)',
                  color: CustomColor.black,
                  context: context,
                  fontSize: 14)
            ],
          ),
          children: [
            ListView.builder(
                itemCount: widget.space.floors.length,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(8),
                shrinkWrap: true,
                itemBuilder: (_, index) {
                  return FloorWidget(
                    floor: widget.space.floors[index],
                    areaName: widget.areaName,
                    space: widget.space,
                    getListSpace: widget.getListSpace,
                    area: widget.area,
                  );
                })
          ],
        ));
  }
}
