import 'package:flutter/material.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/pages/customers/my_account/request/request_widget.dart';
import '../../../../constants/constants.dart' as constants;

enum REQUEST_TYPE { modifyRequest, cancelOrderRequest, cancelDeliveryRequest }

class RequestScreen extends StatelessWidget {
  const RequestScreen({Key? key}) : super(key: key);

  List<Widget> mapInvoiceWidget(listRequest) => listRequest
      .map<RequestWidget>((e) => RequestWidget(
            request: e,
          ))
      .toList();

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final List<Map<String, dynamic>> listRequest =
        constants.LIST_REQUEST.toList();

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
              ],
            ),
            Expanded(
                child: ListView(
              padding: const EdgeInsets.all(0),
              children: mapInvoiceWidget(listRequest),
            ))
          ],
        ),
      ),
    );
  }
}
