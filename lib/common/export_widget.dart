import 'package:flutter/material.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/import_export_details.dart';
import 'package:rssms/common/import_export_info.dart';
import 'package:rssms/common/import_export_license.dart';
import 'package:rssms/models/entity/export.dart';
import 'package:rssms/models/entity/order_detail.dart';

class ExportWidget extends StatelessWidget {
  final Export export;
  final List<OrderDetail> orderDetail;
  final Function() onClickAcceptImport;

  const ExportWidget(
      {Key? key,
      required this.onClickAcceptImport,
      required this.export,
      required this.orderDetail})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ImportExportInfo(
            export: export, backButton: true, isExport: true, isView: true),
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
      ],
    );
  }
}
