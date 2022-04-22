import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rssms/common/custom_app_bar.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/custom_snack_bar.dart';
import 'package:rssms/common/custom_text.dart';
import 'package:rssms/common/image_widget.dart';
import 'package:rssms/common/list_note_order_detail_status.dart';
import 'package:rssms/models/entity/floor.dart';
import 'package:rssms/models/entity/order_detail.dart';
import 'package:rssms/constants/constants.dart' as constants;
import 'package:rssms/models/entity/placing_items.dart';
import 'package:rssms/models/entity/user.dart';
import 'package:rssms/models/floor_detail_model.dart';
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

  List<Widget> mapInvoiceWidget(
      List<OrderDetail> listOrderDetail, PlacingItems placingItems) {
    return listOrderDetail
        .where((element) =>
            element.productType == constants.typeProduct.handy.index ||
            element.productType == constants.typeProduct.unweildy.index ||
            element.productType == constants.typeProduct.selfStorage.index)
        .map((e) {
      final listAdditionTemp = e.listAdditionService!
          .where((element) =>
              element.type == constants.typeProduct.accessory.index)
          .toList();
      return e.copyWith(listAdditionService: listAdditionTemp);
    }).map((e1) {
      var orderDetail = e1.copyWith();

      int indexFound = placingItems.storedItems['items']
          .indexWhere((floor) => floor.id == e1.id);

      if (indexFound != -1) {
        orderDetail = orderDetail.copyWith(status: 0);
      } else {
        int indexFoundPlacing = placingItems.placingItems['floors']
            .indexWhere((floor) => floor['id'] == e1.id);
        if (indexFoundPlacing != -1) {
          orderDetail = orderDetail.copyWith(status: 1);
        }
      }

      return ImageWidget(
        orderDetail: orderDetail,
        isView: true,
        movingItem: () {
          bool result = placingItems.addMove(e1, widget.floor.id);
          if (result) {
            CustomSnackBar.buildSnackbar(
                context: context,
                message: 'Thao tác thành công',
                color: CustomColor.green);
          }
        },
      );
    }).toList();
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
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 24, right: 24, bottom: 24),
          child: SizedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomSizedBox(
                  context: context,
                  height: 40,
                ),
                const CustomAppBar(isHome: false, name: 'Danh sách đồ trên kệ'),
                CustomSizedBox(
                  context: context,
                  height: 8,
                ),
                CustomText(
                    text: "Chú thích: ",
                    color: Colors.black,
                    context: context,
                    fontWeight: FontWeight.bold,
                    fontSize: 17),
                const ListNoteOrderDetailStatus(),
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
                Consumer<PlacingItems>(
                  builder: (_, placingItems, child) => Column(
                    children:
                        mapInvoiceWidget(_model.listOrderDetails, placingItems),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
