import 'package:flutter/material.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/invoice_image_widget.dart';
import 'package:rssms/models/entity/invoice.dart';
import 'package:rssms/pages/customers/cart/widgets/title_tab.dart';
import 'package:rssms/pages/customers/my_account/invoice/invoice_detail_screen/tab/invoice_tab.dart';
import 'package:rssms/pages/customers/my_account/invoice/invoice_detail_screen/tab/item_tab.dart';
import 'package:rssms/constants/constants.dart' as constants;

class InvoiceDetailScreen extends StatefulWidget {
  Invoice? invoice;
  final Size deviceSize;

  InvoiceDetailScreen({Key? key, this.invoice, required this.deviceSize})
      : super(key: key);

  @override
  State<InvoiceDetailScreen> createState() => _InvoiceDetailScreenState();
}

class _InvoiceDetailScreenState extends State<InvoiceDetailScreen> {
  late int _index;

  @override
  void initState() {
    super.initState();
    _index = 0;
  }

  List<TitleTab> mapListTab() {
    int index = 0;

    return constants.TAB_INVOICE_DETAIL
        .map<TitleTab>((e) => TitleTab(
              title: e,
              index: index++,
              deviceSize: widget.deviceSize,
              currentIndex: _index,
              onChangeTab: onChangeTab,
            ))
        .toList();
  }

  void onChangeTab(int index) {
    setState(() {
      _index = index;
    });
  }

  List<Widget> mapImageWidget(listImage) => listImage
      .map<InvoiceImageWidget>((i) => InvoiceImageWidget(
            image: i,
          ))
      .toList();

  @override
  Widget build(BuildContext context) {
    // List<Map<String, dynamic>> listImage = invoice!["image"];

    return Scaffold(
        backgroundColor: CustomColor.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: SizedBox(
            width: widget.deviceSize.width,
            height: widget.deviceSize.height,
            child: ListView(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: SizedBox(
                    width: 24,
                    height: 24,
                    child: GestureDetector(
                      onTap: () => {Navigator.of(context).pop()},
                      child: Image.asset('assets/images/arrowLeft.png'),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: mapListTab(),
                ),
                CustomSizedBox(
                  context: context,
                  height: 16,
                ),
                _index == 0
                    ? InvoiceTab(
                        deviceSize: widget.deviceSize,
                        invoice: widget.invoice,
                      )
                    : ItemTab(invoice: widget.invoice)
              ],
            ),
          ),
        ));
  }
}
