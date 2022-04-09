import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/custom_tabbutton.dart';
import 'package:rssms/common/custom_text.dart';
import 'package:rssms/common/invoice_image_widget.dart';
import 'package:rssms/common/tab/invoice_tab.dart';
import 'package:rssms/common/tab/item_tab.dart';
import 'package:rssms/models/entity/invoice.dart';
import 'package:rssms/models/entity/user.dart';
import 'package:rssms/models/invoice_detail_screen.dart';
import 'package:rssms/models/invoice_model.dart';
import 'package:rssms/pages/customers/cart/widgets/title_tab.dart';
import 'package:rssms/constants/constants.dart' as constants;
import 'package:rssms/presenters/invoice_detail_screen_presenter.dart';
import 'package:rssms/presenters/invoice_presenter.dart';
import 'package:rssms/views/invoice_detail_screen_view.dart';
import 'package:rssms/views/invoice_view.dart';

class InvoiceDetailScreen extends StatefulWidget {
  Invoice? invoice;

  InvoiceDetailScreen({
    Key? key,
    this.invoice,
  }) : super(key: key);

  @override
  State<InvoiceDetailScreen> createState() => _InvoiceDetailScreenState();
}

class _InvoiceDetailScreenState extends State<InvoiceDetailScreen>
    with InvoiceDetailScreenView {
  late int _index;
  late InvoiceDetailScreenModel _model;
  late InvoiceDetailScreenPresenter _presenter;
  @override
  void updateLoading() {
    if (mounted) {
      setState(() {
        _model.isLoading = !_model.isLoading;
      });
    }
  }

  @override
  void updateView(Invoice invoice, Invoice updatedInvoice) {
    setState(() {
      _model.invoice = invoice;
      _model.showUIInvoice = updatedInvoice;
    });
  }

  @override
  void initState() {
    super.initState();
    _presenter = InvoiceDetailScreenPresenter();
    _model = _presenter.model;
    _presenter.view = this;
    Users user = Provider.of<Users>(context, listen: false);

    _presenter.loadingDetailInvoice(widget.invoice!.id, user.idToken!);
    _index = 0;
    _presenter.view = this;
    _model = _presenter.model;
    // if (widget.invoiceID != null) {
    //   _presenter.loadInvoiceByID(user.idToken!, widget.invoiceID.toString());
    //   widget.invoice = _model.notiInvoice;
    // }
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
  /* Widget build(BuildContext context) {
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
*/
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    List<TitleTab> mapListTab() {
      int index = 0;

      return constants.TAB_INVOICE_DETAIL
          .map<TitleTab>((e) => TitleTab(
                title: e,
                index: index++,
                deviceSize: deviceSize,
                currentIndex: _index,
                onChangeTab: onChangeTab,
              ))
          .toList();
    }

    return Scaffold(
        backgroundColor: CustomColor.white,
        body: _model.isLoading
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
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: SizedBox(
                  width: deviceSize.width,
                  height: deviceSize.height,
                  child: ListView(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: SizedBox(
                          width: 24,
                          height: 24,
                          child: GestureDetector(
                            onTap: () => {Navigator.of(context).pop()},
                            child: Image.asset('assets/images/arrowLeft.png'),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: mapListTab(),
                      ),
                      CustomSizedBox(
                        context: context,
                        height: 16,
                      ),
                      _index == 0
                          ? InvoiceTab(
                              deviceSize: deviceSize,
                              invoice: _model.showUIInvoice,
                            )
                          : ItemTab(invoice: _model.invoice)
                    ],
                  ),
                ),
              ));
  }
}
