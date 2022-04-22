import 'package:flutter/material.dart';
import 'package:rssms/common/custom_button.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/import_export_details.dart';
import 'package:rssms/common/import_export_info.dart';
import 'package:rssms/common/import_export_license.dart';
import 'package:rssms/models/entity/import.dart';
import 'package:rssms/models/entity/order_detail.dart';

class ImportScreen extends StatelessWidget {
  final Import import;
  final List<OrderDetail> orderDetail;
  final Function() onClickAcceptImport;
  const ImportScreen(
      {Key? key,
      required this.onClickAcceptImport,
      required this.import,
      required this.orderDetail})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ImportExportInfo(
                  isView: false,
                  import: import,
                  backButton: false,
                  isExport: false,
                ),
                CustomSizedBox(
                  context: context,
                  height: 16,
                ),
                const SizedBox(
                  height: 0,
                  child: Divider(
                    color: CustomColor.black,
                    thickness: 1,
                  ),
                ),
                const SizedBox(
                  height: 5,
                  child: Divider(
                    color: CustomColor.black,
                    thickness: 0.5,
                  ),
                ),
                ImportExportDetails(orderDetail: orderDetail),
                CustomSizedBox(
                  context: context,
                  height: 16,
                ),
                const ImportExportLicense(),
                CustomSizedBox(
                  context: context,
                  height: 16,
                ),
                Center(
                  child: CustomButton(
                      height: 24,
                      text: 'Chấp nhận',
                      width: deviceSize.width / 2 - 40,
                      onPressFunction: onClickAcceptImport,
                      isLoading: false,
                      textColor: CustomColor.white,
                      buttonColor: CustomColor.blue,
                      borderRadius: 4),
                ),
              ],
            )),
      ),
    );
  }
}
