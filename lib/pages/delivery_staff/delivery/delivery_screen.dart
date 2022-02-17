import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rssms/common/custom_button.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/custom_snack_bar.dart';
import 'package:rssms/common/custom_text.dart';
import 'package:collection/collection.dart';
import 'package:rssms/models/delivery_screen_model.dart';
import 'package:rssms/models/entity/invoice.dart';
import 'package:rssms/models/entity/user.dart';
import 'package:rssms/pages/customers/cart/widgets/product_widget.dart';
import 'package:rssms/pages/delivery_staff/delivery/widgets/dialog_confirm_cancel.dart';
import 'package:rssms/pages/delivery_staff/delivery/widgets/schedule_widget.dart';
import 'package:rssms/presenters/delivery_presenter.dart';
import 'package:rssms/views/delivery_screen_view.dart';
import '../../../constants/constants.dart' as constants;

class DeliveryScreen extends StatefulWidget {
  const DeliveryScreen({Key? key}) : super(key: key);

  @override
  _DeliveryScreenState createState() => _DeliveryScreenState();
}

class _DeliveryScreenState extends State<DeliveryScreen>
    implements DeliveryScreenView {
  late DeliveryPresenter _presenter;
  late DeliveryScreenModel _model;

  void init() async {
    Users user = Provider.of<Users>(context, listen: false);

    _presenter.init(user);
    await _presenter.loadListShedule(
        user.idToken!, _model.firstDayOfWeek, _model.endDayOfWeek);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    _presenter = DeliveryPresenter();
    _model = _presenter.model;
    _presenter.view = this;
    init();
  }

  List<Widget>? mapListSchedule() {
    if (_model.currentIndex == -1) {
      return null;
    }
    String getCurrentDateTime = _model.listDateTime[_model.currentIndex]
        .toIso8601String()
        .split('T')[0];
    if (_model.listInvoice[getCurrentDateTime] != null) {
      return _model.listInvoice[getCurrentDateTime]
          ?.mapIndexed((index, element) => ScheduleWidget(
              invoice: element,
              schedule: element.toMap(),
              currentIndex: index,
              endDayOfWeek: _model.endDayOfWeek,
              firstDayOfWeek: _model.firstDayOfWeek,
              listLength: _model.listInvoice[getCurrentDateTime]!.length))
          .toList();
    } else {
      return [
        Center(
          child: CustomText(
              text: 'Bạn không có lịch vào ngày này',
              color: CustomColor.black,
              context: context,
              fontSize: 24),
        )
      ];
    }
  }

  Widget formatDate(DateTime dateTime, int index) {
    final splitedDay = DateFormat.yMEd().format(dateTime).split(', ');
    final day = splitedDay[0];
    final splitedDate = splitedDay[1].split('/');
    Color color =
        index == _model.currentIndex ? CustomColor.blue : CustomColor.black[3]!;
    return GestureDetector(
      onTap: () {
        setState(() {
          _model.currentIndex = index;
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
  updateLoadingStartDelivery() {
    setState(() {
      _model.isLoadingStartDelivery = !_model.isLoadingStartDelivery;
    });
  }

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
            text: 'Lịch giao hàng',
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
              children: _model.listDateTime
                  .mapIndexed((index, e) => formatDate(e, index))
                  .toList(),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomButton(
                  height: 24,
                  text: 'Bắt đầu vận chuyển',
                  width: deviceSize.width * 2 / 3,
                  onPressFunction: () async {
                    Users user = Provider.of<Users>(context, listen: false);
                    bool? result =
                        await _presenter.startDelivery(user.idToken!);
                    if (result == null) {
                      updateLoadingStartDelivery();
                    } else {
                      if (result == true) {
                        CustomSnackBar.buildErrorSnackbar(
                            context: context,
                            message: "Bắt đầu thành công",
                            color: CustomColor.green);
                        _presenter.init(user);
                        _model.listInvoice = <String, List<Invoice>>{};
                        await _presenter.loadListShedule(user.idToken!,
                            _model.firstDayOfWeek, _model.endDayOfWeek);
                      }
                      updateLoadingStartDelivery();
                    }
                  },
                  isLoading: _model.isLoadingStartDelivery,
                  textColor: CustomColor.white,
                  buttonColor: CustomColor.blue,
                  borderRadius: 6),
              CustomSizedBox(
                context: context,
                width: 8,
              ),
              CustomButton(
                  height: 24,
                  text: 'Hủy lịch',
                  width: deviceSize.width * 0.8 / 3,
                  onPressFunction: () {
                    showDialog(
                        context: context,
                        builder: (ctx) {
                          return DialogConfirmCancel(
                              dateTime:
                                  _model.listDateTime[_model.currentIndex]);
                        });
                  },
                  isLoading: false,
                  textColor: CustomColor.white,
                  buttonColor: CustomColor.red,
                  borderRadius: 6),
            ],
          ),
          CustomSizedBox(
            context: context,
            height: 24,
          ),
          ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: mapListSchedule() ?? [Container()],
          ),
        ]),
      ),
    );
  }
}
