import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rssms/common/custom_button.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/custom_text.dart';
import 'package:rssms/models/dialog_add_service_model.dart';
import 'package:rssms/models/entity/product.dart';
import 'package:rssms/models/entity/user.dart';
import 'package:rssms/pages/delivery_staff/qr/invoice_screen/update_invoice_screen/widget/add_product.dart';
import 'package:rssms/presenters/dialog_add_service_presenter.dart';
import 'package:rssms/views/dialog_add_service_view.dart';

class DialogAddService extends StatefulWidget {
  final String? idOrderDetail;
  const DialogAddService({Key? key, this.idOrderDetail}) : super(key: key);

  @override
  State<DialogAddService> createState() => _DialogAddServiceState();
}

class _DialogAddServiceState extends State<DialogAddService>
    implements DialogAddServiceView {
  late DialogAddServicePresenter _presenter;
  late DialogAddServiceModel _model;
  @override
  void initState() {
    _presenter = DialogAddServicePresenter(widget.idOrderDetail);
    _presenter.view = this;
    _model = _presenter.model;
    Users user = Provider.of<Users>(context, listen: false);

    _presenter.getListProduct(user.idToken!);
    super.initState();
  }

  @override
  void updateLoading() {
    setState(() {
      _model.isLoading = !_model.isLoading;
    });
  }

  @override
  void updateListAddition(List<Product> listAccessory) {
    setState(() {
      _model.listProductAccessory = listAccessory;
    });
  }

  @override
  void updateListService(List<Product> listBucky, List<Product> listHandy) {
    setState(() {
      _model.listProductBulky = listBucky;
      _model.listProductHandy = listHandy;
    });
  }

  List<AddProduct> mapWidget(List<Product> listProduct) {
    return listProduct
        .map((e) => AddProduct(
              product: e,
              orderDetail: widget.idOrderDetail,
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    Widget _buildAddition() {
      return SingleChildScrollView(
        child: SizedBox(
          width: deviceSize.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomText(
                  text: 'Phụ kiện',
                  color: CustomColor.black,
                  context: context,
                  fontWeight: FontWeight.bold,
                  fontSize: 24),
              CustomSizedBox(
                context: context,
                height: 16,
              ),
              Column(
                children: mapWidget(_model.listProductAccessory),
              ),
              CustomSizedBox(
                context: context,
                height: 8,
              ),
              CustomButton(
                  height: 16,
                  text: 'Đóng',
                  width: deviceSize.width / 4,
                  onPressFunction: () {
                    Navigator.of(context).pop();
                  },
                  isLoading: false,
                  textColor: CustomColor.white,
                  buttonColor: CustomColor.red,
                  borderRadius: 4),
              CustomSizedBox(
                context: context,
                height: 8,
              ),
            ],
          ),
        ),
      );
    }

    Widget _buildMainProduct() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomText(
              text: 'Giữ theo loại',
              color: CustomColor.black,
              context: context,
              fontWeight: FontWeight.bold,
              fontSize: 24),
          CustomSizedBox(
            context: context,
            height: 16,
          ),
          Column(
            children: mapWidget(_model.listProductHandy),
          ),
          CustomText(
              text: 'Giữ theo diện tích',
              color: CustomColor.black,
              context: context,
              fontWeight: FontWeight.bold,
              fontSize: 24),
          CustomSizedBox(
            context: context,
            height: 16,
          ),
          Column(
            children: mapWidget(_model.listProductBulky),
          ),
          CustomSizedBox(
            context: context,
            height: 8,
          ),
          CustomButton(
              height: 16,
              text: 'Đóng',
              width: deviceSize.width / 4,
              onPressFunction: () {
                Navigator.of(context).pop();
              },
              isLoading: false,
              textColor: CustomColor.white,
              buttonColor: CustomColor.red,
              borderRadius: 4),
          CustomSizedBox(
            context: context,
            height: 8,
          ),
        ],
      );
    }

    return AlertDialog(
      content: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: _model.isLoading
            ? SizedBox(
                width: deviceSize.width,
                height: deviceSize.height,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      SizedBox(
                        height: 48,
                        width: 48,
                        child: CircularProgressIndicator(
                          backgroundColor: CustomColor.blue,
                        ),
                      ),
                    ]),
              )
            : SingleChildScrollView(
                child: SizedBox(
                    width: deviceSize.width,
                    child: _model.idOrderDetail == null
                        ? _buildMainProduct()
                        : _buildAddition()),
              ),
      ),
    );
  }
}
