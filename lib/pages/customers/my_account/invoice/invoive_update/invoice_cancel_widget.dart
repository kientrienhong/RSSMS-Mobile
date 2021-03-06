import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rssms/common/custom_bottom_navigation.dart';
import 'package:rssms/common/custom_button.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/custom_snack_bar.dart';
import 'package:rssms/common/custom_text.dart';
import 'package:rssms/models/entity/invoice.dart';
import 'package:rssms/models/entity/user.dart';
import 'package:rssms/models/invoice_cancel_model.dart';
import 'package:rssms/pages/customers/cart/cart_screen.dart';
import 'package:rssms/pages/customers/my_account/my_account.dart';
import 'package:rssms/pages/delivery_staff/notifcation/notification_delivery.dart';
import 'package:rssms/presenters/invoice_cancel_presenter.dart';
import 'package:rssms/views/invoice_cancel_view.dart';
import 'package:rssms/constants/constants.dart' as constants;

class InvoiceCancelWidget extends StatefulWidget {
  final Invoice? invoice;

  const InvoiceCancelWidget({Key? key, required this.invoice})
      : super(key: key);

  @override
  _InvoiceCancelWidgetState createState() => _InvoiceCancelWidgetState();
}

class _InvoiceCancelWidgetState extends State<InvoiceCancelWidget>
    with InvoiceCancelView {
  late InvoiceCancelPresenter _presenter;
  late InvoiceCancelModel _model;

  final _focusNodeReason = FocusNode();

  @override
  void initState() {
    _presenter = InvoiceCancelPresenter();
    _model = _presenter.model;
    _presenter.view = this;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _focusNodeReason.dispose();
    _model.controllerReason.dispose();
  }

  @override
  void onClickCancelInvoice() async {
    Users users = Provider.of<Users>(context, listen: false);
    Map<String, dynamic> cancelRequest = {
      "reason": _model.controllerReason.text,
      "type": 3
    };
    bool result = await _presenter.createRequest(cancelRequest, users);
    if (result) {
      CustomSnackBar.buildSnackbar(
          context: context,
          message: 'Y??u c???u h???y ????n ???? ???????c g???i',
          color: CustomColor.green);
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (context) => const CustomBottomNavigation(
                    listIndexStack: [
                      MyAccountScreen(initIndex: 2,),
                      CartScreen(),
                      NotificationDeliveryScreen(),
                    ],
                    listNavigator: constants.listCustomerBottomNavigation,
                  )),
          (Route<dynamic> route) => false);
    }
  }

  @override
  void updateLoadingCancel() {
    setState(() {
      _model.isLoading != _model.isLoading;
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
            text: "L?? do",
            color: CustomColor.black,
            fontWeight: FontWeight.bold,
            context: context,
            fontSize: 16),
        CustomSizedBox(
          context: context,
          height: 16,
        ),
        TextFormField(
          minLines: 6,
          focusNode: _focusNodeReason,
          controller: _model.controllerReason,
          keyboardType: TextInputType.multiline,
          maxLines: null,
          decoration: const InputDecoration(
            hintText: "",
            contentPadding: EdgeInsets.all(8),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: CustomColor.black),
            ),
          ),
        ),
        CustomSizedBox(
          context: context,
          height: 16,
        ),
        CustomButton(
            height: 24,
            isLoading: _model.isLoading,
            text: 'G???i y??u c???u',
            textColor: CustomColor.white,
            onPressFunction: onClickCancelInvoice,
            width: deviceSize.width,
            buttonColor: CustomColor.blue,
            borderRadius: 6),
      ],
    );
  }
}
