import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:rssms/common/custom_button.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_input_date.dart';
import 'package:rssms/common/custom_input_with_hint.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/custom_text.dart';
import 'package:rssms/common/list_time_select.dart';
import 'package:rssms/common/invoice_image_widget.dart';
import 'package:rssms/pages/customers/my_account/invoice/invoive_update/widgets/image_select.dart';
import 'package:collection/collection.dart';

class ChangeItemWidget extends StatefulWidget {
  Map<String, dynamic>? invoice;

  ChangeItemWidget({Key? key, required this.invoice}) : super(key: key);

  @override
  _ChangeItemWidgetState createState() => _ChangeItemWidgetState();
}

class _ChangeItemWidgetState extends State<ChangeItemWidget> {
  final _focusNodeBirthDate = FocusNode();
  final _focusNodeDistrict = FocusNode();
  final _focusNodeStreet = FocusNode();
  final _focusNodeWard = FocusNode();

  final _controllerBirthDate = TextEditingController();
  final _controllerStreet = TextEditingController();
  final _controllerWard = TextEditingController();
  final _controllerDistrict = TextEditingController();

  String get _birthdate => _controllerBirthDate.text;
  String get _street => _controllerStreet.text;
  String get _wart => _controllerWard.text;
  String get _district => _controllerWard.text;
  List<Map<String, dynamic>> currentIndexNoteChoice = [];

  late int _currentIndex;

  void onChangeTime(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void onTapChoice(Map<String, dynamic> image, int indexFound, int index) {
    if (indexFound == -1) {
      setState(() {
        currentIndexNoteChoice.add({...image, 'index': index});
      });
    } else {
      setState(() {
        currentIndexNoteChoice.removeAt(indexFound);
      });
    }
  }

  @override
  void initState() {
    _currentIndex = -1;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _focusNodeBirthDate.dispose();
    _focusNodeStreet.dispose();
    _focusNodeWard.dispose();
    _focusNodeDistrict.dispose();

    _controllerBirthDate.dispose();
    _controllerStreet.dispose();
    _controllerWard.dispose();
    _controllerDistrict.dispose();
  }

  List<Widget> mapImageWidget(List<Map<String, dynamic>> listImage) => listImage
      .mapIndexed<ImageSelectWidget>((i, ele) => ImageSelectWidget(
            index: i,
            image: ele,
            listCurrent: currentIndexNoteChoice,
            onTapChoice: onTapChoice,
          ))
      .toList();

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18),
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
                  text: widget.invoice!["returnnDate"],
                  color: Colors.black,
                  context: context,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
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
                child: CustomOutLineInputDateTime(
                  deviceSize: deviceSize,
                  labelText: '',
                  isDisable: false,
                  focusNode: _focusNodeBirthDate,
                  controller: _controllerBirthDate,
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
            hintText: "Đường",
            isDisable: false,
            focusNode: _focusNodeStreet,
            controller: _controllerStreet,
          ),
          Row(
            children: [
              SizedBox(
                width: deviceSize.width / 3,
                child: CustomOutLineInputWithHint(
                  deviceSize: deviceSize,
                  hintText: 'Phường',
                  isDisable: false,
                  textInputType: TextInputType.number,
                  focusNode: _focusNodeWard,
                  controller: _controllerWard,
                ),
              ),
              CustomSizedBox(
                context: context,
                width: 16,
              ),
              SizedBox(
                width: deviceSize.width / 4,
                child: CustomOutLineInputWithHint(
                  deviceSize: deviceSize,
                  hintText: 'Quận',
                  isDisable: false,
                  isSecure: true,
                  focusNode: _focusNodeDistrict,
                  controller: _controllerDistrict,
                ),
              ),
            ],
          ),
          if (widget.invoice!["type"] == 0)
            CustomText(
              text: "Danh sách đồ",
              color: CustomColor.black,
              context: context,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          if (widget.invoice!["type"] == 0)
            CustomSizedBox(
              context: context,
              height: 14,
            ),
          if (widget.invoice!["type"] == 0)
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Row(
                  children: mapImageWidget(widget.invoice!["image"]),
                ),
              ),
            ),
          CustomSizedBox(
            context: context,
            height: 14,
          ),
          CustomButton(
              height: 24,
              isLoading: false,
              text: 'Gửi yêu cầu',
              textColor: CustomColor.white,
              onPressFunction: null,
              width: deviceSize.width,
              buttonColor: CustomColor.blue,
              borderRadius: 6),
        ],
      ),
    );
  }
}
