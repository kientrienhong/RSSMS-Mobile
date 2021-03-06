import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rssms/common/confirm_dialog.dart';
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
  final Request request;

  const ExtendRequestScreen({Key? key, required this.request})
      : super(key: key);

  @override
  State<ExtendRequestScreen> createState() => _ExtendRequestScreenState();
}

class _ExtendRequestScreenState extends State<ExtendRequestScreen>
    implements ExtendRequestView {
  ExtendRequestPresenter? _presenter;
  ExtendRequestModel? _model;
  List<OrderDetail>? listProduct;
  @override
  void onPressCancel() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ConfirmDialog(
            confirmFunction: _presenter!.cancelRequest,
            id: _model!.request!.id);
      },
    ).then((value) => {
          if (value) {init()}
        });
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
            element.productType == constants.typeProduct.handy.index ||
            element.productType == constants.typeProduct.unweildy.index ||
            element.productType == constants.typeProduct.selfStorage.index)
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

  final oCcy = NumberFormat("#,##0", "en_US");
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
                      child: SizedBox(
                        width: 24,
                        height: 24,
                        child: GestureDetector(
                          onTap: () => {Navigator.of(context).pop()},
                          child: Image.asset(
                            'assets/images/arrowLeft.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ),
                  CustomText(
                      text: "Chi ti???t ????n gia h???n",
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
                                  text: "S???n ph???m gia h???n",
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
                                        text: "S???n ph???m",
                                        color: CustomColor.black,
                                        fontWeight: FontWeight.bold,
                                        context: context,
                                        fontSize: 14),
                                    CustomText(
                                        text: "S??? l?????ng",
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
                                height: 16,
                              ),
                              _model!.invoice!.typeOrder ==
                                      constants.doorToDoorTypeOrder
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CustomText(
                                            text: "S??? ng??y mu???n gia h???n",
                                            color: Colors.black,
                                            context: context,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                        CustomText(
                                            text: DateTime.parse(_model!
                                                        .request!.returnDate)
                                                    .difference(DateTime.parse(
                                                        _model!.request!
                                                            .oldReturnDate))
                                                    .inDays
                                                    .toString() +
                                                " ng??y",
                                            color: Colors.black,
                                            context: context,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ],
                                    )
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CustomText(
                                            text: "S??? th??ng mu???n gia h???n",
                                            color: Colors.black,
                                            context: context,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                        CustomText(
                                            text: ((DateTime.parse(_model!
                                                                .request!
                                                                .returnDate)
                                                            .difference(DateTime
                                                                .parse(_model!
                                                                    .request!
                                                                    .oldReturnDate))
                                                            .inDays) /
                                                        30)
                                                    .floor()
                                                    .toString() +
                                                " th??ng",
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
                                      text: "T???ng ti???n thu?? kho",
                                      color: Colors.black,
                                      context: context,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                  CustomText(
                                      text: oCcy
                                              .format(
                                                  _model!.request!.totalPrice)
                                              .toString() +
                                          " ??",
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
                                text: "Ng??y tr??? c??",
                                color: Colors.black,
                                context: context,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                            CustomText(
                                text: _model!.request!.oldReturnDate
                                    .split("T")[0],
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
                                text: "Ng??y tr??? kho sau khi gia h???n",
                                color: CustomColor.black,
                                context: context,
                                fontWeight: FontWeight.bold,
                                maxLines: 2,
                                fontSize: 18,
                                textOverflow: TextOverflow.ellipsis,
                              ),
                            ),
                            CustomText(
                                text: _model!.request!.returnDate.split("T")[0],
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
