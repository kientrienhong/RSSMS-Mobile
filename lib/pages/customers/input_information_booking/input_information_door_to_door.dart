import 'package:dropdown_below/dropdown_below.dart';
import 'package:flutter/material.dart';
import 'package:rssms/common/custom_app_bar.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_input.dart';
import 'package:rssms/common/custom_input_with_hint.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/custom_text.dart';

class InputInformationDoorToDoor extends StatelessWidget {
  const InputInformationDoorToDoor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget buildTitle(String name) {
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

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              CustomAppBar(
                isHome: false,
              ),
              buildTitle('ĐỊA CHỈ VÀ THỜI GIAN CHÚNG TÔI ĐẾN LẤY ĐỒ ĐẠC'),
              FormInput()
            ],
          ),
        ),
      ),
    );
  }
}

class FormInput extends StatefulWidget {
  const FormInput({Key? key}) : super(key: key);

  @override
  _FormInputState createState() => _FormInputState();
}

class _FormInputState extends State<FormInput> {
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
  String dropdownValue = 'One';
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

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
        CustomOutLineInputWithHint(
          controller: _controllerAddress,
          isDisable: false,
          focusNode: _focusNodeAddress,
          deviceSize: deviceSize,
          hintText: 'Địa chỉ',
          nextNode: _focusNodeBuilding,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: (deviceSize.width - 48) / 2.1,
              child: DropdownButton<String>(
                value: dropdownValue,
                icon: const Icon(Icons.arrow_downward),
                elevation: 16,
                style: const TextStyle(color: Colors.deepPurple),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue = newValue!;
                  });
                },
                items: <String>['One', 'Two', 'Free', 'Four']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: (deviceSize.width - 48) / 3.2,
              child: CustomOutLineInputWithHint(
                  controller: _controllerBuilding,
                  isDisable: false,
                  focusNode: _focusNodeBuilding,
                  deviceSize: deviceSize,
                  hintText: 'Tòa nhà',
                  nextNode: _focusNodeArea),
            ),
            SizedBox(
              width: (deviceSize.width - 48) / 3.2,
              child: CustomOutLineInputWithHint(
                controller: _controllerArea,
                isDisable: false,
                focusNode: _focusNodeArea,
                deviceSize: deviceSize,
                hintText: 'Khu',
                nextNode: _focusNodeFloor,
              ),
            ),
            SizedBox(
              width: (deviceSize.width - 48) / 3.2,
              child: CustomOutLineInputWithHint(
                controller: _controllerFloor,
                isDisable: false,
                focusNode: _focusNodeFloor,
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
