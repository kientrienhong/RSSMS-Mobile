import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/custom_text.dart';
import 'package:rssms/models/entity/order_booking.dart';

class BookingPopUpSelfStorage extends StatefulWidget {
  const BookingPopUpSelfStorage({Key? key}) : super(key: key);

  @override
  _BookingPopUpSelfStorageState createState() =>
      _BookingPopUpSelfStorageState();
}

class _BookingPopUpSelfStorageState extends State<BookingPopUpSelfStorage> {
  final oCcy = new NumberFormat("#,##0", "en_US");
  late final _dateDeliveryController;
  late final _dateReturn;
  late int _months;
  late DateTime dateDelivery;
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
    var sum = 0;

    list.forEach((element) {
      sum += element['price'] * element['quantity'] as int;
    });
    if (type == 'product') {
      sum *= _months;
    }
    return '${oCcy.format(sum)} VND';
  }

  String totalBill() {
    var sum = 0;
    OrderBooking orderBooking =
        Provider.of<OrderBooking>(context, listen: false);

    List listKeys = orderBooking.productOrder!.keys.toList();

    listKeys.forEach((element) {
      orderBooking.productOrder![element]!.forEach((ele) {
        sum += ele['price'] * ele['quantity'] as int;
      });
    });

    return '${oCcy.format(sum)} VND';
  }

  _selectDateDelivery(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: dateDelivery,
      firstDate: DateTime.now().add(const Duration(days: 1)),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != dateDelivery) {
      setState(() {
        dateDelivery = picked;
        _dateDeliveryController.text = picked.toIso8601String().split("T")[0];
        _dateReturn = DateTime(picked.year, picked.month + _months, picked.day);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _months = 0;
    _dateDeliveryController = TextEditingController();
    dateDelivery = DateTime.now().add(const Duration(days: 1));
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return AlertDialog(
      insetPadding: const EdgeInsets.all(15),
      content: SizedBox(
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
            Row(
              children: [
                CustomText(
                    text: 'Tháng: ',
                    color: CustomColor.black,
                    context: context,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end!,
                  children: [
                    GestureDetector(
                      // onTap: widget.minusQuantity,
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
                      // width: widget.width,
                      height: 24,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 8),
                          border: OutlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5.0)),
                              borderSide:
                                  BorderSide(color: CustomColor.black[3]!)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5.0)),
                              borderSide:
                                  BorderSide(color: CustomColor.black[3]!)),
                        ),
                        // controller: _controller,
                      ),
                    ),
                    CustomSizedBox(
                      context: context,
                      width: 8,
                    ),
                    GestureDetector(
                      // onTap: widget.addQuantity,
                      child: SizedBox(
                          height: 20,
                          child: Image.asset('assets/images/addButton.png',
                              fit: BoxFit.cover)),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
