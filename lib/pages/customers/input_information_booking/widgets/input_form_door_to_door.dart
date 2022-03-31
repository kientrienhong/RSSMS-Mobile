import 'package:flutter/material.dart';
import 'package:rssms/common/custom_input_with_hint.dart';
import 'package:rssms/helpers/validator.dart';

class InputFormDoorToDoor extends StatefulWidget {
  TextEditingController controllerAddress;
  TextEditingController controllerFloor;
  FocusNode focusNodeAddress;
  FocusNode focusNodeFloor;

  InputFormDoorToDoor({
    Key? key,
    required this.controllerAddress,
    required this.controllerFloor,
    required this.focusNodeAddress,
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
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomOutLineInputWithHint(
            controller: widget.controllerAddress,
            isDisable: false,
            focusNode: widget.focusNodeAddress,
            deviceSize: deviceSize,
            hintText: 'Địa chỉ',
            nextNode: widget.focusNodeFloor,
            validator: Validator.checkAddress),
      ],
    );
  }
}
