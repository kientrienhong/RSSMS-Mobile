import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/custom_text.dart';
import 'package:rssms/common/export_widget.dart';
import 'package:rssms/common/import_widget.dart';
import 'package:rssms/common/invoice_image_widget.dart';
import 'package:rssms/common/tab/invoice_tab.dart';
import 'package:rssms/common/tab/item_tab.dart';
import 'package:rssms/models/entity/invoice.dart';
import 'package:rssms/models/entity/user.dart';
import 'package:rssms/models/invoice_detail_screen.dart';
import 'package:rssms/pages/customers/cart/widgets/title_tab.dart';
import 'package:rssms/constants/constants.dart' as constants;
import 'package:rssms/presenters/invoice_detail_screen_presenter.dart';
import 'package:rssms/views/invoice_detail_screen_view.dart';

class InvoiceDetailScreen extends StatefulWidget {
  final Invoice invoice;

  const InvoiceDetailScreen({
    Key? key,
    required this.invoice,
  }) : super(key: key);

  @override
  State<InvoiceDetailScreen> createState() => _InvoiceDetailScreenState();
}

class _InvoiceDetailScreenState extends State<InvoiceDetailScreen>
    implements InvoiceDetailScreenView {
  late int _index;
  late InvoiceDetailScreenModel _model;
  late InvoiceDetailScreenPresenter _presenter;
  @override
  void updateLoading() {
    setState(() {
      _model.isLoading = !_model.isLoading;
    });
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

    _presenter.loadingDetailInvoice(widget.invoice.id, user.idToken!);
    _index = 0;
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
    final deviceSize = MediaQuery.of(context).size;
    List<TitleTab> mapListTab() {
      int index = 0;
      return constants.tabInvoiceDetail.map<TitleTab>((e) {
        return TitleTab(
          title: e,
          index: index++,
          deviceSize: deviceSize,
          currentIndex: _index,
          onChangeTab: onChangeTab,
        );
      }).toList();
    }

    Widget switchWidget() {
      switch (_index) {
        case 0:
          return InvoiceTab(
            request: _model.request,
            isOrderReturn: _model.isRequestReturn,
            deviceSize: deviceSize,
            orginalInvoice: _model.orginalInvoice,
            invoice: _model.showUIInvoice,
          );
        case 1:
          return ItemTab(invoice: _model.invoice);

        case 2:
          if (_model.import.id != '') {
            return ImportWidget(
                onClickAcceptImport: () {},
                import: _model.import,
                orderDetail: _model.showUIInvoice.orderDetails);
          } else {
            return Center(
              child: CustomText(
                  text: "Đơn hiện vẫn chưa nhập kho",
                  color: CustomColor.black,
                  context: context,
                  fontSize: 16),
            );
          }

        case 3:
          if (_model.export.id != '') {
            return ExportWidget(
                onClickAcceptImport: () {},
                export: _model.export,
                orderDetail: _model.showUIInvoice.orderDetails);
          } else {
            return Center(
              child: CustomText(
                  text: "Đơn hiện vẫn chưa xuất kho",
                  color: CustomColor.black,
                  context: context,
                  fontSize: 16),
            );
          }
        default:
          return Container();
      }
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
                padding: const EdgeInsets.only(left: 24, right: 24, bottom: 24),
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
                            child: Image.asset(
                              'assets/images/arrowLeft.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: widget.invoice.typeOrder == 1
                            ? mapListTab()
                            : mapListTab().where((element) =>
                                element.index  != 2 &&
                                element.index != 3).toList(),
                      ),
                      CustomSizedBox(
                        context: context,
                        height: 16,
                      ),
                      switchWidget()
                    ],
                  ),
                ),
              ));
  }
}
