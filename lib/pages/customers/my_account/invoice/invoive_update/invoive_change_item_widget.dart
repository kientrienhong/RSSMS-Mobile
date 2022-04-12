import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rssms/common/custom_bottom_navigation.dart';
import 'package:rssms/common/custom_button.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_input_date.dart';
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
  Invoice? invoice;

  ChangeItemWidget({Key? key, required this.invoice}) : super(key: key);

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

  @override
  void onClickCreateRequest() async {
    Users users = Provider.of<Users>(context, listen: false);
    List<String>? date = _model.controllerBirthDate.text.split("/");

    Map<String, dynamic> request = {
      "orderId": widget.invoice!.id,
      "deliveryAddress": _model.controllerStreet.text,
      "deliveryTime": constants.listPickUpTime[_currentIndex],
      "deliveryDate": DateTime.parse(date![2] + "-" + date[1] + '-' + date[0]),
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
                      MyAccountScreen(),
                      CartScreen(),
                      NotificationDeliveryScreen(),
                    ],
                    listNavigator: constants.listCustomerBottomNavigation,
                  )),
          (Route<dynamic> route) => false);
    }
  }

  // List<Widget> mapImageWidget(List<Map<String, dynamic>> listImage) => listImage
  //     .mapIndexed<ImageSelectWidget>((i, ele) => ImageSelectWidget(
  //           index: i,
  //           image: ele,
  //           listCurrent: currentIndexNoteChoice,
  //           onTapChoice: onTapChoice,
  //         ))
  //     .toList();

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Container(
      child: Column(
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
                child: CustomOutLineInputDateTime(
                  deviceSize: deviceSize,
                  labelText: '',
                  isDisable: false,
                  focusNode: _focusNodeBirthDate,
                  controller: _model.controllerBirthDate,
                  icon: "assets/images/calendar.png",
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

          // if (widget.invoice!.typeOrder == 1)
          //   CustomText(
          //     text: "Danh sách đồ",
          //     color: CustomColor.black,
          //     context: context,
          //     fontSize: 18,
          //     fontWeight: FontWeight.bold,
          //   ),
          // if (widget.invoice!.typeOrder == 1)
          //   CustomSizedBox(
          //     context: context,
          //     height: 14,
          //   ),
          // if (widget.invoice!.typeOrder == 1)
          // SingleChildScrollView(
          //   scrollDirection: Axis.horizontal,
          //   child: Padding(
          //     padding: const EdgeInsets.symmetric(vertical: 12.0),
          //     child:
          //     Row(
          //       children: mapImageWidget(widget.invoice!["image"]),
          //     ),
          //   ),
          // ),

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
      ),
    );
  }
}
