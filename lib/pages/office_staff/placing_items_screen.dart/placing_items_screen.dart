import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rssms/common/custom_app_bar.dart';
import 'package:rssms/common/custom_button.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/custom_snack_bar.dart';
import 'package:rssms/common/custom_text.dart';
import 'package:rssms/common/image_widget.dart';
import 'package:rssms/models/entity/order_detail.dart';
import 'package:rssms/models/entity/placing_items.dart';
import 'package:rssms/models/entity/user.dart';
import 'package:rssms/models/placing_items_screen_model.dart';
import 'package:rssms/presenters/placing_items_screen_presenter.dart';
import 'package:rssms/views/placing_items_screen_view.dart';

class PlacingItemsScreen extends StatefulWidget {
  final String floorId;
  final String floorName;
  final String areaName;
  final bool isView;
  const PlacingItemsScreen(
      {Key? key,
      required this.floorId,
      required this.areaName,
      required this.floorName,
      required this.isView})
      : super(key: key);

  @override
  State<PlacingItemsScreen> createState() => _PlacingItemsScreenState();
}

class _PlacingItemsScreenState extends State<PlacingItemsScreen>
    implements PlacingItemsScreenView {
  late PlacingItemsScreenPresenter _presenter;
  late PlacingItemsScreenModel _model;

  @override
  void initState() {
    _presenter = PlacingItemsScreenPresenter();
    _model = _presenter.model;
    _presenter.view = this;
    super.initState();
  }

  @override
  void updateError(String error) {
    setState(() {
      _model.error = error;
    });
  }

  @override
  void updateLoading() {
    setState(() {
      _model.isLoading = !_model.isLoading;
    });
  }

  @override
  void onClickConfirm() async {
    final placingItems = Provider.of<PlacingItems>(context, listen: false);
    final user = Provider.of<Users>(context, listen: false);

    bool result = await _presenter.onPressConfirm(user.idToken!, placingItems);
    if (result) {
      Navigator.pop(context, result);
      CustomSnackBar.buildSnackbar(
          context: context,
          message: 'Thao tác thành công',
          color: CustomColor.green);
      placingItems.emptyPlacing();
    }
  }

  @override
  void onClickEmptyPlacing() {
    final placingItems = Provider.of<PlacingItems>(context, listen: false);
    placingItems.emptyPlacing();
    Navigator.pop(context);

    CustomSnackBar.buildSnackbar(
        context: context,
        message: 'Hủy thao tác thành công',
        color: CustomColor.green);
  }

  @override
  Widget build(BuildContext context) {
    final placingItems = Provider.of<PlacingItems>(context, listen: true);
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
          child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomSizedBox(
              context: context,
              height: 40,
            ),
            const CustomAppBar(
              isHome: false,
              name: 'Trang đặt đồ vào không gian',
            ),
            CustomText(
                text: 'Danh sách đồ: ',
                color: CustomColor.black,
                context: context,
                fontSize: 24),
            placingItems.storedItems['items'].isEmpty
                ? Column(children: [
                    CustomSizedBox(
                      context: context,
                      height: 8,
                    ),
                    Center(
                      child: CustomText(
                          text: '(Trống)',
                          color: CustomColor.black[2]!,
                          context: context,
                          fontSize: 16),
                    ),
                  ])
                : Consumer<PlacingItems>(
                    builder: (_, items, child) => ListView.builder(
                        shrinkWrap: true,
                        itemCount: items.storedItems['items'].length,
                        itemBuilder: (_, index) => ImageWidget(
                            placingItem: !widget.isView
                                ? () {
                                    items.placeItems(widget.floorId,
                                        items.storedItems['items'][index].id, {
                                      'areaName': widget.areaName,
                                      'floorName': widget.floorName,
                                      'floorId': widget.floorId
                                    });
                                    CustomSnackBar.buildSnackbar(
                                        context: context,
                                        message: 'Đặt thành công',
                                        color: CustomColor.green);
                                  }
                                : null,
                            orderDetail: items.storedItems['items'][index],
                            isView: true))),
            CustomSizedBox(
              context: context,
              height: 16,
            ),
            CustomText(
                text: 'Danh sách đồ đã được đặt: ',
                color: CustomColor.black,
                context: context,
                fontSize: 24),
            placingItems.placingItems['floors'].isEmpty
                ? Column(children: [
                    CustomSizedBox(
                      context: context,
                      height: 8,
                    ),
                    Center(
                      child: CustomText(
                          text: '(Trống)',
                          color: CustomColor.black[2]!,
                          context: context,
                          fontSize: 16),
                    ),
                  ])
                : Consumer<PlacingItems>(
                    builder: (_, items, child) => ListView.builder(
                        shrinkWrap: true,
                        itemCount: items.placingItems['floors'].length,
                        itemBuilder: (_, index) => Column(
                              children: [
                                Row(
                                  children: [
                                    CustomText(
                                      text: 'Vị trí: ',
                                      color: CustomColor.black,
                                      context: context,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    CustomSizedBox(
                                      context: context,
                                      width: 8,
                                    ),
                                    CustomText(
                                      text:
                                          '${items.placingItems['floors'][index]['areaName']} / ${items.placingItems['floors'][index]['floorName']}',
                                      color: CustomColor.blue,
                                      context: context,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    )
                                  ],
                                ),
                                CustomSizedBox(
                                  context: context,
                                  height: 8,
                                ),
                                ImageWidget(
                                    removePlacingItem: !widget.isView
                                        ? () {
                                            items.removePlacing(
                                                items.placingItems['floors']
                                                    [index]['idPlacing']);
                                            CustomSnackBar.buildSnackbar(
                                                context: context,
                                                message: 'Hoàn tác thành công',
                                                color: CustomColor.green);
                                          }
                                        : null,
                                    orderDetail: OrderDetail.fromMap(
                                        items.placingItems['floors'][index]),
                                    isView: true),
                              ],
                            ))),
            CustomSizedBox(
              context: context,
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomButton(
                    height: 24,
                    text: 'Hủy thao tác',
                    width: deviceSize.width / 3 - 40,
                    onPressFunction: onClickEmptyPlacing,
                    isLoading: false,
                    textColor: CustomColor.white,
                    buttonColor: CustomColor.red,
                    borderRadius: 4),
                CustomButton(
                    height: 24,
                    text: 'Xác nhận',
                    width: deviceSize.width / 3 - 40,
                    onPressFunction: onClickConfirm,
                    isLoading: _model.isLoading,
                    textColor: CustomColor.white,
                    buttonColor: CustomColor.blue,
                    borderRadius: 4),
              ],
            )
          ],
        ),
      )),
    );
  }
}
