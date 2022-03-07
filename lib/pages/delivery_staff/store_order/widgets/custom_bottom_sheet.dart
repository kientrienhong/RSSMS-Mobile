import 'package:flutter/material.dart';
import 'package:bottom_drawer/bottom_drawer.dart';
import 'package:rssms/common/custom_button.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/custom_text.dart';
import 'package:rssms/models/entity/box.dart';
import 'package:rssms/models/entity/invoice.dart';
import 'package:rssms/models/entity/order_detail.dart';
import 'package:rssms/pages/delivery_staff/store_order/widgets/item_radio_widget.dart';
import 'package:rssms/presenters/custom_bottom_sheet_presenter.dart';
import 'package:rssms/views/custom_bottom_sheet.dart';

class CustomBottomSheet extends StatefulWidget {
  final BottomDrawerController controller;
  final Function onChangeRadio;
  final int currentChoicedProduct;
  Invoice? invoice;
  CustomBottomSheet(
      {Key? key,
      required this.currentChoicedProduct,
      required this.onChangeRadio,
      required this.controller,
      required this.invoice})
      : super(key: key);

  @override
  _CustomBottomSheetState createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet>
    implements CustomBottomSheetView {
  late CustomBottomSheetPresenter _presenter;

  @override
  void initState() {
    super.initState();
    _presenter = CustomBottomSheetPresenter();
    _presenter.view = this;
  }

  @override
  @override
  void onClickPlace(Box currentBox) {}

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    List<OrderDetail> listProduct = widget.invoice!.orderDetails
        .where((element) => element.productType == 2)
        .toList();
    Widget buildBottomDrawer(BuildContext context) {
      return BottomDrawer(
        header: Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8))),
          height: deviceSize.height / 8,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomText(
                  text: 'Order #' + widget.invoice!.id.toString(),
                  color: CustomColor.black,
                  context: context,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
              CustomText(
                  text: 'Remaining: ' + listProduct.length.toString(),
                  color: CustomColor.black,
                  context: context,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
              CustomButton(
                  height: 24,
                  text: 'Hoàn tất',
                  width: deviceSize.width / 3,
                  onPressFunction: () {},
                  isLoading: false,
                  textColor: CustomColor.white,
                  buttonColor: CustomColor.blue,
                  borderRadius: 6),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              SizedBox(
                height: deviceSize.height / 2,
                child: GridView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1,
                    mainAxisSpacing: 16.0,
                    crossAxisSpacing: 16.0,
                  ),
                  itemBuilder: (ctx, i) {
                    return ItemRadioWidget(
                      currentChoicedProduct: widget.currentChoicedProduct,
                      product: listProduct[i],
                      onChangeRadio: widget.onChangeRadio,
                    );
                  },
                  itemCount: listProduct.length,
                ),
              ),
              CustomSizedBox(
                context: context,
                height: 32,
              ),
              CustomButton(
                  height: 24,
                  text: 'Đặt',
                  width: deviceSize.width / 3,
                  onPressFunction: () {},
                  isLoading: false,
                  textColor: CustomColor.white,
                  buttonColor: CustomColor.green,
                  borderRadius: 6),
            ],
          ),
        ),
        headerHeight: deviceSize.height / 8,
        drawerHeight: deviceSize.height * 5 / 6,
        color: CustomColor.white,
        controller: widget.controller,
      );
    }

    return buildBottomDrawer(context);
  }
}
