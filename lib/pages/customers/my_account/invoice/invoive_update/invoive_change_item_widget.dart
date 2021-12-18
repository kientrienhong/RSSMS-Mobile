import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rssms/common/custom_button.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_input_date.dart';
import 'package:rssms/common/custom_input_with_hint.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/custom_text.dart';
import 'package:rssms/common/list_time_select.dart';
import 'package:rssms/pages/customers/my_account/invoice/invoice_detail_screen/invoice_image_widget.dart';

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

  late int _currentIndex;

  void onChangeTime(int index) {
    setState(() {
      _currentIndex = index;
    });
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

  List<Widget> mapImageWidget(listImage) => listImage
      .map<InvoiceImageWidget>((i) => InvoiceImageWidget(
            image: i,
          ))
      .toList();

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Flexible(
                child: Text(
                  "Ngày nhận hàng hiện tại",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
              CustomSizedBox(
                context: context,
                width: deviceSize.width / 4,
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
              CustomText(
                  text: "Ngày nhận hàng mới",
                  color: Colors.black,
                  context: context,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
              Container(
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
              Container(
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
              Container(
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
            CarouselSlider(
              items: mapImageWidget(widget.invoice!["image"]),
              //Slider Container properties
              options: CarouselOptions(
                height: 180.0,
                enlargeCenterPage: true,
                aspectRatio: 16 / 9,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                viewportFraction: 0.8,
              ),
            ),
          CustomSizedBox(
            context: context,
            height: 14,
          ),
          CustomButton(
              height: 18,
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
