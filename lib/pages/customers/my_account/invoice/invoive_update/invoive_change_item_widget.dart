import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rssms/common/custom_bottom_navigation.dart';
import 'package:rssms/common/custom_button.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_input_with_hint.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/custom_snack_bar.dart';
import 'package:rssms/common/custom_text.dart';
import 'package:rssms/common/list_time_select.dart';
import 'package:rssms/models/entity/invoice.dart';
import 'package:rssms/models/entity/user.dart';
import 'package:rssms/models/invoice_get_model.dart';
import 'package:rssms/pages/customers/cart/cart_screen.dart';
import 'package:rssms/pages/customers/my_account/my_account.dart';
import 'package:rssms/pages/delivery_staff/notifcation/notification_delivery.dart';
import 'package:rssms/presenters/invoice_get_presenter.dart';
import 'package:rssms/utils/ui_utils.dart';
import 'package:rssms/views/invoice_get_view.dart';
import 'package:rssms/constants/constants.dart' as constants;

class ChangeItemWidget extends StatefulWidget {
  final Invoice? invoice;

  const ChangeItemWidget({Key? key, required this.invoice}) : super(key: key);

  @override
  _ChangeItemWidgetState createState() => _ChangeItemWidgetState();
}

class _ChangeItemWidgetState extends State<ChangeItemWidget>
    with InvoiceGetView {
  late InvoiceGetPresenter _presenter;
  late InvoiceGetModel _model;

  final _focusNodeBirthDate = FocusNode();
  final _focusNodeStreet = FocusNode();

  // List<Map<String, dynamic>> currentIndexNoteChoice = [];

  late int _currentIndex;

  @override
  void initState() {
    Users users = Provider.of<Users>(context, listen: false);
    _presenter = InvoiceGetPresenter();
    _model = _presenter.model;
    _presenter.view = this;
    _model.controllerStreet.text = users.address!;
    _currentIndex = -1;
    super.initState();
  }

  void onChangeTime(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  // void onTapChoice(Map<String, dynamic> image, int indexFound, int index) {
  //   if (indexFound == -1) {
  //     setState(() {
  //       currentIndexNoteChoice.add({...image, 'index': index});
  //     });
  //   } else {
  //     setState(() {
  //       currentIndexNoteChoice.removeAt(indexFound);
  //     });
  //   }
  // }
  final oCcy = NumberFormat("#,##0", "en_US");
  @override
  void dispose() {
    super.dispose();
    _focusNodeBirthDate.dispose();
    _focusNodeStreet.dispose();

    _model.controllerBirthDate.dispose();
    _model.controllerStreet.dispose();
  }

  @override
  void updateStatusButton() {
    setState(() {
      _model.isLoadingButton = !_model.isLoadingButton;
    });
  }

  @override
  void updateError(String error) {
    setState(() {
      _model.error = error;
    });
  }

  _selectDateDelivery(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now().add(const Duration(days: 1)),
      lastDate: DateTime(2025),
    );
    if (picked != null) {
      String dateDeliveryString = picked.toIso8601String().split("T")[0];
      if (DateTime.parse(dateDeliveryString)
          .isAfter(DateTime.parse(widget.invoice!.returnDate))) {
        _model.isAfter = true;
      } else {
        _model.isAfter = false;
      }
      setState(() {
        _model.controllerBirthDate.text = dateDeliveryString;
      });
    }
  }

  @override
  void onClickCreateRequest() async {
    Users users = Provider.of<Users>(context, listen: false);
    List<String>? date = _model.controllerBirthDate.text.split("-");
    if (_model.deliveryFee == 0) {
      _presenter.view.updateError("Vui lòng kiểm tra phí vận chuyển");
      return;
    } else {
      _presenter.view.updateError("");
    }
    if (_currentIndex == -1 || _model.controllerBirthDate.text.isEmpty) {
      _presenter.view.updateError("Vui lòng chọn thời gian nhận hàng");
      return;
    }
    Map<String, dynamic> request = {
      "orderId": widget.invoice!.id,
      "isCustomerDedlivery": false,
      "deliveryAddress": _model.controllerStreet.text,
      "deliveryTime": constants.listPickUpTime[_currentIndex],
      "deliveryDate": DateFormat("dd-MM-yyyy")
          .parse(date![2] + "-" + date[1] + '-' + date[0]),
      "type": 4
    };
    bool result = await _presenter.createRequest(request, users);
    if (result) {
      CustomSnackBar.buildSnackbar(
          context: context,
          message: 'Yêu cầu rút đồ đã đươc gửi',
          color: CustomColor.green);
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (context) => const CustomBottomNavigation(
                    listIndexStack: [
                      MyAccountScreen(
                        initIndex: 2,
                      ),
                      CartScreen(),
                      NotificationDeliveryScreen(),
                    ],
                    listNavigator: constants.listCustomerBottomNavigation,
                  )),
          (Route<dynamic> route) => false);
    }
  }

  @override
  void onClickCheckAddress() {
    Users user = Provider.of<Users>(context, listen: false);
    _presenter.onClickCheckAddress(widget.invoice!, user);
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: deviceSize.width * 1.3 / 3,
              child: CustomText(
                text: "Ngày nhận hàng hiện tại",
                color: CustomColor.black,
                context: context,
                fontWeight: FontWeight.bold,
                maxLines: 2,
                fontSize: 18,
                textOverflow: TextOverflow.ellipsis,
              ),
            ),
            CustomText(
                text: widget.invoice!.returnDate
                    .substring(0, widget.invoice!.returnDate.indexOf("T")),
                color: Colors.black,
                context: context,
                fontWeight: FontWeight.bold,
                fontSize: 18),
          ],
        ),
        CustomSizedBox(
          context: context,
          height: 14,
        ),
        CustomText(
          text: "Địa chỉ",
          color: CustomColor.black,
          context: context,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        CustomSizedBox(
          context: context,
          height: 14,
        ),
        CustomOutLineInputWithHint(
          deviceSize: deviceSize,
          hintText: "Địa chỉ nhận hàng",
          isDisable: false,
          focusNode: _focusNodeStreet,
          controller: _model.controllerStreet,
        ),
        Row(
          children: [
            CustomButton(
                height: 24,
                text: "Xem phí vận chuyển",
                width: deviceSize.width / 3,
                onPressFunction: onClickCheckAddress,
                isLoading: _model.isLoadingButton,
                textColor: CustomColor.white,
                buttonColor: CustomColor.blue,
                borderRadius: 6),
            CustomSizedBox(
              context: context,
              width: 5,
            ),
            CustomText(
                text: "Phí vận chuyển",
                color: CustomColor.black,
                context: context,
                fontWeight: FontWeight.bold,
                fontSize: 16),
            CustomSizedBox(
              context: context,
              width: 5,
            ),
            CustomText(
                text: '${oCcy.format(_model.deliveryFee)}  đ',
                color: CustomColor.black,
                context: context,
                fontSize: 16)
          ],
        ),
        CustomSizedBox(
          context: context,
          height: 24,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: deviceSize.width * 1.3 / 3,
              child: CustomText(
                text: "Ngày nhận hàng mới",
                color: CustomColor.black,
                context: context,
                fontWeight: FontWeight.bold,
                maxLines: 2,
                fontSize: 18,
                textOverflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(
              width: deviceSize.width / 2.5,
              height: deviceSize.height / 14,
              child: TextFormField(
                validator: ((value) =>
                    value!.isEmpty ? "* Vui lòng nhập ngày" : null),
                controller: _model.controllerBirthDate,
                onTap: () => _selectDateDelivery(context),
                style: const TextStyle(fontSize: 12),
                textAlign: TextAlign.center,
                readOnly: true,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                      vertical: (deviceSize.height - 12) / 28 -
                          (deviceSize.height - 12) / 56),
                  hintText: 'yyyy-mm-dd',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide: BorderSide(color: CustomColor.black[2]!)),
                  suffixIcon: const ImageIcon(
                    AssetImage('assets/images/calendar.png'),
                  ),
                ),
              ),
            ),
          ],
        ),
        CustomText(
            text: "Thời gian nhận hàng mới",
            color: Colors.black,
            context: context,
            fontWeight: FontWeight.bold,
            fontSize: 18),
        CustomSizedBox(
          context: context,
          height: 14,
        ),
        SizedBox(
          height: deviceSize.width * 3 / 7,
          width: deviceSize.width,
          child: ListTimeSelect(
              currentIndex: _currentIndex, onChangeTab: onChangeTime),
        ),
        if (_model.isAfter)
          CustomText(
              text:
                  "* Ngày rút đồ sau ngày hết hạn của đơn, có thể sẽ phát sinh thêm phí",
              color: CustomColor.blue,
              maxLines: 2,
              fontWeight: FontWeight.bold,
              context: context,
              fontSize: 16),
        CustomSizedBox(
          context: context,
          height: 14,
        ),
        UIUtils.buildErrorUI(error: _model.error, context: context),
        CustomButton(
            height: 24,
            isLoading: _model.isLoadingButton,
            text: 'Gửi yêu cầu',
            textColor: CustomColor.white,
            onPressFunction: () {
              onClickCreateRequest();
            },
            width: deviceSize.width,
            buttonColor: CustomColor.blue,
            borderRadius: 6),
      ],
    );
  }
}
