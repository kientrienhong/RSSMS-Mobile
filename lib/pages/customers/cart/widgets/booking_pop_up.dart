import 'package:flutter/material.dart';
import 'package:rssms/common/custom_button.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/custom_text.dart';
import 'package:rssms/common/list_time_select.dart';
import 'package:rssms/views/booking_pop_up_view.dart';

class BookingPopUp extends StatefulWidget {
  const BookingPopUp({Key? key}) : super(key: key);

  @override
  State<BookingPopUp> createState() => _BookingPopUpState();
}

class _BookingPopUpState extends State<BookingPopUp>
    implements BookingPopUpView {
  final _dateDeliveryController = TextEditingController();
  final _dateReturnController = TextEditingController();
  DateTime dateDelivery = DateTime.now();
  DateTime dateReturn = DateTime.now();
  late int _currentIndex;
  late bool _isCustomerDelivery;
  late int _diffDate;
  @override
  void initState() {
    super.initState();
    _currentIndex = -1;
    _isCustomerDelivery = false;
    _diffDate = 0;
  }

  @override
  void onChangeIsCustomerDelivery(bool value) {
    setState(() {
      _currentIndex = -1;
      _isCustomerDelivery = !_isCustomerDelivery;
    });
  }

  @override
  void onChangeTime(int index) {
    setState(() {
      _currentIndex = index;
      _isCustomerDelivery = false;
    });
  }

  Widget buildInfo(String title, String value, Color valueColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          text: title,
          color: CustomColor.black,
          context: context,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        CustomText(
            text: value,
            color: valueColor,
            context: context,
            fontWeight: FontWeight.bold,
            fontSize: 16)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    _selectDateReturn(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: dateReturn,
        firstDate: DateTime.now(),
        lastDate: DateTime(2025),
      );
      if (picked != null && picked != dateReturn) {
        setState(() {
          dateReturn = picked;
          _dateReturnController.text = picked.toIso8601String().split("T")[0];
        });
        if (_dateDeliveryController.text.isNotEmpty &&
            _dateReturnController.text.isNotEmpty) {
          setState(() {
            _diffDate = picked.difference(dateDelivery).inDays;
          });
        }
      }
    }

    _selectDateDelivery(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: dateDelivery,
        firstDate: DateTime.now(),
        lastDate: DateTime(2025),
      );
      if (picked != null && picked != dateDelivery) {
        setState(() {
          dateDelivery = picked;
          _dateDeliveryController.text = picked.toIso8601String().split("T")[0];
        });

        if (_dateDeliveryController.text.isNotEmpty &&
            _dateReturnController.text.isNotEmpty) {
          setState(() {
            _diffDate = dateReturn.difference(picked).inDays;
          });
        }
      }
    }

    return AlertDialog(
      insetPadding: const EdgeInsets.all(15),
      content: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomText(
                text: 'Thời gian',
                color: CustomColor.blue,
                context: context,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              CustomSizedBox(
                context: context,
                height: 8,
              ),
              SizedBox(
                width: deviceSize.width,
                height: deviceSize.height / 14,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: 'Ngày lấy hàng',
                      color: CustomColor.black,
                      context: context,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(
                      width: deviceSize.width / 2.5,
                      height: deviceSize.height / 14,
                      child: TextField(
                        controller: _dateDeliveryController,
                        onTap: () {
                          _selectDateDelivery(context);
                        },
                        style: const TextStyle(fontSize: 12),
                        textAlign: TextAlign.center,
                        readOnly: true,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: (deviceSize.height - 12) / 28 -
                                  (deviceSize.height - 12) / 56),
                          hintText: 'yyyy-mm-dd',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                              borderSide:
                                  BorderSide(color: CustomColor.black[2]!)),
                          suffixIcon: const ImageIcon(
                            AssetImage('assets/images/calendar.png'),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              CustomSizedBox(
                context: context,
                height: 8,
              ),
              CustomText(
                text: 'Giờ lấy hàng',
                color: CustomColor.black,
                context: context,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              CustomSizedBox(
                context: context,
                height: 12,
              ),
              SizedBox(
                  height: deviceSize.width * 3 / 9,
                  width: deviceSize.width,
                  child: ListTimeSelect(
                    currentIndex: _currentIndex,
                    onChangeTab: onChangeTime,
                  )),
              CustomSizedBox(
                context: context,
                height: 4,
              ),
              GestureDetector(
                onTap: () => {onChangeIsCustomerDelivery(!_isCustomerDelivery)},
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 8),
                      width: 0,
                      child: Checkbox(
                        checkColor: Colors.white,
                        fillColor: MaterialStateProperty.all(CustomColor.blue),
                        value: _isCustomerDelivery,
                        shape: CircleBorder(),
                        onChanged: (bool? value) {
                          onChangeIsCustomerDelivery(value!);
                        },
                      ),
                    ),
                    CustomSizedBox(
                      context: context,
                      width: 16,
                    ),
                    CustomText(
                        text: 'Khách hàng vận chuyển',
                        color: CustomColor.black,
                        context: context,
                        fontSize: 16)
                  ],
                ),
              ),
              SizedBox(
                width: deviceSize.width,
                height: deviceSize.height / 14,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: 'Ngày trả hàng',
                      color: CustomColor.black,
                      context: context,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(
                      width: deviceSize.width / 2.5,
                      height: deviceSize.height / 14,
                      child: TextField(
                        controller: _dateReturnController,
                        onTap: () {
                          _selectDateReturn(context);
                        },
                        style: const TextStyle(fontSize: 12),
                        textAlign: TextAlign.center,
                        readOnly: true,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: (deviceSize.height - 12) / 28 -
                                  (deviceSize.height - 12) / 56),
                          hintText: 'yyyy-mm-dd',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                              borderSide:
                                  BorderSide(color: CustomColor.black[2]!)),
                          suffixIcon: const ImageIcon(
                            AssetImage('assets/images/calendar.png'),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              CustomSizedBox(
                context: context,
                height: 16,
              ),
              buildInfo('Tổng ngày: ', '${_diffDate} ngày', CustomColor.blue),
              CustomSizedBox(
                context: context,
                height: 16,
              ),
              CustomText(
                text: 'Tạm tính',
                color: CustomColor.blue,
                context: context,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              CustomSizedBox(
                context: context,
                height: 8,
              ),
              buildInfo(
                  'Chi phí thuê: ', '${_diffDate} ngày', CustomColor.black),
              CustomSizedBox(
                context: context,
                height: 8,
              ),
              buildInfo('Phụ kiện đóng gói: ', '${_diffDate} ngày',
                  CustomColor.black),
              CustomSizedBox(
                context: context,
                height: 8,
              ),
              buildInfo(
                  'Dịch vụ hỗ trợ: ', '${_diffDate} ngày', CustomColor.black),
              CustomSizedBox(
                context: context,
                height: 8,
              ),
              Container(
                width: double.infinity,
                height: 1,
                color: CustomColor.black,
              ),
              CustomSizedBox(
                context: context,
                height: 8,
              ),
              buildInfo('Tổng cộng ', '${_diffDate} ngày', CustomColor.black),
              CustomSizedBox(
                context: context,
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomButton(
                      height: 18,
                      text: 'Tiếp theo',
                      width: deviceSize.width * 1.2 / 3,
                      onPressFunction: () {},
                      isLoading: false,
                      textColor: CustomColor.white,
                      buttonColor: CustomColor.blue,
                      borderRadius: 6),
                  CustomButton(
                      height: 18,
                      text: 'Hủy',
                      width: deviceSize.width * 0.7 / 3,
                      onPressFunction: () {
                        Navigator.of(context).pop();
                      },
                      isLoading: false,
                      textColor: CustomColor.red,
                      buttonColor: CustomColor.white,
                      isCancelButton: true,
                      borderRadius: 6),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
