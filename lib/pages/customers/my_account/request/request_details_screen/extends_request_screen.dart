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

class ExtendRequestScreen extends StatefulWidget {
  Request request;

  ExtendRequestScreen({Key? key, required this.request}) : super(key: key);

  @override
  State<ExtendRequestScreen> createState() => _ExtendRequestScreenState();
}

class _ExtendRequestScreenState extends State<ExtendRequestScreen>
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

  List<Widget> mapProductWidget(listProduct) => listProduct
      .map<ProductInvoiceWidget>((p) => ProductInvoiceWidget(
            product: p,
          ))
      .toList();

  void init() async {
    Users users = Provider.of<Users>(context, listen: false);
    await _presenter!.getRequest(widget.request.id.toString(), users.idToken!);
    await _presenter!
        .loadInvoice(users.idToken!, widget.request.orderId.toString());
  }

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
                  CustomText(
                      text: "Chi tiết đơn gia hạn",
                      color: Colors.black,
                      context: context,
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                  CustomSizedBox(
                    context: context,
                    height: 32,
                  ),
                  if (!_model!.isLoadingRequest!)
                    Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 16),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: CustomColor.blue, width: 1)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                  text: "Sản phẩm gia hạn",
                                  color: CustomColor.blue,
                                  context: context,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                              CustomSizedBox(
                                context: context,
                                height: 16,
                              ),
                              Table(
                                children: [
                                  TableRow(children: [
                                    CustomText(
                                        text: "Sản phẩm",
                                        color: CustomColor.black,
                                        fontWeight: FontWeight.bold,
                                        context: context,
                                        fontSize: 14),
                                    CustomText(
                                        text: "Số lượng",
                                        color: CustomColor.black,
                                        textAlign: TextAlign.right,
                                        fontWeight: FontWeight.bold,
                                        context: context,
                                        fontSize: 14),
                                  ])
                                ],
                              ),
                              CustomSizedBox(
                                context: context,
                                height: 16,
                              ),
                              Column(
                                children: mapProductWidget(listProduct),
                              ),
                              Container(
                                color: CustomColor.white,
                                child: const Divider(
                                  thickness: 0.6,
                                  color: Color(0xFF8D8D8D),
                                ),
                              ),
                              CustomSizedBox(
                                context: context,
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomText(
                                      text: "Tạm tính",
                                      color: Colors.black,
                                      context: context,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                  CustomText(
                                      text: "100,000 đ",
                                      color: Colors.black,
                                      context: context,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ],
                              ),
                              CustomSizedBox(
                                context: context,
                                height: 16,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomText(
                                      text: "Số tháng muốn gia hạn",
                                      color: Colors.black,
                                      context: context,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                  CustomText(
                                      text: "5 tháng",
                                      color: Colors.black,
                                      context: context,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ],
                              ),
                              CustomSizedBox(
                                context: context,
                                height: 6,
                              ),
                              Container(
                                color: CustomColor.white,
                                child: const Divider(
                                  thickness: 0.6,
                                  color: Color(0xFF8D8D8D),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomText(
                                      text: "Tổng tiền thuê kho",
                                      color: Colors.black,
                                      context: context,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                  CustomText(
                                      text: "500,000 đ",
                                      color: CustomColor.blue,
                                      context: context,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17),
                                ],
                              ),
                            ],
                          ),
                        ),
                        CustomSizedBox(
                          context: context,
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                                text: "Ngày trả cũ",
                                color: Colors.black,
                                context: context,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                            CustomText(
                                text: _model!.invoice!.returnDate.substring(0,
                                    _model!.invoice!.returnDate.indexOf("T")),
                                color: CustomColor.black,
                                context: context,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ],
                        ),
                        CustomSizedBox(
                          context: context,
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: deviceSize.width * 1.3 / 3,
                              child: CustomText(
                                text: "Ngày trả kho sau khi gia hạn",
                                color: CustomColor.black,
                                context: context,
                                fontWeight: FontWeight.bold,
                                maxLines: 2,
                                fontSize: 18,
                                textOverflow: TextOverflow.ellipsis,
                              ),
                            ),
                            CustomText(
                                text: _model!.request!.returnDate.substring(0,
                                    _model!.request!.returnDate.indexOf("T")),
                                color: CustomColor.black,
                                context: context,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ],
                        ),
                        CustomSizedBox(
                          context: context,
                          height: 16,
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
