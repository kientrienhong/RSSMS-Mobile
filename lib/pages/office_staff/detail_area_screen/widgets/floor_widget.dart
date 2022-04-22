import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rssms/common/custom_button.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/custom_text.dart';
import 'package:rssms/models/entity/area.dart';
import 'package:rssms/models/entity/floor.dart';
import 'package:rssms/models/entity/user.dart';
import 'package:rssms/pages/office_staff/floor_details_screen/floor_detail_screen.dart';
import 'package:rssms/pages/office_staff/placing_items_screen.dart/placing_items_screen.dart';

class FloorWidget extends StatelessWidget {
  final Floor floor;
  final String areaName;
  final Function getListSpace;
  final Area area;
  const FloorWidget(
      {Key? key,
      required this.getListSpace,
      required this.floor,
      required this.area,
      required this.areaName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    Widget _buildInformation(String title, String value) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomText(
              text: title,
              color: CustomColor.black,
              context: context,
              fontWeight: FontWeight.bold,
              fontSize: 16),
          CustomSizedBox(
            context: context,
            height: 8,
          ),
          CustomText(
              text: value,
              color: CustomColor.black,
              context: context,
              fontSize: 16),
        ],
      );
    }

    Widget _buildUsage() {
      return Column(
        children: [
          Stack(
            children: [
              SizedBox(
                height: 80,
                width: 80,
                child: CircularProgressIndicator(
                  value: floor.usage / 100,
                  color: CustomColor.blue,
                ),
              ),
              Positioned.fill(
                child: Align(
                    alignment: Alignment.center,
                    child: CustomText(
                        text: '${floor.usage.toStringAsFixed(2)}%',
                        color: CustomColor.black,
                        context: context,
                        fontSize: 16)),
              ),
            ],
          ),
          CustomSizedBox(
            context: context,
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildInformation('Thể tích đã sử dụng', '${floor.used}m3'),
              _buildInformation('Thể tích trống', '${floor.available}m3'),
            ],
          )
        ],
      );
    }

    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: CustomColor.blue, width: 2)),
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        children: [
          CustomText(
              text: floor.name,
              color: CustomColor.black,
              context: context,
              fontWeight: FontWeight.bold,
              fontSize: 16),
          CustomSizedBox(
            context: context,
            height: 16,
          ),
          _buildUsage(),
          CustomSizedBox(
            context: context,
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomButton(
                  height: 24,
                  text: 'Lưu trữ đồ',
                  width: deviceSize.width / 3 - 40,
                  onPressFunction: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PlacingItemsScreen(
                                area: area,
                                floorId: floor.id,
                                sizeOfFloor: {
                                  'height': floor.height,
                                  'width': floor.width,
                                  'length': floor.length
                                },
                                floorName: floor.name,
                                isView: false,
                              )),
                    ).then((value) {
                      if (value) {
                        Users users =
                            Provider.of<Users>(context, listen: false);
                        getListSpace(users.idToken!, area.id);
                      }
                    });
                  },
                  isLoading: false,
                  textColor: CustomColor.white,
                  buttonColor: CustomColor.blue,
                  borderRadius: 4),
              CustomSizedBox(
                context: context,
                height: 8,
              ),
              CustomButton(
                  height: 24,
                  text: 'Xem thêm',
                  width: deviceSize.width / 3 - 40,
                  onPressFunction: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FloorDetailScreen(
                                floor: floor,
                              )),
                    );
                  },
                  isLoading: false,
                  textColor: CustomColor.white,
                  buttonColor: CustomColor.green,
                  borderRadius: 4),
            ],
          )
        ],
      ),
    );
  }
}
