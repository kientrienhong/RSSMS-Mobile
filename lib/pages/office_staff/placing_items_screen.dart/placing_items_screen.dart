import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:rssms/common/custom_app_bar.dart';
import 'package:rssms/common/custom_button.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/custom_snack_bar.dart';
import 'package:rssms/common/custom_text.dart';
import 'package:rssms/common/image_widget.dart';
import 'package:rssms/helpers/validator.dart';
import 'package:rssms/models/entity/area.dart';
import 'package:rssms/models/entity/order_detail.dart';
import 'package:rssms/models/entity/placing_items.dart';
import 'package:rssms/models/entity/user.dart';
import 'package:rssms/models/placing_items_screen_model.dart';
import 'package:rssms/pages/office_staff/placing_items_screen.dart/import_screen/import_screen.dart';
import 'package:rssms/presenters/placing_items_screen_presenter.dart';
import 'package:rssms/views/placing_items_screen_view.dart';
import 'package:rssms/constants/constants.dart' as constants;

class PlacingItemsScreen extends StatefulWidget {
  final String floorId;
  final String floorName;
  final Area area;
  final bool isView;
  final Map<String, double> sizeOfFloor;
  const PlacingItemsScreen(
      {Key? key,
      required this.floorId,
      required this.sizeOfFloor,
      required this.area,
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
  String qrCode = "";
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
  void onClickPlace(int index) {
    final placingItems = Provider.of<PlacingItems>(context, listen: false);
    bool result = _presenter.onPressPlace(
        placingItems,
        widget.sizeOfFloor,
        placingItems.storedItems['items'][index],
        widget.floorId,
        widget.area,
        widget.floorName);
    if (result) {
      CustomSnackBar.buildSnackbar(
          context: context,
          message: 'Đặt thành công',
          color: CustomColor.green);
    } else {
      CustomSnackBar.buildSnackbar(
          context: context,
          message: 'Vui lòng đặt vào không gian phù hợp',
          color: CustomColor.red);
    }
  }

  @override
  void onClickAddLosing(int index) {
    final placingItems = Provider.of<PlacingItems>(context, listen: false);
    placingItems.addLostItem(placingItems.storedItems['items'][index].id);
    CustomSnackBar.buildSnackbar(
        context: context,
        message: 'Thao tác thành công',
        color: CustomColor.green);
  }

  @override
  void onClickUndoLosing(int index) {
    final placingItems = Provider.of<PlacingItems>(context, listen: false);
    placingItems
        .removeLostItem(placingItems.lostItems['items'][index]['idLosing']);
    CustomSnackBar.buildSnackbar(
        context: context,
        message: 'Thao tác thành công',
        color: CustomColor.green);
  }

  @override
  void onClickUndo(int index) {}

  @override
  void onClickConfirm({isAccept = false}) async {
    final placingItems = Provider.of<PlacingItems>(context, listen: false);
    final user = Provider.of<Users>(context, listen: false);
    bool result = false;
    if (placingItems.isMoving) {
      result = await _presenter.onPressConfirmMove(user.idToken!, placingItems);
    } else {
      if (_model.deliveryStaff.id != '' &&
          placingItems.storedItems['typeOrder'] ==
              constants.doorToDoorTypeOrder) {
        for (var e in (placingItems.placingItems['floors'] as List)) {
          if (e['note'] == '') {
            setState(() {
              _model.error = "Vui lòng nhập mô tả cho tất cả đồ!";
            });
            return;
          }
        }
        placingItems.import.importDeliveryBy =  _model.deliveryStaff.roleName == "Customer" ? "Khách tự vận chuyển": _model.deliveryStaff.name;
        placingItems.import.importStaff = user.name!;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ImportScreen(
              deliveryStaff: _model.deliveryStaff,
              import: placingItems.import,
              orderDetail: placingItems.placingItems['floors']
                  .map<OrderDetail>((e) => OrderDetail.fromMap(e))
                  .toList(),
            ),
          ),
        ).then((value) {
          if (value) {
            Navigator.pop(context, value);
          }
        });
      } else if (placingItems.storedItems['typeOrder'] ==
          constants.selfStorageTypeOrder) {
        result = await _presenter.onPressConfirmStore(
            user.idToken!, placingItems, '');
      } else if (_model.deliveryStaff.id == '' &&
          placingItems.storedItems['typeOrder'] ==
              constants.doorToDoorTypeOrder) {
        setState(() {
          _model.error = "Vui lòng chọn người đem hàng đến kho!";
        });
      }
    }
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

  Future<void> scanQR(Size deviceSize) async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    if (barcodeScanRes == '-1') {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Không tìm thấy nhân viên"),
      ));
      return;
    }
    setState(() {
      qrCode = barcodeScanRes;
    });
    try {
      String prefixQrcode = qrCode.split("_")[1];
      if (prefixQrcode == "user") {
        Users user = Provider.of<Users>(context, listen: false);
        bool result = await _presenter.getStaffDetail(
            user.idToken!, qrCode.split("_")[0]);
        if (!result) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Không tìm thấy nhân viên"),
          ));
          return;
        } else {
          setState(() {});
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: CustomColor.red,
          content: Text("Vui lòng quét mã trên nhân viên vận chuyển!"),
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.grey,
        content: Text("Vui lòng quét mã trên nhân viên vận chuyển!"),
      ));
    }
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
                fontWeight: FontWeight.bold,
                context: context,
                fontSize: 16),
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
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: items.storedItems['items'].length,
                        itemBuilder: (_, index) => ImageWidget(
                            addRemovingItem: !widget.isView
                                ? () {
                                    onClickAddLosing(index);
                                  }
                                : null,
                            placingItem: !widget.isView
                                ? () {
                                    onClickPlace(index);
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
                fontWeight: FontWeight.bold,
                context: context,
                fontSize: 16),
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
                      physics: const NeverScrollableScrollPhysics(),
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
                                          items.placingItems['floors'][index]
                                              ['idPlacing']);
                                      CustomSnackBar.buildSnackbar(
                                          context: context,
                                          message: 'Hoàn tác thành công',
                                          color: CustomColor.green);
                                    }
                                  : null,
                              orderDetail: OrderDetail.fromMap(
                                  items.placingItems['floors'][index]),
                              isView: true),
                          CustomSizedBox(
                            context: context,
                            height: 8,
                          ),
                          if (!items.isMoving &&
                              placingItems.storedItems['typeOrder'] ==
                                  constants.doorToDoorTypeOrder)
                            Column(
                              children: [
                                TextFormField(
                                  validator: (value) =>
                                      Validator.notEmpty(value),
                                  onChanged: (text) {
                                    items.onChange(text, index);
                                  },
                                  initialValue: items.placingItems['floors']
                                      [index]['note'],
                                  textAlignVertical: TextAlignVertical.center,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(
                                        top: deviceSize.width / 60, left: 8),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(4),
                                      borderSide: const BorderSide(),
                                    ),
                                    hintText: 'Nhập mô tả món hàng',
                                  ),
                                ),
                                CustomSizedBox(
                                  context: context,
                                  height: 8,
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ),
            CustomSizedBox(
              context: context,
              height: 8,
            ),
            CustomText(
                text: 'Danh sách đồ bị mất: ',
                color: CustomColor.black,
                fontWeight: FontWeight.bold,
                context: context,
                fontSize: 16),
            CustomSizedBox(
              context: context,
              height: 8,
            ),
            placingItems.lostItems['items'].isEmpty
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
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: items.lostItems['items'].length,
                        itemBuilder: (_, index) => ImageWidget(
                            removeLosingItem: !widget.isView
                                ? () {
                                    onClickUndoLosing(index);
                                  }
                                : null,
                            orderDetail: OrderDetail.fromMap(
                                items.lostItems['items'][index]),
                            isView: true))),
            CustomSizedBox(
              context: context,
              height: 8,
            ),
            if (!placingItems.isMoving &&
                placingItems.storedItems['typeOrder'] ==
                    constants.doorToDoorTypeOrder)
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                          text: "Thông tin vận chuyển",
                          color: CustomColor.black,
                          context: context,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                      CustomButton(
                          height: 20,
                          text: 'Quét QR',
                          width: deviceSize.width / 3 - 50,
                          onPressFunction: () {
                            scanQR(deviceSize);
                          },
                          isLoading: _model.isLoading,
                          textColor: CustomColor.white,
                          buttonColor: CustomColor.blue,
                          textSize: 12,
                          borderRadius: 4),
                    ],
                  ),
                  CustomSizedBox(
                    context: context,
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                          text: "Người vận chuyển",
                          color: CustomColor.black,
                          context: context,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                      CustomText(
                          text: _model.deliveryStaff.name == ''
                              ? '(Trống)'
                              : _model.deliveryStaff.name,
                          color: _model.deliveryStaff.name == ''
                              ? Colors.grey
                              : CustomColor.black,
                          context: context,
                          fontSize: 16)
                    ],
                  ),
                  CustomSizedBox(
                    context: context,
                    height: 16,
                  ),
                ],
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomButton(
                    height: 24,
                    text: 'Hủy thao tác',
                    width: deviceSize.width / 3,
                    onPressFunction: onClickEmptyPlacing,
                    isLoading: false,
                    textColor: CustomColor.white,
                    buttonColor: CustomColor.red,
                    borderRadius: 4),
                CustomButton(
                    height: 24,
                    text: 'Tiếp theo',
                    width: deviceSize.width / 3 - 40,
                    onPressFunction: onClickConfirm,
                    isLoading: _model.isLoading,
                    textColor: CustomColor.white,
                    buttonColor: CustomColor.blue,
                    borderRadius: 4),
              ],
            ),
            if (_model.error.isNotEmpty)
              CustomSizedBox(
                context: context,
                height: 24,
              ),
            if (_model.error.isNotEmpty)
              Center(
                child: CustomText(
                  textAlign: TextAlign.center,
                  text: _model.error,
                  color: CustomColor.red,
                  context: context,
                  fontSize: 16,
                  maxLines: 2,
                  fontWeight: FontWeight.bold,
                ),
              ),
          ],
        ),
      )),
    );
  }
}
