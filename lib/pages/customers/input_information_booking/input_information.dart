import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rssms/common/custom_app_bar.dart';
import 'package:rssms/common/custom_button.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_input_with_hint.dart';
import 'package:rssms/common/custom_radio_button.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/custom_text.dart';
import 'package:rssms/helpers/validator.dart';
import 'package:rssms/models/entity/order_booking.dart';
import 'package:rssms/models/entity/user.dart';
import 'package:rssms/models/input_information_model.dart';
import 'package:rssms/pages/customers/input_information_booking/widgets/input_form_door_to_door.dart';
import 'package:rssms/pages/customers/input_information_booking/widgets/note_select.dart';
import 'package:rssms/pages/customers/payment_method_booking/payment_method_booking_screen.dart';
import 'package:rssms/presenters/input_information_presenter.dart';
import 'package:rssms/views/input_information_view.dart';
import '../../../constants/constants.dart' as constants;

enum SelectDistrict { same, different, notYet }

Widget buildTitle(String name, BuildContext context) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Image.asset('assets/images/delivery.png'),
      CustomSizedBox(
        context: context,
        width: 8,
      ),
      Flexible(
        child: CustomText(
            text: name,
            color: CustomColor.blue,
            fontWeight: FontWeight.bold,
            context: context,
            maxLines: 2,
            fontSize: 18),
      )
    ],
  );
}

class InputInformation extends StatelessWidget {
  final bool isSelfStorageOrder;

