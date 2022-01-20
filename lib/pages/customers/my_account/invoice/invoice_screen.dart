import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/custom_text.dart';
import 'package:rssms/models/entity/invoice.dart';
import 'package:rssms/models/entity/user.dart';
import 'package:rssms/models/invoice_model.dart';
import 'package:rssms/pages/customers/my_account/invoice/invoice_widget.dart';
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
  late bool _isFound;

  @override
  void initState() {
    super.initState();
    _isFound = false;
    Users user = Provider.of<Users>(context, listen: false);
    _presenter = InvoicePresenter();
    _presenter.view = this;
    _model = _presenter.model!;
    _presenter.loadInvoice(user.idToken!);
    _model.searchValue.addListener(onHandleChangeInput);
  }

  List<Widget> mapInvoiceWidget(listInvoice) => listInvoice
      .map<InvoiceWidget>((e) => InvoiceWidget(
            invoice: e,
          ))
      .toList();

  @override
  void setChangeList() {
    setState(() {});
  }

  @override
  void updateIsLoadingInvoice() {
    _model.isLoadingInvoice = !_model.isLoadingInvoice!;
  }

  @override
  void onHandleChangeInput() {
    _presenter.handleOnChangeInput(_model.searchValue.text);
  }

  @override
  void refreshList(String searchValue) {
    if (searchValue.isEmpty) {
      setState(() {
        _isFound = false;
      });
    }
  }

  Widget invoiceWidget() {
    if (!_isFound) {
      return Expanded(
          child: ListView(
        padding: const EdgeInsets.all(0),
        children: mapInvoiceWidget(_model.getListInvoice()),
      ));
    } else {
      return InvoiceWidget(invoice: _model.searchInvoice);
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return SizedBox(
      width: deviceSize.width,
      height: deviceSize.height * 1.5,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TypeAheadField(
                    textFieldConfiguration: TextFieldConfiguration(
                      controller: _model.searchValue,
                      onEditingComplete: (){
                        _presenter.handleOnChangeInput(_model.searchValue.text);
                      },
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        prefixIcon: ImageIcon(
                          const AssetImage('assets/images/search.png'),
                          color: CustomColor.black[2]!,
                        ),
                      ),
                    ),
                    suggestionsCallback: (pattern) async {
                      return _model
                          .getListInvoice()!
                          .where((element) =>
                              element.id.toString().contains(pattern))
                          .toList();
                    },
                    itemBuilder: (context, suggestion) {
                      Invoice shelf = suggestion! as Invoice;
                      return ListTile(
                        title: Text(shelf.id.toString()),
                      );
                    },
                    noItemsFoundBuilder: (context) => Center(
                      child: CustomText(
                          text: 'No invoice found!',
                          color: CustomColor.black,
                          context: context,
                          fontSize: 16),
                    ),
                    onSuggestionSelected: (suggestion) {
                      setState(() {
                        _isFound = true;
                        _model.searchInvoice = suggestion as Invoice;
                        _model.searchValue.text = suggestion.id.toString();
                      });
                    },
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
            
            if (!_model.isLoadingInvoice!)
              invoiceWidget()
            else
              const SizedBox(
                height: 16,
                width: 16,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.black45),
                ),
              )
          ],
        ),
      ),
    );
  }
}
