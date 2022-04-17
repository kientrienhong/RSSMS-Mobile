import 'package:flutter/material.dart';
import 'package:rssms/common/custom_button.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/custom_text.dart';
import 'package:rssms/models/entity/floor.dart';

class FloorWidget extends StatelessWidget {
  final Floor floor;
  const FloorWidget({Key? key, required this.floor}) : super(key: key);

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
                  value: floor.usage,
                  color: CustomColor.blue,
                ),
              ),
              Positioned.fill(
                child: Align(
                    alignment: Alignment.center,
                    child: CustomText(
                        text: '${floor.usage}%',
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
                  onPressFunction: () {},
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
                  onPressFunction: () {},
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
