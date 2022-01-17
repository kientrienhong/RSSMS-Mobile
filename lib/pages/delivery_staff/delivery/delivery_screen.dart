import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rssms/common/custom_button.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/custom_text.dart';
import 'package:collection/collection.dart';
import 'package:rssms/models/delivery_screen_model.dart';
import 'package:rssms/pages/customers/cart/widgets/product_widget.dart';
import 'package:rssms/pages/delivery_staff/delivery/widgets/schedule_widget.dart';
import 'package:rssms/presenters/delivery_presenter.dart';
import 'package:rssms/views/delivery_screen_view.dart';
import '../../../constants/constants.dart' as constants;

enum ORDER_STATUS { notYet, completed }

class DeliveryScreen extends StatefulWidget {
  const DeliveryScreen({Key? key}) : super(key: key);

  @override
  _DeliveryScreenState createState() => _DeliveryScreenState();
}

class _DeliveryScreenState extends State<DeliveryScreen>
    implements DeliveryScreenView {
  late DeliveryPresenter _presenter;
  late DeliveryScreenModel _model;
  late int _currentIndex;
  late List<DateTime> listDateTime;

  @override
  void initState() {
    super.initState();
    _presenter = DeliveryPresenter();
    _model = _presenter.model;
    _presenter.view = this;
    listDateTime = [];
    DateTime now = DateTime.now();
    var firstDay = now.subtract(Duration(days: now.weekday - 1));
    for (int i = 0; i < 7; i++) {
      listDateTime.add(firstDay);
      if (firstDay.isAtSameMomentAs(now)) {
        _currentIndex = i;
      }
      firstDay = firstDay.add(const Duration(days: 1));
    }
  }

  List<Widget> mapListSchedule() {
    return constants.LIST_SCHEDULE_DELIVERY
        .mapIndexed((index, element) => ScheduleWidget(
            schedule: element,
            currentIndex: index,
            listLength: constants.LIST_SCHEDULE_DELIVERY.length))
        .toList();
  }

  Widget formatDate(DateTime dateTime, int index) {
    final splitedDay = DateFormat.yMEd().format(dateTime).split(', ');
    final day = splitedDay[0];
    final splitedDate = splitedDay[1].split('/');
    Color color =
        index == _currentIndex ? CustomColor.blue : CustomColor.black[3]!;
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(right: 16),
        child: Column(
          children: [
            CustomText(
                text: day,
                color: color,
                context: context,
                fontWeight: FontWeight.bold,
                fontSize: 24),
            CustomSizedBox(
              context: context,
              height: 8,
            ),
            CustomText(
                text: '${splitedDate[1]}/${splitedDate[0]}',
                color: color,
                context: context,
                fontWeight: FontWeight.bold,
                fontSize: 16)
          ],
        ),
      ),
    );
  }

  List<Widget> mapProductWidget(listProduct) => listProduct
      .map<ProductWidget>((e) => ProductWidget(
            product: e,
          ))
      .toList();

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: CustomColor.white,
      body: SingleChildScrollView(
        child: Column(children: [
          CustomSizedBox(
            context: context,
            height: 32,
          ),
          CustomText(
            text: 'Delivery Schedule',
            color: CustomColor.black,
            context: context,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          CustomSizedBox(
            context: context,
            height: 16,
          ),
          SizedBox(
            height: deviceSize.height / 8,
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              children: listDateTime
                  .mapIndexed((index, e) => formatDate(e, index))
                  .toList(),
            ),
          ),
          CustomButton(
              height: 24,
              text: 'Hủy lịch',
              width: deviceSize.width * 2 / 3,
              onPressFunction: () {},
              isLoading: false,
              textColor: CustomColor.white,
              buttonColor: CustomColor.blue,
              borderRadius: 6),
          CustomSizedBox(
            context: context,
            height: 24,
          ),
          ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: mapListSchedule(),
          ),
        ]),
      ),
    );
  }
}
