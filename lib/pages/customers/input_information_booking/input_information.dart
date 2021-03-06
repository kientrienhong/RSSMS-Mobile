import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rssms/common/custom_app_bar.dart';
import 'package:rssms/common/custom_button.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_input_with_hint.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/custom_text.dart';
import 'package:rssms/helpers/validator.dart';
import 'package:rssms/models/entity/order_booking.dart';
import 'package:rssms/models/entity/user.dart';
import 'package:rssms/models/input_information_model.dart';
import 'package:rssms/pages/customers/choice_storage/choice_storage_screen.dart';
import 'package:rssms/pages/customers/input_information_booking/widgets/input_form_door_to_door.dart';
import 'package:rssms/presenters/input_information_presenter.dart';
import 'package:rssms/views/input_information_view.dart';

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

  @override
  void initState() {
    super.initState();
    Users users = Provider.of<Users>(context, listen: false);
    _presenter = InputInformationPresenter(users);
    _model = _presenter.model;
    _presenter.view = this;
  }

  @override
  void onClickOnContinue() {
    if (_formKey.currentState!.validate()) {
      OrderBooking orderBooking =
          Provider.of<OrderBooking>(context, listen: false);

      _presenter.onPressContinue(orderBooking, widget.isSelfStorageOrder);

      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const ChoiceStorageScreen()));
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
            focusNode: _model.focusNodeName,
            deviceSize: deviceSize,
            hintText: 'Tên của bạn',
            validator: Validator.checkFullname,
            nextNode: _model.focusNodePhone,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: (deviceSize.width - 48) / 2.1,
                child: CustomOutLineInputWithHint(
                  controller: _model.controllerPhone,
                  isDisable: false,
                  focusNode: _model.focusNodePhone,
                  deviceSize: deviceSize,
                  validator: Validator.checkPhoneNumber,
                  hintText: 'Số điện thoại',
                  nextNode: _model.focusNodeEmail,
                ),
              ),
              SizedBox(
                width: (deviceSize.width - 48) / 2.1,
                child: CustomOutLineInputWithHint(
                  controller: _model.controllerEmail,
                  isDisable: false,
                  focusNode: _model.focusNodeEmail,
                  deviceSize: deviceSize,
                  hintText: 'Email',
                  validator: Validator.checkEmail,
                  nextNode: _model.focusNodeAddress,
                ),
              ),
            ],
          ),
          InputFormDoorToDoor(
            controllerAddress: _model.controllerAddress,
            focusNodeAddress: _model.focusNodeAddress,
          ),
          CustomSizedBox(
            context: context,
            height: 8,
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
