import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rssms/common/custom_button.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/custom_text.dart';
import 'package:rssms/models/booking_pop_up_self_storage_model.dart';
import 'package:rssms/models/entity/order_booking.dart';
import 'package:rssms/pages/customers/input_information_booking/input_information.dart';
import 'package:rssms/presenters/booking_pop_up_self_storage_presenter.dart';
import 'package:rssms/views/booking_pop_up_view_self_storage.dart';

class BookingPopUpSelfStorage extends StatefulWidget {
  const BookingPopUpSelfStorage({Key? key}) : super(key: key);

  @override
  _BookingPopUpSelfStorageState createState() =>
      _BookingPopUpSelfStorageState();
}

class _BookingPopUpSelfStorageState extends State<BookingPopUpSelfStorage>
    implements BookingPopUpViewSelfStorage {
  final oCcy = NumberFormat("#,##0", "en_US");
  late BookingPopUpSelfStoragePresenter _presenter;
  late BookingPopUpSelfStorageModel _model;
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
  void minusQuantity() {
    OrderBooking orderBooking =
        Provider.of<OrderBooking>(context, listen: false);
    if (_model.dateReturn is String) {
      return;
    }
    setState(() {
      if (orderBooking.months > 0) {
        int month = --orderBooking.months;
        _model.dateReturn = DateTime(_model.dateReturn.year,
            _model.dateReturn.month - 1 as int, _model.dateReturn.day);

        orderBooking.setOrderBooking(
            orderBooking: orderBooking.copyWith(
                totalPrice: totalBill(),
                months: month,
                dateTimeReturn: _model.dateReturn,
                dateTimeReturnString:
                    _model.dateReturn.toIso8601String().split("T")[0]));
        _model.monthController.text = month.toString();
      }
    });
  }

  @override
  void addQuantity() {
    OrderBooking orderBooking =
        Provider.of<OrderBooking>(context, listen: false);

    if (_model.dateReturn is String) {
      return;
    }

    setState(() {
      int month = ++orderBooking.months;

      _model.dateReturn = DateTime(
          orderBooking.dateTimeDelivery.year,
          orderBooking.dateTimeDelivery.month + month as int,
          orderBooking.dateTimeDelivery.day);
      orderBooking.setOrderBooking(
          orderBooking: orderBooking.copyWith(
              totalPrice: totalBill(),
              months: month,
              dateTimeReturn: _model.dateReturn,
              dateTimeReturnString:
                  _model.dateReturn.toIso8601String().split("T")[0]));
      _model.monthController.text = month.toString();
    });
  }

  @override
  void setError(String error) {
    setState(() {
      _model.error = error;
    });
  }

  String totalEachPart(List<dynamic> list, String type) {
    OrderBooking orderBooking =
        Provider.of<OrderBooking>(context, listen: false);
    var sum = 0;

    list.forEach((element) {
      sum += element['price'] * element['quantity'] as int;
    });
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

    listKeys.forEach((element) {
      if (element == 'product') {
        orderBooking.productOrder![element]!.forEach((ele) {
          sum += ele['price'] * ele['quantity'] * orderBooking.months as int;
        });
      } else {
        orderBooking.productOrder![element]!.forEach((ele) {
          sum += ele['price'] * ele['quantity'] as int;
        });
      }
    });
    return sum;
    // return '${oCcy.format(sum)} VND';
  }

  _selectDateDelivery(BuildContext context) async {
    OrderBooking orderBooking =
        Provider.of<OrderBooking>(context, listen: false);
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: orderBooking.dateTimeDelivery,
      firstDate: DateTime.now().add(const Duration(days: 1)),
      lastDate: DateTime(2025),
    );

    if (picked != null && picked != orderBooking.dateTimeDelivery) {
      setState(() {
        _model.dateDeliveryController.text =
            picked.toIso8601String().split("T")[0];
        _model.dateReturn = DateTime(
            picked.year, picked.month + orderBooking.months as int, picked.day);
        orderBooking.setOrderBooking(
            orderBooking: orderBooking.copyWith(
                dateTimeDelivery: picked,
                totalPrice: totalBill(),
                dateTimeDeliveryString: picked.toIso8601String().split("T")[0],
                dateTimeReturn: _model.dateReturn,
                dateTimeReturnString:
                    _model.dateReturn.toIso8601String().split("T")[0]));
      });
    }
  }

  @override
  void initState() {
    super.initState();
    OrderBooking orderBooking =
        Provider.of<OrderBooking>(context, listen: false);
    _presenter = BookingPopUpSelfStoragePresenter(orderBooking);
    _model = _presenter.model!;
    _presenter.view = this;
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    final deviceSize = MediaQuery.of(context).size;
    OrderBooking orderBooking =
        Provider.of<OrderBooking>(context, listen: false);
    return AlertDialog(
      insetPadding: const EdgeInsets.all(15),
      content: SizedBox(
        width: double.infinity,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: 'Ngày nhận kho',
                      color: CustomColor.black,
                      context: context,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(
                      width: deviceSize.width / 2.5,
                      child: TextFormField(
                        validator: (value) {
                          if (_model.dateDeliveryController.text.isEmpty) {
                            return 'Vui lòng chọn ngày';
                          }
                          return null;
                        },
                        controller: _model.dateDeliveryController,
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
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                              borderSide:
                                  const BorderSide(color: CustomColor.red)),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                      text: 'Tháng: ',
                      color: CustomColor.black,
                      context: context,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          minusQuantity();
                        },
                        child: SizedBox(
                            height: 20,
                            child: Image.asset(
                              'assets/images/minusButton.png',
                              fit: BoxFit.cover,
                            )),
                      ),
                      CustomSizedBox(
                        context: context,
                        width: 8,
                      ),
                      SizedBox(
                        width: deviceSize.width / 10,
                        height: 24,
                        child: TextFormField(
                          controller: _model.monthController,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 8),
                            border: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(5.0)),
                                borderSide:
                                    BorderSide(color: CustomColor.black[3]!)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(5.0)),
                                borderSide:
                                    BorderSide(color: CustomColor.black[3]!)),
                          ),
                        ),
                      ),
                      CustomSizedBox(
                        context: context,
                        width: 8,
                      ),
                      GestureDetector(
                        onTap: () {
                          addQuantity();
                        },
                        child: SizedBox(
                            height: 20,
                            child: Image.asset('assets/images/addButton.png',
                                fit: BoxFit.cover)),
                      ),
                    ],
                  )
                ],
              ),
              CustomSizedBox(
                context: context,
                height: 16,
              ),
              buildInfo('Ngày trả hàng',
                  _model.dateReturn.toString().split(' ')[0], CustomColor.blue),
              CustomSizedBox(
                context: context,
                height: 16,
              ),
              CustomText(
                  text: 'Tạm tính',
                  color: CustomColor.blue,
                  context: context,
                  fontWeight: FontWeight.bold,
                  fontSize: 24),
              CustomSizedBox(
                context: context,
                height: 16,
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
              if (_model.error.isNotEmpty)
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomText(
                        text: _model.error,
                        textAlign: TextAlign.center,
                        color: CustomColor.red,
                        context: context,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      CustomSizedBox(
                        context: context,
                        height: 8,
                      )
                    ],
                  ),
                ),
              SizedBox(
                width: double.infinity,
                child: Center(
                  child: CustomButton(
                      height: 24,
                      text: 'Tiếp theo',
                      width: deviceSize.width * 1.2 / 3,
                      onPressFunction: () {
                        if (!_formKey.currentState!.validate()) {
                          return;
                        }

                        if (_model.monthController.text == '0') {
                          setError('Vui lòng chọn tháng!');
                          return;
                        }
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const InputInformation(
                                      isSelfStorageOrder: true,
                                    )));
                      },
                      isLoading: false,
                      textColor: CustomColor.white,
                      buttonColor: CustomColor.blue,
                      borderRadius: 6),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
