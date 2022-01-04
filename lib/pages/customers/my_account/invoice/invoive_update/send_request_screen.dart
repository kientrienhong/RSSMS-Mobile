import 'package:flutter/material.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/custom_text.dart';
import 'package:rssms/pages/customers/my_account/invoice/invoive_update/invoice_cancel_widget.dart';
import 'package:rssms/pages/customers/my_account/invoice/invoive_update/invoive_change_item_widget.dart';
import 'package:rssms/pages/customers/my_account/invoice/invoive_update/invoive_extend_widget.dart';

class SendRequestScreen extends StatefulWidget {
  Map<String, dynamic>? invoice;

  SendRequestScreen({Key? key, required this.invoice}) : super(key: key);

  @override
  SendRequestScreenState createState() => SendRequestScreenState();
}

enum CurrentRadioState { extendOrder, modifyItem, cancelOrder }

class SendRequestScreenState extends State<SendRequestScreen> {
  CurrentRadioState? _state = CurrentRadioState.extendOrder;

  Color getColor(Set<MaterialState> states) {
    if (states.contains(MaterialState.focused)) {
      return CustomColor.blue;
    }
    return Colors.white;
  }

  Widget customRadioButton(String text, CurrentRadioState index, Color color) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _state = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.only(left: 10),
        child: Row(
          children: [
            OutlinedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.resolveWith((states) => color),
                shape: MaterialStateProperty.all(const CircleBorder()),
                side: MaterialStateProperty.all(
                  const BorderSide(color: CustomColor.blue, width: 1.5),
                ),
                maximumSize: MaterialStateProperty.all(
                  const Size(50, 50),
                ),
                minimumSize: MaterialStateProperty.all(
                  const Size(25, 25),
                ),
              ),
              onPressed: () {},
              child: const Icon(
                Icons.check,
                size: 15,
                color: CustomColor.white,
              ),
            ),
            Text(
              text,
              style: TextStyle(
                fontSize: 14,
                color: (_state == index) ? CustomColor.blue : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 24),
          color: CustomColor.white,
          width: deviceSize.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
                child: GestureDetector(
                  onTap: () => {Navigator.of(context).pop()},
                  child: Image.asset('assets/images/arrowLeft.png'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: CustomText(
                    text: "Các loại yêu cầu",
                    color: CustomColor.blue,
                    context: context,
                    fontWeight: FontWeight.bold,
                    fontSize: 24),
              ),
              CustomSizedBox(
                context: context,
                height: 8,
              ),
              customRadioButton(
                  "Gia hạn đơn",
                  CurrentRadioState.extendOrder,
                  _state == CurrentRadioState.extendOrder
                      ? CustomColor.blue
                      : CustomColor.white),
              if (widget.invoice!["type"] == 0)
                customRadioButton(
                    "Đặt lịch thay đổi đồ dùng đang được giữ",
                    CurrentRadioState.modifyItem,
                    _state == CurrentRadioState.modifyItem
                        ? CustomColor.blue
                        : CustomColor.white),
              if (widget.invoice!["type"] == 1)
                customRadioButton(
                    "Dời lịch nhận kho",
                    CurrentRadioState.modifyItem,
                    _state == CurrentRadioState.modifyItem
                        ? CustomColor.blue
                        : CustomColor.white),
              customRadioButton(
                  "Hủy đơn",
                  CurrentRadioState.cancelOrder,
                  _state == CurrentRadioState.cancelOrder
                      ? CustomColor.blue
                      : CustomColor.white),
              CustomSizedBox(
                context: context,
                height: 24,
              ),
              if (_state == CurrentRadioState.extendOrder)
                InvoiveExtendWidget(
                  invoice: widget.invoice,
                ),
              if (_state == CurrentRadioState.modifyItem)
                ChangeItemWidget(
                  invoice: widget.invoice,
                ),
              if (_state == CurrentRadioState.cancelOrder)
                const InvoiceCancelWidget()
            ],
          ),
        ),
      ),
    );
  }
}
