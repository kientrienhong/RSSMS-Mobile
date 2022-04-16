import 'package:flutter/material.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_radio_button.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/custom_text.dart';
import 'package:rssms/models/entity/invoice.dart';
import 'package:rssms/pages/customers/my_account/invoice/invoive_update/invoive_change_item_widget.dart';
import 'package:rssms/pages/customers/my_account/invoice/invoive_update/invoive_extend_widget.dart';

class SendRequestScreen extends StatefulWidget {
  Invoice? invoice;

  SendRequestScreen({Key? key, required this.invoice}) : super(key: key);

  @override
  SendRequestScreenState createState() => SendRequestScreenState();
}

enum CurrentRadioState { extendOrder, modifyItem }

class SendRequestScreenState extends State<SendRequestScreen> {
  CurrentRadioState? _state = CurrentRadioState.extendOrder;

  Color getColor(Set<MaterialState> states) {
    if (states.contains(MaterialState.focused)) {
      return CustomColor.blue;
    }
    return Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          color: CustomColor.white,
          width: deviceSize.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: GestureDetector(
                  onTap: () => {Navigator.of(context).pop()},
                  child: SizedBox(
                    width: 24,
                    height: 24,
                    child: GestureDetector(
                      onTap: () => {Navigator.of(context).pop()},
                      child: Image.asset(
                        'assets/images/arrowLeft.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ),
              CustomText(
                  text: "Các loại yêu cầu",
                  color: CustomColor.blue,
                  context: context,
                  fontWeight: FontWeight.bold,
                  fontSize: 24),
              CustomSizedBox(
                context: context,
                height: 24,
              ),
              CustomRadioButton(
                  function: () {
                    setState(() {
                      _state = CurrentRadioState.extendOrder;
                    });
                  },
                  text: "Gia hạn đơn",
                  color: _state == CurrentRadioState.extendOrder
                      ? CustomColor.blue
                      : CustomColor.white,
                  state: _state,
                  value: CurrentRadioState.extendOrder),
              if (widget.invoice!.typeOrder == 1)
                CustomRadioButton(
                    function: () {
                      setState(() {
                        _state = CurrentRadioState.modifyItem;
                      });
                    },
                    text: "Đặt lịch rút đồ đang được giữ",
                    color: _state == CurrentRadioState.modifyItem
                        ? CustomColor.blue
                        : CustomColor.white,
                    state: _state,
                    value: CurrentRadioState.modifyItem),
              const SizedBox(
                child: Divider(color: CustomColor.black, thickness: 0.5),
              ),
              CustomSizedBox(
                context: context,
                height: 20,
              ),
              if (_state == CurrentRadioState.extendOrder)
                InvoiveExtendWidget(
                  invoice: widget.invoice,
                ),
              if (_state == CurrentRadioState.modifyItem)
                ChangeItemWidget(
                  invoice: widget.invoice,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
