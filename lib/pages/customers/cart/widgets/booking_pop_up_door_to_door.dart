import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rssms/common/custom_button.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/custom_text.dart';
import 'package:rssms/common/list_time_select.dart';
import 'package:rssms/models/booking_pop_up_door_to_door_models.dart';
import 'package:rssms/models/entity/order_booking.dart';
import 'package:rssms/pages/customers/input_information_booking/input_information.dart';
import 'package:rssms/presenters/booking_pop_up_door_to_door_presenters.dart';
import 'package:rssms/views/booking_pop_up_view_door_to_door.dart';

class BookingPopUpDoorToDoor extends StatefulWidget {
  const BookingPopUpDoorToDoor({Key? key}) : super(key: key);

  @override
  State<BookingPopUpDoorToDoor> createState() => _BookingPopUpDoorToDoorState();
}

class _BookingPopUpDoorToDoorState extends State<BookingPopUpDoorToDoor>
    implements BookingPopUpViewDoorToDoor {
  late BookingPopUpDoorToDoorPresenters _presenter;

  late BookingPopUpDoorToDoorModel _model;

  final oCcy = NumberFormat("#,##0", "en_US");
  @override
  void initState() {
    super.initState();
    try {
      OrderBooking orderBooking =
          Provider.of<OrderBooking>(context, listen: false);
      _presenter = BookingPopUpDoorToDoorPresenters(orderBooking);
      _presenter.view = this;
      _model = _presenter.models;
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void onChangeIsCustomerDelivery(bool value) {
    OrderBooking orderBooking =
        Provider.of<OrderBooking>(context, listen: false);
    setState(() {
      orderBooking.setOrderBooking(
          orderBooking: orderBooking.copyWith(
              isCustomerDelivery: value, currentSelectTime: -1));
    });
  }

  @override
  void onChangeTime(int index) {
    OrderBooking orderBooking =
        Provider.of<OrderBooking>(context, listen: false);
    setState(() {
      orderBooking.setOrderBooking(
          orderBooking: orderBooking.copyWith(
              isCustomerDelivery: false, currentSelectTime: index));
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

  String totalEachPart(List<dynamic> list, String type) {
    OrderBooking orderBooking =
        Provider.of<OrderBooking>(context, listen: false);
    var sum = 0;

    for (var element in list) {
      sum += element['price'] * element['quantity'] as int;
    }

    if (type == 'product') {
      sum *= orderBooking.months as int;
    }
    return '${oCcy.format(sum)} VND';
  }

  double totalBill() {
    double sum = 0;
    OrderBooking orderBooking =
        Provider.of<OrderBooking>(context, listen: false);

    List listKeys = orderBooking.productOrder!.keys.toList();

    for (var element in listKeys) {
      if (element == 'product') {
        for (var ele in orderBooking.productOrder![element]!) {
          sum += ele['price'] * ele['quantity'] * orderBooking.months as int;
        }
      } else {
        for (var ele in orderBooking.productOrder![element]!) {
          sum += ele['price'] * ele['quantity'] as int;
        }
      }
    }
    return sum;
    // return '${oCcy.format(sum)} VND';
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    OrderBooking orderBooking =
        Provider.of<OrderBooking>(context, listen: false);

    _selectDateReturn(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _model.dateReturnController.text.isNotEmpty
            ? orderBooking.dateTimeReturn
            : orderBooking.dateTimeDelivery,
        firstDate: _model.dateDeliveryController.text.isNotEmpty == true
            ? orderBooking.dateTimeDelivery
            : DateTime.now().add(const Duration(days: 1)),
        lastDate: DateTime(2025),
      );
      if (picked != null) {
        setState(() {
          String dateReturnString = picked.toIso8601String().split("T")[0];
          orderBooking.setOrderBooking(
              orderBooking: orderBooking.copyWith(
                  dateTimeReturn: picked,
                  dateTimeReturnString: dateReturnString));
          _model.dateReturnController.text = dateReturnString;
        });
        if (_model.dateDeliveryController.text.isNotEmpty &&
            _model.dateReturnController.text.isNotEmpty) {
          setState(() {
            var _diffDate =
                picked.difference(orderBooking.dateTimeDelivery).inDays;
            var _months = (_diffDate / 30).ceil();
            orderBooking.setOrderBooking(
                orderBooking: orderBooking.copyWith(
                    months: _months,
                    diffDay: _diffDate,
                    totalPrice: totalBill(),
                    dateTimeReturn: picked));
          });
        }
      }
    }

    _selectDateDelivery(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: orderBooking.dateTimeDelivery,
        firstDate: DateTime.now().add(const Duration(days: 1)),
        lastDate: DateTime(2025),
      );
      if (picked != null && picked != orderBooking.dateTimeDelivery) {
        setState(() {
          String dateDeliveryString = picked.toIso8601String().split("T")[0];
          orderBooking.setOrderBooking(
              orderBooking: orderBooking.copyWith(
                  dateTimeDelivery: picked,
                  dateTimeDeliveryString: dateDeliveryString));
          _model.dateDeliveryController.text = dateDeliveryString;
        });

        if (_model.dateDeliveryController.text.isNotEmpty &&
            _model.dateReturnController.text.isNotEmpty) {
          setState(() {
            var _diffDate =
                orderBooking.dateTimeReturn.difference(picked).inDays;
            var _months = (_diffDate / 30).ceil();
            orderBooking.setOrderBooking(
                orderBooking: orderBooking.copyWith(
                    months: _months,
                    diffDay: _diffDate,
                    totalPrice: totalBill(),
                    dateTimeDelivery: picked));
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
                        controller: _model.dateDeliveryController,
                        onTap: () => _selectDateDelivery(context),
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
                    currentIndex: orderBooking.currentSelectTime,
                    onChangeTab: onChangeTime,
                  )),
              CustomSizedBox(
                context: context,
                height: 4,
              ),
              GestureDetector(
                onTap: () => onChangeIsCustomerDelivery(
                    !orderBooking.isCustomerDelivery),
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 8),
                      width: 0,
                      child: Checkbox(
                        checkColor: Colors.white,
                        fillColor: MaterialStateProperty.all(CustomColor.blue),
                        value: orderBooking.isCustomerDelivery,
                        shape: const CircleBorder(),
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
                        controller: _model.dateReturnController,
                        onTap: () => _selectDateReturn(context),
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
              buildInfo('Tổng ngày: ', '${orderBooking.diffDay} ngày',
                  CustomColor.blue),
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
                  'Chi phí thuê: ',
                  totalEachPart(
                      orderBooking.productOrder!['product']!, 'product'),
                  CustomColor.black),
              CustomSizedBox(
                context: context,
                height: 8,
              ),
              buildInfo(
                  'Phụ kiện đóng gói: ',
                  totalEachPart(
                      orderBooking.productOrder!['accessory']!, 'accessory'),
                  CustomColor.black),
              CustomSizedBox(
                context: context,
                height: 8,
              ),
              buildInfo(
                  'Dịch vụ hỗ trợ: ',
                  totalEachPart(
                      orderBooking.productOrder!['service']!, 'services'),
                  CustomColor.black),
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
              buildInfo('Tổng cộng ', '${oCcy.format(totalBill())} VND',
                  CustomColor.black),
              CustomSizedBox(
                context: context,
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomButton(
                      height: 24,
                      text: 'Tiếp theo',
                      width: deviceSize.width * 1.2 / 3,
                      onPressFunction: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const InputInformation(
                                      isSelfStorageOrder: false,
                                    )));
                      },
                      isLoading: false,
                      textColor: CustomColor.white,
                      buttonColor: CustomColor.blue,
                      borderRadius: 6),
                  CustomButton(
                      height: 24,
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
