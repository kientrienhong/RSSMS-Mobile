import 'package:flutter/material.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/custom_text.dart';

class BookingPopUp extends StatefulWidget {
  const BookingPopUp({Key? key}) : super(key: key);

  @override
  State<BookingPopUp> createState() => _BookingPopUpState();
}

class _BookingPopUpState extends State<BookingPopUp> {
  TextEditingController _dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    DateTime selectedDate = DateTime.now();
    final deviceSize = MediaQuery.of(context).size;
    _selectDate(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2025),
      );
      if (picked != null && picked != selectedDate)
        setState(() {
          selectedDate = picked;
          _dateController.text = picked.toIso8601String().split("T")[0];
        });
    }

    return AlertDialog(
      insetPadding: const EdgeInsets.all(15),
      content: SizedBox(
        width: double.infinity,
        height: deviceSize.height * 5 / 6,
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
                      controller: _dateController,
                      onTap: () {
                        _selectDate(context);
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
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
