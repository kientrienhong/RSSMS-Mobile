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

    _presenter.init(user: user);
    await _presenter.loadListShedule(
        user.idToken!, _model.firstDayOfWeek, _model.endDayOfWeek);
    setState(() {});
  }

  @override
  updateView() {
    setState(() {});
  }

  @override
  updateRefresLoading() {
    setState(() {
      _model.isLoadingRefresh = !_model.isLoadingRefresh;
    });
  }

  @override
  onClickRefresh() {
    Users user = Provider.of<Users>(context, listen: false);
    _presenter.refreshListSchedule(user: user);
  }

  @override
  onClickNextWeek() {
    Users user = Provider.of<Users>(context, listen: false);
    _presenter.loadNewScheduleWeek(user: user, isPrevious: false);
  }

  @override
  onClickPreviousWeek() {
    Users user = Provider.of<Users>(context, listen: false);

    _presenter.loadNewScheduleWeek(user: user, isPrevious: true);
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
              currentDateTime: _model.listDateTime[_model.currentIndex],
              refreshSchedule: _presenter.loadListShedule,
              initDeliveryScreen: _presenter.init,
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
          mainAxisAlignment: MainAxisAlignment.center,
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
          Container(
            alignment: Alignment.center,
            height: deviceSize.height / 8,
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              children: [
                GestureDetector(
                  onTap: onClickPreviousWeek,
                  child: SizedBox(
                      height: 32,
                      width: 32,
                      child: Image.asset(
                        'assets/images/arrowLeft.png',
                        fit: BoxFit.contain,
                      )),
                ),
                CustomSizedBox(
                  context: context,
                  width: 18,
                ),
                ..._model.listDateTime
                    .mapIndexed((index, e) => formatDate(e, index))
                    .toList(),
                CustomSizedBox(
                  context: context,
                  width: 18,
                ),
                GestureDetector(
                  onTap: onClickNextWeek,
                  child: SizedBox(
                      height: 32,
                      width: 32,
                      child: Image.asset(
                        'assets/images/arrowRight.png',
                        fit: BoxFit.contain,
                      )),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
                        }).then((value) async {
                      if (value == true) {
                        Users user = Provider.of<Users>(context, listen: false);

                        _presenter.init(
                            user: user,
                            currentDate:
                                _model.listDateTime[_model.currentIndex]);
                        await _presenter.loadListShedule(user.idToken!,
                            _model.firstDayOfWeek, _model.endDayOfWeek);
                      }
                    });
                  },
                  isLoading: false,
                  textColor: CustomColor.white,
                  buttonColor: CustomColor.red,
                  borderRadius: 6),
              CustomSizedBox(
                context: context,
                width: 8,
              ),
              CustomButton(
                  height: 24,
                  text: 'Làm mới',
                  width: deviceSize.width * 2 / 3,
                  onPressFunction: onClickRefresh,
                  isLoading: _model.isLoadingRefresh,
                  textColor: CustomColor.white,
                  buttonColor: CustomColor.blue,
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
