import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/models/entity/user.dart';
import 'package:rssms/models/request_screen_model.dart';
import 'package:rssms/pages/customers/my_account/request/request_widget.dart';
import 'package:rssms/presenters/request_screen_presenter.dart';
import 'package:rssms/views/request_screen_view.dart';

enum REQUEST_TYPE { modifyRequest, cancelOrderRequest, cancelDeliveryRequest }

class RequestScreen extends StatefulWidget {
  const RequestScreen({Key? key}) : super(key: key);

  @override
  State<RequestScreen> createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> with RequestScreenView {
  late RequestScreenPresenter _presenter;

  late RequestScreenModel _model;

  List<Widget> mapInvoiceWidget(listRequest) => listRequest
      .map<RequestWidget>((e) => RequestWidget(
            request: e,
          ))
      .toList();

  @override
  void initState() {
    _presenter = RequestScreenPresenter();
    _model = _presenter.model!;
    _presenter.view = this;
    Users users = Provider.of<Users>(context, listen: false);
    _presenter.loadCusRequest(users.idToken!);
    super.initState();
  }

  @override
  void updateLoadingRequest() {
    setState(() {
      _model.isLoadingRequest = !_model.isLoadingRequest!;
    });
  }

  @override
  void setChangeList() {
    setState(() {});
  }

  Widget invoiceWidget() {
    return Expanded(
        child: ListView(
      padding: const EdgeInsets.all(0),
      children: mapInvoiceWidget(_model.listRequest),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return RefreshIndicator(
      onRefresh: () {
        return Future.value();
      },
      child: SizedBox(
        width: deviceSize.width,
        height: deviceSize.height * 1.5,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(5),
                          prefixIcon: const ImageIcon(
                            AssetImage('assets/images/search.png'),
                            color: CustomColor.black,
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: const BorderSide(
                                color: CustomColor.black,
                              ))),
                    ),
                  ),
                ],
              ),
              if (!(_model.isLoadingRequest!))
                invoiceWidget()
              else
                Column(
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
                )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Future<void> refresh() {
    // TODO: implement refresh
    throw UnimplementedError();
  }
}
