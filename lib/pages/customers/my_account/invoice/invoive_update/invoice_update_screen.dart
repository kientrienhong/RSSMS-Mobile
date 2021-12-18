import 'package:flutter/material.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/pages/customers/my_account/invoice/invoive_update/invoice_cancel_widget.dart';
import 'package:rssms/pages/customers/my_account/invoice/invoive_update/invoive_change_item_widget.dart';
import 'package:rssms/pages/customers/my_account/invoice/invoive_update/invoive_extend_widget.dart';

class InvoiveUpdateScreen extends StatefulWidget {
  Map<String, dynamic>? invoice;

  InvoiveUpdateScreen({Key? key, required this.invoice}) : super(key: key);

  @override
  InvoiveUpdateScreenState createState() => InvoiveUpdateScreenState();
}

enum CurrentRadioState { giahandon, doido, huydon }

class InvoiveUpdateScreenState extends State<InvoiveUpdateScreen> {
  CurrentRadioState? _state = CurrentRadioState.giahandon;

  Color getColor(Set<MaterialState> states) {
    if (states.contains(MaterialState.focused)) {
      return CustomColor.blue;
    }
    return Colors.white;
  }

  Widget customRadioButton(String text, CurrentRadioState index, Color color) {
    return Row(
      children: [
        OutlinedButton(
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.resolveWith((states) => color),
            shape: MaterialStateProperty.all(CircleBorder()),
          ),
          onPressed: () {
            setState(() {
              _state = index;
            });
          },
          child: const Icon(
            Icons.check,
            size: 20,
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
    );
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: CustomColor.white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          width: deviceSize.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: GestureDetector(
                  onTap: () => {Navigator.of(context).pop()},
                  child: Image.asset('assets/images/arrowLeft.png'),
                ),
              ),
              customRadioButton(
                  "Gia hạn đơn",
                  CurrentRadioState.giahandon,
                  _state == CurrentRadioState.giahandon
                      ? CustomColor.blue
                      : CustomColor.white),
              if (widget.invoice!["type"] == 0)
                customRadioButton(
                    "Đặt lịch thay đổi đồ dùng đang được giữ",
                    CurrentRadioState.doido,
                    _state == CurrentRadioState.doido
                        ? CustomColor.blue
                        : CustomColor.white),
              if (widget.invoice!["type"] == 1)
                customRadioButton(
                    "Dời lịch nhận kho",
                    CurrentRadioState.doido,
                    _state == CurrentRadioState.doido
                        ? CustomColor.blue
                        : CustomColor.white),
              customRadioButton(
                  "Hủy đơn",
                  CurrentRadioState.huydon,
                  _state == CurrentRadioState.huydon
                      ? CustomColor.blue
                      : CustomColor.white),
              CustomSizedBox(
                context: context,
                height: 24,
              ),
              if (_state == CurrentRadioState.giahandon)
                InvoiveExtendWidget(
                  invoice: widget.invoice,
                ),
              if (_state == CurrentRadioState.doido)
                ChangeItemWidget(
                  invoice: widget.invoice,
                ),
              if (_state == CurrentRadioState.huydon)
                const InvoiceCancelWidget()
            ],
          ),
        ),
      ),
    );
  }
}
