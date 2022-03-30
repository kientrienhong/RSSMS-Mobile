import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rssms/api/api_services.dart';
import 'package:rssms/common/custom_button.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/custom_snack_bar.dart';
import 'package:rssms/common/custom_text.dart';
import 'package:rssms/models/entity/invoice.dart';
import 'package:rssms/constants/constants.dart';
import 'package:rssms/models/entity/user.dart';
import 'package:rssms/models/schedule_model.dart';
import 'package:rssms/pages/delivery_staff/delivery/widgets/dialog_check_in.dart';
import 'package:rssms/pages/delivery_staff/delivery/widgets/dialog_report.dart';
import 'package:rssms/pages/delivery_staff/qr/invoice_screen/invoice_screen.dart';
import 'package:rssms/common/invoice_detail_screen.dart';

import 'package:rssms/presenters/schedule_presenter.dart';
import 'package:rssms/views/schedule_view.dart';

class ScheduleWidget extends StatefulWidget {
  final Invoice invoice;
  final Map<String, dynamic> schedule;
  final int listLength;
  final int currentIndex;
  final DateTime firstDayOfWeek;
  final DateTime endDayOfWeek;
  final Function initDeliveryScreen;
  final Function refreshSchedule;
  final DateTime currentDateTime;
  const ScheduleWidget(
      {Key? key,
      required this.firstDayOfWeek,
      required this.invoice,
      required this.endDayOfWeek,
      required this.schedule,
      required this.initDeliveryScreen,
      required this.currentIndex,
      required this.currentDateTime,
      required this.refreshSchedule,
      required this.listLength})
      : super(key: key);

  @override
  State<ScheduleWidget> createState() => _ScheduleWidgetState();
}

