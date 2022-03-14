import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/custom_tabbutton.dart';
import 'package:rssms/common/custom_text.dart';
import 'package:rssms/common/invoice_image_widget.dart';
import 'package:rssms/models/entity/invoice.dart';
import 'package:rssms/models/entity/user.dart';
import 'package:rssms/models/invoice_model.dart';
import 'package:rssms/pages/customers/cart/widgets/title_tab.dart';
import 'package:rssms/pages/customers/my_account/invoice/invoice_detail_screen/tab/invoice_tab.dart';
import 'package:rssms/pages/customers/my_account/invoice/invoice_detail_screen/tab/item_tab.dart';
import 'package:rssms/constants/constants.dart' as constants;
import 'package:rssms/presenters/invoice_presenter.dart';
import 'package:rssms/views/invoice_view.dart';

class InvoiceDetailScreen extends StatefulWidget {
  Invoice? invoice;
  final Size deviceSize;
  int? invoiceID;

  InvoiceDetailScreen(
      {Key? key, this.invoice, required this.deviceSize, this.invoiceID})
      : super(key: key);

  @override
  State<InvoiceDetailScreen> createState() => _InvoiceDetailScreenState();
}

class _InvoiceDetailScreenState extends State<InvoiceDetailScreen>
    with InvoiceView {
  late int _index;
  late InvoicePresenter _presenter;
  late InvoiceModel _model;

  @override
  void initState() {
    super.initState();
    _index = 0;
    Users user = Provider.of<Users>(context, listen: false);
    _presenter = InvoicePresenter();
    _presenter.view = this;
    _model = _presenter.model!;
    if (widget.invoiceID != null) {
      _presenter.loadInvoiceByID(user.idToken!, widget.invoiceID.toString());
      widget.invoice = _model.notiInvoice;
    }
  }

  List<TitleTab> mapListTab() {
    int index = 0;

    return constants.TAB_INVOICE_DETAIL
        .map<TitleTab>((e) => TitleTab(
              title: e,
              index: index++,
              deviceSize: widget.deviceSize,
              currentIndex: _index,
              onChangeTab: onChangeTab,
            ))
        .toList();
  }

  void onChangeTab(int index) {
    setState(() {
      _index = index;
    });
  }

  List<Widget> mapImageWidget(listImage) => listImage
      .map<InvoiceImageWidget>((i) => InvoiceImageWidget(
            image: i,
          ))
      .toList();

  @override
  Widget build(BuildContext context) {
    // List<Map<String, dynamic>> listImage = invoice!["image"];

    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
          appBar: AppBar(
            leading: SizedBox(
              width: 24,
              height: 24,
              child: GestureDetector(
                onTap: () => {Navigator.of(context).pop()},
                child: Image.asset('assets/images/arrowLeft.png'),
              ),
            ),
            title: CustomText(
                text: "Chi tiết đơn hàng",
                color: Colors.black,
                context: context,
                fontWeight: FontWeight.bold,
                fontSize: 25),
            elevation: 0,
            backgroundColor: CustomColor.white,
            centerTitle: true,
            automaticallyImplyLeading: false,
            bottom: TabBar(
              tabs: [
                TabButton(
                  text: CustomText(
                    text: "Đơn hàng",
                    color: CustomColor.black,
                    context: context,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  pageNumber: 1,
                  onPressed: () {},
                ),
                TabButton(
                  text: CustomText(
                    text: "Hình ảnh",
                    color: CustomColor.black,
                    context: context,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  pageNumber: 2,
                  onPressed: () {},
                )
              ],
            ),
          ),
          backgroundColor: CustomColor.white,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: SizedBox(
              width: widget.deviceSize.width,
              height: widget.deviceSize.height,
              child: TabBarView(
                children: [
                  InvoiceTab(
                    deviceSize: widget.deviceSize,
                    invoice: widget.invoice,
                  ),
                  ItemTab(invoice: widget.invoice)
                ],
              ),
            ),
          )),
    );
  }

  @override
  void onHandleChangeInput() {
    // TODO: implement onHandleChangeInput
  }

  @override
  Future<void> refresh() {
    // TODO: implement refresh
    throw UnimplementedError();
  }

  @override
  void refreshList(String searchValue) {
    // TODO: implement refreshList
  }

  @override
  void setChangeList() {
    // TODO: implement setChangeList
  }

  @override
  void updateIsLoadingInvoice() {
    // TODO: implement updateIsLoadingInvoice
  }
}
