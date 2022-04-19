import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rssms/common/custom_app_bar.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/custom_text.dart';
import 'package:rssms/common/image_widget.dart';
import 'package:rssms/models/entity/floor.dart';
import 'package:rssms/models/entity/order_detail.dart';
import 'package:rssms/constants/constants.dart' as constants;
import 'package:rssms/models/entity/user.dart';
import 'package:rssms/models/floor_detail_model.dart';
import 'package:rssms/pages/delivery_staff/qr/invoice_screen/update_invoice_screen/widget/addition_service_widget.dart';
import 'package:rssms/presenters/floor_detail_presenter.dart';
import 'package:rssms/views/floor_detail_view.dart';

class FloorDetailScreen extends StatefulWidget {
  final Floor floor;

  const FloorDetailScreen({Key? key, required this.floor}) : super(key: key);

  @override
  _FloorDetailScreenState createState() => _FloorDetailScreenState();
}

class _FloorDetailScreenState extends State<FloorDetailScreen>
    implements FloorDetailView {
  late FloorDetailPresenter _presenter;
  late FloorDetailModel _model;

  List<Widget> mapInvoiceWidget(List<OrderDetail> listOrderDetail) =>
      listOrderDetail
          .where((element) =>
              element.productType == constants.typeProduct.handy.index)
          .map((e) => ImageWidget(
                orderDetail: e,
                isView: true,
              ))
          .toList();

  List<Widget> mapSeperateAdditionWidget(List<OrderDetail> listOrderDetail) {
    final list = listOrderDetail.where((element) =>
        element.productType == constants.typeProduct.accessory.index);
    if (list.isNotEmpty) {
      return list
          .where((element) =>
              element.productType == constants.typeProduct.accessory.index)
          .map((e) => AdditionServiceWidget(
                isView: true,
                onAddAddition: () {},
                onMinusAddition: () {},
                orderDetail: e,
              ))
          .toList();
    } else {
      return [
        Center(
            child: CustomText(
                text: '(Trống)',
                color: CustomColor.black[3]!,
                context: context,
                fontSize: 16))
      ];
    }
  }

  @override
  void initState() {
    _presenter = FloorDetailPresenter();
    _model = _presenter.model;
    _presenter.view = this;
    Users user = Provider.of<Users>(context, listen: false);
    _presenter.getFloorDetails(user.idToken!, widget.floor.id);
    super.initState();
  }

  @override
  void changeLoadingStatus() {
    if (mounted) {
      setState(() {
        _model.isLoading = !_model.isLoading;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24, bottom: 24),
        child: SizedBox(
          width: deviceSize.width,
          height: deviceSize.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomSizedBox(context: context, height: 12),
              CustomSizedBox(
                context: context,
                height: 24,
              ),
              const CustomAppBar(
                  isHome: false, name: 'Danh sách đồ trên kệ'),
              CustomText(
                  text: "Danh sách phụ kiện riêng: ",
                  color: Colors.black,
                  context: context,
                  fontWeight: FontWeight.bold,
                  fontSize: 17),
              CustomSizedBox(
                context: context,
                height: 8,
              ),
              Column(
                children: mapSeperateAdditionWidget(_model.listOrderDetails),
              ),
              CustomSizedBox(
                context: context,
                height: 8,
              ),
              CustomText(
                  text: "Hình ảnh đồ đạc được lưu kho: ",
                  color: Colors.black,
                  context: context,
                  fontWeight: FontWeight.bold,
                  fontSize: 17),
              CustomSizedBox(
                context: context,
                height: 8,
              ),
              Column(
                children: mapInvoiceWidget(_model.listOrderDetails),
              )
            ],
          ),
        ),
      ),
    );
  }
}