class _ScheduleWidgetState extends State<ScheduleWidget>
    implements ScheduleView {
  late SchedulePresenter _presenter;
  late ScheduleModel _model;

  Widget buildInfo(String title, String content, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: title,
          color: CustomColor.black,
          context: context,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        CustomSizedBox(
          context: context,
          height: 8,
        ),
        Flexible(
          child: CustomText(
              maxLines: 4,
              text: content,
              color: CustomColor.black,
              context: context,
              fontSize: 16),
        )
      ],
    );
  }

  @override
  void initState() {
    _presenter = SchedulePresenter();
    _presenter.view = this;
    _model = _presenter.model;
    super.initState();
  }

  @override
  void updateView(ScheduleModel model) {
    setState(() {
      _model.setModel(model);
    });
  }

  @override
  void onPressDelivery() {
    showDialog(
        context: context,
        builder: (ctx) {
          return DialogCheckIn(idRequest: widget.invoice.id);
        }).then((value) async {
      if (value) {
        Users user = Provider.of<Users>(context, listen: false);
        widget.initDeliveryScreen(
            user: user, currentDate: widget.currentDateTime);

        await widget.refreshSchedule(
            user.idToken!, widget.firstDayOfWeek, widget.endDayOfWeek);
      }
    });
  }

  @override
  void onPressReport() {
    showDialog(
        context: context,
        builder: (ctx) {
          return DialogReport(idRequest: widget.invoice.id);
        }).then((value) async {
      if (value) {
        Users user = Provider.of<Users>(context, listen: false);
        widget.initDeliveryScreen(
            user: user, currentDate: widget.currentDateTime);

        await widget.refreshSchedule(
            user.idToken!, widget.firstDayOfWeek, widget.endDayOfWeek);
      }
    });
  }

  @override
  void onPressViewDetail() async {
    try {
      Invoice invoiceProvider = Provider.of<Invoice>(context, listen: false);
      Users users = Provider.of<Users>(context, listen: false);

      int? typeRequest =
          await _presenter.getRequestId(users.idToken!, widget.invoice.id);
      if (typeRequest == null) {
        CustomSnackBar.buildErrorSnackbar(
            context: context,
            message: 'Lấy thông tin đơn thất bại!',
            color: CustomColor.red);
      } else if (typeRequest == REQUEST_TYPE.createOrder.index) {
        invoiceProvider.setInvoice(invoice: _model.invoiceDetail!);

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => QRInvoiceDetailsScreen(
              isScanQR: false,
              isDone: false,
            ),
          ),
        );
      } else if (typeRequest == REQUEST_TYPE.returnOrder.index) {
        bool result = await _presenter.getInvoiceId(users.idToken!);
        if (result) {
          invoiceProvider.setInvoice(invoice: _model.invoiceDetail!);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  InvoiceDetailScreen(invoice: invoiceProvider),
            ),
          );
        } else {
          CustomSnackBar.buildErrorSnackbar(
              context: context,
              message: 'Lấy thông tin đơn thất bại!',
              color: CustomColor.red);
        }
      }
    } catch (e) {
      log(e.toString());
      CustomSnackBar.buildErrorSnackbar(
          context: context,
          message: 'Lấy thông tin đơn thất bại!',
          color: CustomColor.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    DateTime deliveryDateTime = DateTime.parse(widget.schedule['deliveryDate']);
    bool isDelivery = deliveryDateTime.isAfter(widget.firstDayOfWeek) &&
        deliveryDateTime.isBefore(widget.endDayOfWeek);

    return Container(
      width: deviceSize.width,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: 40,
            child: Stack(clipBehavior: Clip.none, children: [
              widget.currentIndex == widget.listLength - 1
                  ? Container()
                  : Positioned(
                      left: 8,
                      child: Container(
                        width: 1,
                        color: CustomColor.black[3],
                        height: deviceSize.height / 3,
                      ),
                    ),
              Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: CustomColor.blue),
              ),
            ]),
          ),
          CustomSizedBox(
            context: context,
            width: 8,
          ),
          GestureDetector(
            onTap: () async {
              onPressViewDetail();
            },
            child: SizedBox(
              height: deviceSize.height / 3,
              width: deviceSize.width * 3 / 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                      text: widget.schedule['deliveryTime'],
                      color: CustomColor.black,
                      context: context,
                      fontWeight: FontWeight.bold,
                      fontSize: 24),
                  CustomSizedBox(
                    context: context,
                    height: 40,
                  ),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: CustomColor.white,
                        boxShadow: [
                          BoxShadow(
                            color: CustomColor.black[3]!,
                            spreadRadius: 3,
                            blurRadius: 16,
                            offset: Offset(0, 0), // changes position of shadow
                          ),
                        ]),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            CustomText(
                              text: 'Trạng thái: ',
                              color: CustomColor.black,
                              context: context,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            Flexible(
                              child: CustomText(
                                  text:
                                      '${LIST_STATUS_REQUEST[widget.schedule['status']]['name']}',
                                  color: LIST_STATUS_REQUEST[widget
                                      .schedule['status']]['color'] as Color,
                                  fontWeight: FontWeight.bold,
                                  maxLines: 2,
                                  textAlign: TextAlign.right,
                                  context: context,
                                  fontSize: 18),
                            ),
                          ],
                        ),
                        CustomSizedBox(
                          context: context,
                          height: 8,
                        ),
                        buildInfo(
                            'Địa chỉ: ',
                            isDelivery
                                ? widget.schedule['deliveryAddress']
                                : widget.schedule['addressReturn'],
                            context),
                        CustomSizedBox(
                          context: context,
                          height: 8,
                        ),
                        buildInfo('Tên khách hàng: ',
                            widget.schedule['customerName'], context),
                        CustomSizedBox(
                          context: context,
                          height: 8,
                        ),
                        buildInfo('SĐT khách hàng: ',
                            widget.schedule['customerPhone'], context),
                        Divider(),
                        Row(
                          children: [
                            CustomButton(
                                height: 24,
                                text: 'Báo cáo',
                                width: deviceSize.width * 1 / 3,
                                onPressFunction: onPressReport,
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
                                text: 'Đi lấy hàng',
                                width: deviceSize.width * 1 / 3,
                                onPressFunction: onPressDelivery,
                                isLoading: false,
                                textColor: CustomColor.white,
                                buttonColor: CustomColor.blue,
                                borderRadius: 6),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
