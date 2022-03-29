import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/custom_text.dart';
import 'package:rssms/models/entity/order_detail.dart';
import 'package:rssms/models/entity/request.dart';
import 'package:rssms/models/entity/user.dart';
import 'package:rssms/models/extend_request_model.dart';
import 'package:rssms/pages/customers/my_account/invoice/invoice_detail_screen/product_in_invoice/product_widget.dart';
import 'package:rssms/presenters/extend_request_presenter.dart';
import 'package:rssms/views/extend_request_view.dart';
import 'package:rssms/constants/constants.dart' as constants;

class GetItemRequestScreen extends StatefulWidget {
  Request request;

  GetItemRequestScreen({Key? key, required this.request}) : super(key: key);

  @override
  State<GetItemRequestScreen> createState() => _GetItemRequestScreenState();
}

class _GetItemRequestScreenState extends State<GetItemRequestScreen>
    implements ExtendRequestView {
  ExtendRequestPresenter? _presenter;
  ExtendRequestModel? _model;
  List<OrderDetail>? listProduct;

  void loadRequestDetails() {
    // TODO: implement loadRequestDetails
  }

  @override
  void initState() {
    super.initState();
    _presenter = ExtendRequestPresenter();
    _model = _presenter!.model;
    _presenter!.view = this;
    init();
  }

  void init() async {
    Users users = Provider.of<Users>(context, listen: false);
    await _presenter!.getRequest(widget.request.id.toString(), users.idToken!);
    await _presenter!
        .loadInvoice(users.idToken!, widget.request.orderId.toString());
  }

  List<Widget> mapProductWidget(listProduct) => listProduct
      .map<ProductInvoiceWidget>((p) => ProductInvoiceWidget(
            product: p,
          ))
      .toList();

  @override
  void setChangeView() {
    List<OrderDetail> listTemp = _model!.invoice!.orderDetails;
    listProduct = listTemp
        .where((element) =>
            element.productType == constants.HANDY ||
            element.productType == constants.UNWEILDY)
        .toList();
    setState(() {});
  }

  @override
  void changeLoadingStatus() {
    _model!.isLoadingRequest = !_model!.isLoadingRequest!;
  }

  @override
  void setChangeViewRequest() {
    setState(() {});
  }

  Widget _buildInformation(String name, String content) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
            text: name,
            color: Colors.black,
            context: context,
            fontWeight: FontWeight.bold,
            fontSize: 17),
        CustomText(
            text: content, color: Colors.black, context: context, fontSize: 16),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
          child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              width: deviceSize.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    child: GestureDetector(
                      onTap: () => {Navigator.of(context).pop()},
                      child: Image.asset('assets/images/arrowLeft.png'),
                    ),
                  ),
                  Center(
                    child: CustomText(
                        text: "Chi tiết đơn lấy về",
                        color: Colors.black,
                        context: context,
                        fontWeight: FontWeight.bold,
                        fontSize: 25),
                  ),
                  CustomSizedBox(
                    context: context,
                    height: 32,
                  ),
                  if (!_model!.isLoadingRequest!)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                                text: 'Trạng thái: ',
                                color: Colors.black,
                                context: context,
                                fontWeight: FontWeight.bold,
                                fontSize: 17),
                            CustomText(
                                text: constants.LIST_STATUS_REQUEST[
                                    widget.request.status]['name'] as String,
                                color: constants.LIST_STATUS_REQUEST[
                                    widget.request.status]['color'] as Color,
                                context: context,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ],
                        ),
                        CustomSizedBox(
                          context: context,
                          height: 24,
                        ),
                        _buildInformation(
                            "Tên khách hàng:", _model!.invoice!.customerName),
                        CustomSizedBox(
                          context: context,
                          height: 24,
                        ),
                        _buildInformation(
                            "Số điện thoại:", _model!.invoice!.customerPhone),
                        CustomSizedBox(
                          context: context,
                          height: 24,
                        ),
                        _buildInformation(
                            "Ngày trả hàng:", _model!.request!.returnDate),
                        CustomSizedBox(
                          context: context,
                          height: 24,
                        ),
                        _buildInformation(
                            "Khung giờ trả hàng:", _model!.request!.returnTime),
                        CustomSizedBox(
                          context: context,
                          height: 24,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                                text: "Địa chỉ nhận hàng:",
                                color: Colors.black,
                                context: context,
                                fontWeight: FontWeight.bold,
                                fontSize: 17),
                            Flexible(
                                child: CustomText(
                                    text: _model?.request?.returnAddress ?? "",
                                    color: CustomColor.black,
                                    maxLines: 2,
                                    context: context,
                                    fontSize: 18))
                          ],
                        ),
                        CustomSizedBox(
                          context: context,
                          height: 24,
                        ),
                      ],
                    )
                  else
                    Center(
                      child: Column(
                        children: [
                          CustomSizedBox(
                            context: context,
                            height: 50,
                          ),
                          const SizedBox(
                            height: 16,
                            width: 16,
                            child: CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.black45),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ))),
    );
  }
}
