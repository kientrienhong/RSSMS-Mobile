import 'package:flutter/material.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/custom_text.dart';
import 'package:rssms/pages/customers/my_account/invoice/invoice_widget.dart';
import '../../../../constants/constants.dart' as constants;

class InvoiceScreen extends StatefulWidget {
  const InvoiceScreen({Key? key}) : super(key: key);

  @override
  State<InvoiceScreen> createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen> {
  List<Widget> mapInvoiceWidget(listInvoice) => listInvoice
      .map<InvoiceWidget>((e) => InvoiceWidget(
            invoice: e,
          ))
      .toList();
  var filterIndex = "0";

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final List<Map<String, dynamic>> listInvoice =
        constants.LIST_INVOICE.toList();

    return SizedBox(
      width: deviceSize.width,
      height: deviceSize.height * 1.5,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(5),
                        prefixIcon: const ImageIcon(
                          AssetImage('assets/images/search.png'),
                          color: CustomColor.black,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(
                              color: CustomColor.black,
                            ))),
                  ),
                ),
                CustomSizedBox(
                  context: context,
                  width: 16,
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: CustomColor.white,
                      border: Border.all(color: CustomColor.black, width: 0.5)),
                  child: PopupMenuButton(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      )),
                      icon: const ImageIcon(
                          AssetImage('assets/images/filter.png')),
                      itemBuilder: (_) => <PopupMenuItem<String>>[
                            PopupMenuItem<String>(
                                child: CustomText(
                                    text: 'Kho tự quản',
                                    color: filterIndex == "1"
                                        ? CustomColor.blue
                                        : CustomColor.black,
                                    context: context,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                                value: '1'),
                            PopupMenuItem<String>(
                                child: CustomText(
                                    text: 'Giữ đồ thuê',
                                    color: filterIndex == "2"
                                        ? CustomColor.blue
                                        : CustomColor.black,
                                    context: context,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                                value: '2'),
                          ],
                      onSelected: (_) {
                        setState(() {
                          filterIndex = _.toString();
                        });
                      }),
                ),
              ],
            ),
            Expanded(
                child: ListView(
              padding: const EdgeInsets.all(0),
              children: mapInvoiceWidget(listInvoice),
            ))
          ],
        ),
      ),
    );
  }
}
