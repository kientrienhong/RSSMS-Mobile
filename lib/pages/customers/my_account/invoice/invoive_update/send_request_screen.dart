import 'package:flutter/material.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_radio_button.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/custom_text.dart';
import 'package:rssms/models/entity/invoice.dart';
import 'package:rssms/pages/customers/my_account/invoice/invoive_update/invoive_change_item_widget.dart';
import 'package:rssms/pages/customers/my_account/invoice/invoive_update/invoive_extend_widget.dart';

class SendRequestScreen extends StatefulWidget {
  final Invoice? invoice;

  const SendRequestScreen({Key? key, required this.invoice}) : super(key: key);

  @override
  SendRequestScreenState createState() => SendRequestScreenState();
}

enum CurrentRadioState { extendOrder, modifyItem }

class SendRequestScreenState extends State<SendRequestScreen> {
  Color getColor(Set<MaterialState> states) {
    if (states.contains(MaterialState.focused)) {
      return CustomColor.blue;
    }
    return Colors.white;
  }

  CurrentRadioState? _state = CurrentRadioState.extendOrder;

  @override
  Widget build(BuildContext context) {
    if(widget.invoice!.status == 5){
      _state = CurrentRadioState.modifyItem;
    }
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
                  text: "C??c lo???i y??u c???u",
                  color: CustomColor.blue,
                  context: context,
                  fontWeight: FontWeight.bold,
                  fontSize: 24),
              CustomSizedBox(
                context: context,
                height: 24,
              ),
              if (widget.invoice!.status != 5)
                CustomRadioButton(
                    function: () {
                      setState(() {
                        _state = CurrentRadioState.extendOrder;
                      });
                    },
                    text: "Gia h???n ????n",
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
                    text: "?????t l???ch r??t ????? ??ang ???????c gi???",
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
