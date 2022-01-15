import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rssms/common/custom_button.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_input_date.dart';
import 'package:rssms/common/custom_input_with_hint.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/custom_text.dart';
import 'package:rssms/common/list_time_select.dart';
import 'package:rssms/models/entity/invoice.dart';
import 'package:rssms/models/entity/user.dart';
import 'package:rssms/pages/customers/my_account/invoice/invoive_update/widgets/image_select.dart';
import 'package:collection/collection.dart';

class ChangeItemWidget extends StatefulWidget {
  Invoice? invoice;

  ChangeItemWidget({Key? key, required this.invoice}) : super(key: key);

  @override
  _ChangeItemWidgetState createState() => _ChangeItemWidgetState();
}

class _ChangeItemWidgetState extends State<ChangeItemWidget> {
  final _focusNodeBirthDate = FocusNode();

  final _focusNodeStreet = FocusNode();

  final _controllerBirthDate = TextEditingController();
  final _controllerStreet = TextEditingController();

  String get _birthdate => _controllerBirthDate.text;
  String get _street => _controllerStreet.text;
  List<Map<String, dynamic>> currentIndexNoteChoice = [];

  late int _currentIndex;

  @override
  void initState() {
    Users users = Provider.of<Users>(context, listen: false);
    _controllerStreet.text = users.address!;
    _currentIndex = -1;
    super.initState();
  }

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
  void dispose() {
    super.dispose();
    _focusNodeBirthDate.dispose();
    _focusNodeStreet.dispose();

    _controllerBirthDate.dispose();
    _controllerStreet.dispose();
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
            hintText: "Địa chỉ nhận hàng",
            isDisable: false,
            focusNode: _focusNodeStreet,
            controller: _controllerStreet,
          ),

          if (widget.invoice!.typeOrder == 1)
            CustomText(
              text: "Danh sách đồ",
              color: CustomColor.black,
              context: context,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          if (widget.invoice!.typeOrder == 1)
            CustomSizedBox(
              context: context,
              height: 14,
            ),
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