  const InputInformation({Key? key, required this.isSelfStorageOrder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const CustomAppBar(
                isHome: false,
                name: '',
              ),
              buildTitle('THÔNG TIN KHÁCH HÀNG', context),
              HandleInput(
                isSelfStorageOrder: isSelfStorageOrder,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class HandleInput extends StatefulWidget {
  final bool isSelfStorageOrder;
  const HandleInput({Key? key, required this.isSelfStorageOrder})
      : super(key: key);

  @override
  _HandleInputState createState() => _HandleInputState();
}

class _HandleInputState extends State<HandleInput>
    implements InputInformationView {
  final _formKey = GlobalKey<FormState>();

  late InputInformationPresenter _presenter;
  late InputInformationModel _model;
  final _focusNodeEmail = FocusNode();
  final _focusNodeFloor = FocusNode();
  final _focusNodePhone = FocusNode();
  final _focusNodeName = FocusNode();
  final _focusNodeAddress = FocusNode();
  final _focusNodeFloorReturn = FocusNode();
  final _focusNodeAddressReturn = FocusNode();

  SelectDistrict currentIndex = SelectDistrict.same;
  List<int> currentIndexNoteChoice = [];

  List<Widget> _buildListReceivedAddress() {
    return constants.LIST_ADDRESS_CHOICES
        .map((e) => CustomRadioButton(
            function: () {
              setState(() {
                currentIndex = e['value'];
              });
            },
            text: e['name'],
            color: currentIndex == e['value']
                ? CustomColor.blue
                : CustomColor.white,
            state: currentIndex,
            value: e['value']))
        .toList();
  }

  List<Widget> _buildListPackagingAddress() {
    return constants.LIST_ADDRESS_PACKAGING_CHOICES
        .map((e) => CustomRadioButton(
            function: () {
              setState(() {
                currentIndex = e['value'];
              });
            },
            text: e['name'],
            color: currentIndex == e['value']
                ? CustomColor.blue
                : CustomColor.white,
            state: currentIndex,
            value: e['value']))
        .toList();
  }

  @override
  void initState() {
    super.initState();
    Users users = Provider.of<Users>(context, listen: false);
    _presenter = InputInformationPresenter(users);
    _model = _presenter.model!;
    _presenter.view = this;
  }

  @override
  void onClickOnContinue() {
    if (_formKey.currentState!.validate()) {
      OrderBooking orderBooking =
          Provider.of<OrderBooking>(context, listen: false);

      if (currentIndex == SelectDistrict.different) {
        orderBooking.setOrderBooking(
            orderBooking: orderBooking.copyWith(
                typeOrder: widget.isSelfStorageOrder
                    ? TypeOrder.selfStorage
                    : TypeOrder.doorToDoor,
                selectDistrict: currentIndex,
                addressDelivery: _model.controllerAddress.text,
                nameCustomer: _model.controllerName.text,
                phoneCustomer: _model.controllerPhone.text,
                note: _model.controllerNote.text,
                floorAddressDelivery: _model.controllerFloor.text,
                emailCustomer: _model.controllerEmail.text,
                addressReturn: _model.controllerAddress.text,
                floorAddressReturn: _model.controllerFloorReturn.text));
      } else if (currentIndex == SelectDistrict.same) {
        orderBooking.setOrderBooking(
            orderBooking: orderBooking.copyWith(
                typeOrder: widget.isSelfStorageOrder
                    ? TypeOrder.selfStorage
                    : TypeOrder.doorToDoor,
                selectDistrict: currentIndex,
                note: _model.controllerNote.text,
                addressDelivery: _model.controllerAddress.text,
                nameCustomer: _model.controllerName.text,
                phoneCustomer: _model.controllerPhone.text,
                floorAddressDelivery: _model.controllerFloor.text,
                emailCustomer: _model.controllerEmail.text,
                addressReturn: _model.controllerAddress.text,
                floorAddressReturn: _model.controllerFloor.text));
      } else {
        orderBooking.setOrderBooking(
            orderBooking: orderBooking.copyWith(
                typeOrder: widget.isSelfStorageOrder
                    ? TypeOrder.selfStorage
                    : TypeOrder.doorToDoor,
                selectDistrict: currentIndex,
                note: _model.controllerNote.text,
                addressDelivery: _model.controllerAddress.text,
                nameCustomer: _model.controllerName.text,
                phoneCustomer: _model.controllerPhone.text,
                floorAddressDelivery: _model.controllerFloor.text,
                emailCustomer: _model.controllerEmail.text,
                addressReturn: '',
                floorAddressReturn: '0'));
      }

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const PaymentMethodBookingScreen()));
    }
  }

  @override
  void onTapChoice(int index, int indexFound) {
    if (indexFound == -1) {
      setState(() {
        currentIndexNoteChoice.add(index);
      });
    } else {
      setState(() {
        currentIndexNoteChoice.remove(index);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomSizedBox(
            context: context,
            height: 16,
          ),
          CustomOutLineInputWithHint(
            controller: _model.controllerName,
            isDisable: false,
            focusNode: _focusNodeName,
            deviceSize: deviceSize,
            hintText: 'Tên của bạn',
            validator: Validator.checkFullname,
            nextNode: _focusNodePhone,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: (deviceSize.width - 48) / 2.1,
                child: CustomOutLineInputWithHint(
                  controller: _model.controllerPhone,
                  isDisable: false,
                  focusNode: _focusNodePhone,
                  deviceSize: deviceSize,
                  validator: Validator.checkPhoneNumber,
                  hintText: 'Số điện thoại',
                  nextNode: _focusNodeEmail,
                ),
              ),
              SizedBox(
                width: (deviceSize.width - 48) / 2.1,
                child: CustomOutLineInputWithHint(
                  controller: _model.controllerEmail,
                  isDisable: false,
                  focusNode: _focusNodeEmail,
                  deviceSize: deviceSize,
                  hintText: 'Email',
                  validator: Validator.checkEmail,
                  nextNode: _focusNodeAddress,
                ),
              ),
            ],
          ),
          InputFormDoorToDoor(
              controllerAddress: _model.controllerAddress,
              controllerFloor: _model.controllerFloor,
              focusNodeAddress: _focusNodeAddress,
              focusNodeFloor: _focusNodeFloor),
          CustomSizedBox(
            context: context,
            height: 8,
          ),
          if (widget.isSelfStorageOrder == false)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildTitle('THÔNG TIN GIAO HÀNG VÀ TRẢ HÀNG', context),
                CustomSizedBox(
                  context: context,
                  height: 16,
                ),
                Column(
                  children: _buildListReceivedAddress(),
                ),
                currentIndex == SelectDistrict.different
                    ? InputFormDoorToDoor(
                        controllerAddress: _model.controllerAddressReturn,
                        controllerFloor: _model.controllerFloorReturn,
                        focusNodeAddress: _focusNodeAddressReturn,
                        focusNodeFloor: _focusNodeFloorReturn,
                      )
                    : Container(),
                CustomSizedBox(
                  context: context,
                  height: 16,
                ),
                CustomText(
                  text: 'Ghi chú',
                  color: CustomColor.blue,
                  context: context,
                  fontSize: 24,
                  textAlign: TextAlign.start,
                  fontWeight: FontWeight.bold,
                ),
                CustomSizedBox(
                  context: context,
                  height: 8,
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      border:
                          Border.all(color: CustomColor.black[3]!, width: 1)),
                  child: TextFormField(
                    minLines: 6,
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(8)),
                    validator: (val) {
                      return Validator.notEmpty(val);
                    },
                    controller: _model.controllerNote,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                  ),
                ),
              ],
            ),
          if (widget.isSelfStorageOrder)
            Column(
              children: [
                buildTitle('ĐỊA CHỈ NHẬN PHỤ KIỆN ĐÓNG GÓI (NẾU CÓ)', context),
                CustomSizedBox(
                  context: context,
                  height: 16,
                ),
                Column(
                  children: _buildListPackagingAddress(),
                ),
                currentIndex == SelectDistrict.different
                    ? InputFormDoorToDoor(
                        controllerAddress: _model.controllerAddressReturn,
                        controllerFloor: _model.controllerFloorReturn,
                        focusNodeAddress: _focusNodeAddressReturn,
                        focusNodeFloor: _focusNodeFloorReturn,
                      )
                    : Container(),
              ],
            ),
          CustomSizedBox(
            context: context,
            height: 24,
          ),
          SizedBox(
            width: double.infinity,
            child: Center(
              child: CustomButton(
                  height: 24,
                  text: 'Tiếp theo',
                  width: deviceSize.width * 1.2 / 3,
                  onPressFunction: () {
                    onClickOnContinue();
                  },
                  isLoading: false,
                  textColor: CustomColor.white,
                  buttonColor: CustomColor.blue,
                  borderRadius: 6),
            ),
          ),
          CustomSizedBox(
            context: context,
            height: 24,
          ),
        ],
      ),
    );
  }
}
