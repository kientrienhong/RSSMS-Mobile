import 'package:flutter/material.dart';
import 'package:rssms/common/custom_app_bar.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/custom_text.dart';
import 'package:rssms/common/invoice_image_widget.dart';
import 'package:rssms/common/timeline.dart';
import 'package:rssms/constants/constants.dart' as constants;
import 'package:rssms/pages/customers/my_account/request/request_screen.dart';

class DetailRequestScreen extends StatelessWidget {
  final Map<String, dynamic> request;

  const DetailRequestScreen({Key? key, required this.request})
      : super(key: key);

  List<Widget> mapImageWidget(listImage) => listImage
      .map<InvoiceImageWidget>((i) => InvoiceImageWidget(
            image: i,
          ))
      .toList();

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    Widget buildInfo(String title, String value, Color valueColor) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: deviceSize.width / 3,
            child: CustomText(
              text: title,
              color: CustomColor.black,
              context: context,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Flexible(
            child: CustomText(
                text: value,
                color: valueColor,
                maxLines: 2,
                textAlign: TextAlign.right,
                context: context,
                fontWeight: FontWeight.bold,
                fontSize: 16),
          )
        ],
      );
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBar(
                isHome: false,
                name: 'Chi tiết yêu cầu',
              ),
              buildInfo('Mã yêu cầu: ', '#1312', CustomColor.black),
              CustomSizedBox(
                context: context,
                height: 16,
              ),
              buildInfo('Mã yêu cầu:', '#1312', CustomColor.black),
              CustomSizedBox(
                context: context,
                height: 16,
              ),
              if (request['type'] == REQUEST_TYPE.modifyRequest)
                buildInfo('Ngày đổi đồ:', '12/01/2022', CustomColor.black),
              if (request['type'] == REQUEST_TYPE.modifyRequest)
                CustomSizedBox(
                  context: context,
                  height: 16,
                ),
              buildInfo(
                  'Địa chỉ: ',
                  '12 Kim Bien, phuong 13, quan 5, TP Ho Chi Minh',
                  CustomColor.black),
              CustomSizedBox(
                context: context,
                height: 24,
              ),
              if (request['type'] == REQUEST_TYPE.modifyRequest)
                CustomText(
                    text: 'Danh sách muốn đổi đồ',
                    color: CustomColor.black,
                    context: context,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              if (request['type'] == REQUEST_TYPE.modifyRequest)
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Row(
                      children:
                          mapImageWidget(constants.LIST_REQUEST_MODIFY_IMAGE),
                    ),
                  ),
                ),
              CustomSizedBox(
                context: context,
                height: 24,
              ),
              CustomText(
                  text: 'Dòng thời gian',
                  color: CustomColor.black,
                  context: context,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
              const TimeLine(listTimeLine: constants.LIST_TIME_LINE_MODIFY)
            ],
          ),
        ),
      ),
    );
  }
}
