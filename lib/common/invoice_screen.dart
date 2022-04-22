import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/custom_text.dart';
import 'package:rssms/models/entity/user.dart';
import 'package:rssms/models/invoice_model.dart';
import 'package:rssms/common/invoice_widget.dart';
import 'package:rssms/presenters/invoice_presenter.dart';
import 'package:rssms/views/invoice_view.dart';

class InvoiceScreen extends StatefulWidget {
  const InvoiceScreen({Key? key}) : super(key: key);

  @override
  State<InvoiceScreen> createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen> implements InvoiceView {
  late InvoicePresenter _presenter;
  late InvoiceModel _model;

  @override
  void initState() {
    super.initState();
    Users user = Provider.of<Users>(context, listen: false);
    _presenter = InvoicePresenter();
    _presenter.view = this;
    _model = _presenter.model;
    _presenter.init(user.idToken!);
  }

  List<Widget> mapInvoiceWidget(listInvoice) => listInvoice
      .map<InvoiceWidget>((e) => InvoiceWidget(
            invoice: e,
          ))
      .toList();

  @override
  void setChangeList() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void updateIsLoadingInvoice() {
    if (mounted) {
      setState(() {
        _model.isLoadingInvoice = !_model.isLoadingInvoice;
      });
    }
  }

  @override
  void onHandleChangeInput() {
    _presenter.handleOnChangeInput(_model.searchValue.text);
  }

  @override
  void refreshList(String searchValue) {
    setState(() {});
  }

  @override
  Future<void> refresh() {
    Users user = Provider.of<Users>(context, listen: false);
    setState(() {
      _model.onRefresh = true;
    });

    _presenter.loadInvoice(idToken: user.idToken, clearCachedDate: true);

    return Future.value();
  }

  Widget invoiceList() {
    return StreamBuilder(
      stream: _model.stream,
      builder: (context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Center(
              child: CustomText(
                  text: "Hiện vẫn chưa có đơn hàng",
                  color: CustomColor.black,
                  context: context,
                  fontSize: 16),
            ),
          );
        } else {
          return Flexible(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              controller: _model.scrollController,
              itemCount: snapshot.data!.length + 1,
              itemBuilder: (context, index) {
                if (index < snapshot.data.length) {
                  return InvoiceWidget(
                    invoice: snapshot.data[index],
                  );
                } else if (_model.hasMore) {
                  return Column(
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
                              AlwaysStoppedAnimation<Color>(Colors.blue),
                        ),
                      ),
                    ],
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Center(
                      child: CustomText(
                          text: "Đã hết đơn !",
                          color: Colors.black38,
                          context: context,
                          fontSize: 14),
                    ),
                  );
                }
              },
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return RefreshIndicator(
      onRefresh: refresh,
      child: Container(
        color: CustomColor.white,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        width: deviceSize.width,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _model.searchValue,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      prefixIcon: ImageIcon(
                        const AssetImage('assets/images/search.png'),
                        color: CustomColor.black[2]!,
                      ),
                    ),
                  ),
                ),
                CustomSizedBox(
                  context: context,
                  width: 16,
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: CustomColor.white,
                      border: Border.all(color: CustomColor.black, width: 0.5)),
                  child: PopupMenuButton(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      )),
                      icon: const ImageIcon(
                          AssetImage('assets/images/filter.png')),
                      itemBuilder: (_) => <PopupMenuItem<String>>[
                            PopupMenuItem<String>(
                                child: CustomText(
                                    text: 'Kho tự quản',
                                    color: _model.filterIndex == "0"
                                        ? CustomColor.blue
                                        : CustomColor.black,
                                    context: context,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                                value: '0'),
                            PopupMenuItem<String>(
                                child: CustomText(
                                    text: 'Giữ đồ thuê',
                                    color: _model.filterIndex == "1"
                                        ? CustomColor.blue
                                        : CustomColor.black,
                                    context: context,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                                value: '1'),
                          ],
                      onSelected: (_) {
                        if (_.toString() == _model.filterIndex) {
                          setState(() {
                            _model.filterIndex = "10";
                          });
                        } else {
                          setState(() {
                            _model.filterIndex = _.toString();
                          });
                        }
                      }),
                ),
              ],
            ),
            invoiceList()
          ],
        ),
      ),
    );
  }
}
