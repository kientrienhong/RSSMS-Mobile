import 'package:flutter/material.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_input_with_hint.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/custom_text.dart';

class InputFormDoorToDoor extends StatefulWidget {
  TextEditingController controllerAddress;
  TextEditingController controllerBuilding;
  TextEditingController controllerArea;
  TextEditingController controllerFloor;
  FocusNode focusNodeAddress;
  FocusNode focusNodeBuilding;
  FocusNode focusNodeArea;
  FocusNode focusNodeFloor;

  Function onChangeDropdownDistrictButton;
  Function onChangeDropdownWardButton;
  String? district;
  String? ward;

  InputFormDoorToDoor({
    Key? key,
    required this.onChangeDropdownDistrictButton,
    required this.onChangeDropdownWardButton,
    required this.controllerAddress,
    required this.controllerArea,
    required this.controllerBuilding,
    required this.district,
    required this.controllerFloor,
    required this.ward,
    required this.focusNodeAddress,
    required this.focusNodeArea,
    required this.focusNodeBuilding,
    required this.focusNodeFloor,
  }) : super(key: key);

  @override
  _InputFormDoorToDoorState createState() => _InputFormDoorToDoorState();
}

class _InputFormDoorToDoorState extends State<InputFormDoorToDoor> {
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Column(
      children: [
        CustomOutLineInputWithHint(
          controller: widget.controllerAddress,
          isDisable: false,
          focusNode: widget.focusNodeAddress,
          deviceSize: deviceSize,
          hintText: 'Địa chỉ',
          nextNode: widget.focusNodeBuilding,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: (deviceSize.width - 48) / 2.1,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                  border: Border.all(color: CustomColor.black[3]!, width: 1),
                  borderRadius: BorderRadius.circular(4)),
              child: DropdownButton(
                  isExpanded: true,
                  icon: const ImageIcon(
                    AssetImage('assets/images/arrowDown.png'),
                  ),
                  iconSize: 16,
                  hint: CustomText(
                      text: 'Quận',
                      color: CustomColor.black[2]!,
                      context: context,
                      fontSize: 16),
                  underline: Container(
                    width: 0,
                  ),
                  value: widget.district,
                  onChanged: (value) {
                    widget.onChangeDropdownDistrictButton(value as String);
                  },
                  items: <String>['Quận', 'Customer', 'Owner']
                      .map((e) => DropdownMenuItem<String>(
                          value: e,
                          child: CustomText(
                              text: e,
                              color: const Color.fromARGB(255, 23, 22, 26),
                              context: context,
                              fontSize: 16)))
                      .toList()),
            ),
            Container(
              width: (deviceSize.width - 48) / 2.1,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                  border: Border.all(color: CustomColor.black[3]!, width: 1),
                  borderRadius: BorderRadius.circular(4)),
              child: DropdownButton(
                  isExpanded: true,
                  icon: const ImageIcon(
                    AssetImage('assets/images/arrowDown.png'),
                  ),
                  iconSize: 16,
                  hint: CustomText(
                      text: 'Quận',
                      color: CustomColor.black[2]!,
                      context: context,
                      fontSize: 16),
                  underline: Container(
                    width: 0,
                  ),
                  value: widget.ward,
                  onChanged: (value) {
                    widget.onChangeDropdownWardButton(value as String);
                  },
                  items: <String>['Phường', 'Customer', 'Owner']
                      .map((e) => DropdownMenuItem<String>(
                          value: e,
                          child: CustomText(
                              text: e,
                              color: const Color.fromARGB(255, 23, 22, 26),
                              context: context,
                              fontSize: 16)))
                      .toList()),
            ),
          ],
        ),
        CustomSizedBox(
          context: context,
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: (deviceSize.width - 48) / 3.2,
              child: CustomOutLineInputWithHint(
                  controller: widget.controllerBuilding,
                  isDisable: false,
                  focusNode: widget.focusNodeBuilding,
                  deviceSize: deviceSize,
                  hintText: 'Tòa nhà',
                  nextNode: widget.focusNodeArea),
            ),
            SizedBox(
              width: (deviceSize.width - 48) / 3.2,
              child: CustomOutLineInputWithHint(
                controller: widget.controllerArea,
                isDisable: false,
                focusNode: widget.focusNodeArea,
                deviceSize: deviceSize,
                hintText: 'Khu',
                nextNode: widget.focusNodeFloor,
              ),
            ),
            SizedBox(
              width: (deviceSize.width - 48) / 3.2,
              child: CustomOutLineInputWithHint(
                controller: widget.controllerFloor,
                isDisable: false,
                focusNode: widget.focusNodeFloor,
                deviceSize: deviceSize,
                hintText: 'Tầng',
              ),
            ),
          ],
        ),
      ],
    );
  }
}
