import 'package:flutter/material.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:rssms/common/custom_app_bar.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_input.dart';
import 'package:rssms/common/custom_input_with_hint.dart';
import 'package:rssms/common/custom_radio_button.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/custom_text.dart';
import 'package:rssms/pages/customers/input_information_booking/widgets/input_form_door_to_door.dart';
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

class InputInformationDoorToDoor extends StatelessWidget {
  const InputInformationDoorToDoor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              CustomAppBar(
                isHome: false,
              ),
              buildTitle(
                  'ĐỊA CHỈ VÀ THỜI GIAN CHÚNG TÔI ĐẾN LẤY ĐỒ ĐẠC', context),
              HandleInput()
            ],
          ),
        ),
      ),
    );
  }
}

class HandleInput extends StatefulWidget {
  const HandleInput({Key? key}) : super(key: key);

  @override
  _HandleInputState createState() => _HandleInputState();
}

class _HandleInputState extends State<HandleInput> {
  final _focusNodeEmail = FocusNode();
  final _focusNodeFloor = FocusNode();
  final _focusNodeArea = FocusNode();
  final _focusNodePhone = FocusNode();
  final _focusNodeName = FocusNode();
  final _focusNodeAddress = FocusNode();
  final _focusNodeBuilding = FocusNode();
  final _controllerEmail = TextEditingController();
  final _controllerFloor = TextEditingController();
  final _controllerArea = TextEditingController();
  final _controllerPhone = TextEditingController();
  final _controllerName = TextEditingController();
  final _controllerAddress = TextEditingController();
  final _controllerBuilding = TextEditingController();

  final _focusNodeEmailReturn = FocusNode();
  final _focusNodeFloorReturn = FocusNode();
  final _focusNodeAreaReturn = FocusNode();
  final _focusNodePhoneReturn = FocusNode();
  final _focusNodeNameReturn = FocusNode();
  final _focusNodeAddressReturn = FocusNode();
  final _focusNodeBuildingReturn = FocusNode();
  final _controllerEmailReturn = TextEditingController();
  final _controllerFloorReturn = TextEditingController();
  final _controllerAreaReturn = TextEditingController();
  final _controllerPhoneReturn = TextEditingController();
  final _controllerNameReturn = TextEditingController();
  final _controllerAddressReturn = TextEditingController();
  final _controllerBuildingReturn = TextEditingController();

  late String _district;
  late String _ward;
  late String _districtReturn;
  late String _wardReturn;
  SelectDistrict currentIndex = SelectDistrict.same;
  List<Widget> _buildListDropDown() {
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _district = 'Quận';
    _ward = 'Quận';
    _districtReturn = 'Quận';
    _wardReturn = 'Quận';
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    void onChangeDropdownDistrictButton(String value) {
      setState(() {
        _district = value;
      });
    }

    void onChangeDropdownWardButton(String value) {
      setState(() {
        _ward = value;
      });
    }

    void onChangeDropdownDistrictReturnButton(String value) {
      setState(() {
        _districtReturn = value;
      });
    }

    void onChangeDropdownWardReturnButton(String value) {
      setState(() {
        _wardReturn = value;
      });
    }

    return Column(
      children: [
        CustomSizedBox(
          context: context,
          height: 16,
        ),
        CustomOutLineInputWithHint(
          controller: _controllerName,
          isDisable: false,
          focusNode: _focusNodeName,
          deviceSize: deviceSize,
          hintText: 'Tên của bạn',
          nextNode: _focusNodePhone,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: (deviceSize.width - 48) / 2.1,
              child: CustomOutLineInputWithHint(
                controller: _controllerPhone,
                isDisable: false,
                focusNode: _focusNodePhone,
                deviceSize: deviceSize,
                hintText: 'Số điện thoại',
                nextNode: _focusNodeEmail,
              ),
            ),
            SizedBox(
              width: (deviceSize.width - 48) / 2.1,
              child: CustomOutLineInputWithHint(
                controller: _controllerEmail,
                isDisable: false,
                focusNode: _focusNodeEmail,
                deviceSize: deviceSize,
                hintText: 'Email',
                nextNode: _focusNodeAddress,
              ),
            ),
          ],
        ),
        InputFormDoorToDoor(
            onChangeDropdownDistrictButton: onChangeDropdownDistrictButton,
            onChangeDropdownWardButton: onChangeDropdownWardButton,
            controllerAddress: _controllerAddress,
            controllerArea: _controllerArea,
            controllerBuilding: _controllerBuilding,
            district: _district,
            controllerFloor: _controllerFloor,
            ward: _ward,
            focusNodeAddress: _focusNodeAddress,
            focusNodeArea: _focusNodeArea,
            focusNodeBuilding: _focusNodeBuilding,
            focusNodeFloor: _focusNodeFloor),
        buildTitle('ĐỊA CHỈ VÀ THỜI GIAN CHÚNG TÔI TRẢ ĐỒ ĐẠC', context),
        Column(
          children: _buildListDropDown(),
        ),
        currentIndex == SelectDistrict.different
            ? InputFormDoorToDoor(
                onChangeDropdownDistrictButton:
                    onChangeDropdownDistrictReturnButton,
                onChangeDropdownWardButton: onChangeDropdownWardReturnButton,
                controllerAddress: _controllerAddressReturn,
                controllerArea: _controllerAreaReturn,
                controllerBuilding: _controllerBuildingReturn,
                district: _districtReturn,
                controllerFloor: _controllerFloorReturn,
                ward: _wardReturn,
                focusNodeAddress: _focusNodeAddressReturn,
                focusNodeArea: _focusNodeAreaReturn,
                focusNodeBuilding: _focusNodeBuildingReturn,
                focusNodeFloor: _focusNodeFloorReturn,
              )
            : Container()
      ],
    );
  }
}
