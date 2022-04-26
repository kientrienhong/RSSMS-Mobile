import 'package:flutter/cupertino.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/custom_text.dart';

class ImportExportLicense extends StatelessWidget {
  const ImportExportLicense({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: "Các điều khoản và điều kiện",
          color: CustomColor.black,
          context: context,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        CustomSizedBox(
          context: context,
          height: 16,
        ),
        CustomText(
          text:
              "* Nhân viên thủ kho xác nhận rằng đồ đạc vẫn trong tình trạng như ban đầu",
          color: CustomColor.black,
          context: context,
          maxLines: 3,
          fontSize: 12,
        ),
      ],
    );
  }
}
