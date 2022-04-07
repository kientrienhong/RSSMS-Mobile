import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/custom_text.dart';
import 'package:rssms/models/entity/user.dart';
import 'package:rssms/models/request_screen_model.dart';
import 'package:rssms/pages/delivery_staff/request/widgets/request_widget.dart';
import 'package:rssms/presenters/request_screen_presenter.dart';
import 'package:rssms/views/request_screen_view.dart';

class RequestScreen extends StatefulWidget {
  const RequestScreen({Key? key}) : super(key: key);

  @override
  _RequestScreenState createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> with RequestScreenView {
  late RequestScreenPresenter _presenter;

  late RequestScreenModel _model;
  var scrollController = ScrollController();

  @override
  void initState() {
    Users user = Provider.of<Users>(context, listen: false);
    _presenter = RequestScreenPresenter();
    _presenter.view = this;
    _model = _presenter.model!;
    _presenter.loadStaffRequest(idToken: user.idToken!);
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        print(_model.hasMore!);
        if (_model.hasMore!) {
          _model.page = _model.page! + 1;
          _presenter.loadStaffRequest(idToken: user.idToken!);
        }
      }
    });
    super.initState();
  }

  List<Widget> mapInvoiceWidget(listRequest) => listRequest
      .map<RequestWidget>((e) => RequestWidget(
            request: e,
          ))
      .toList();

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

  Widget requestList() {
    return StreamBuilder(
      stream: _model.stream,
      builder: (context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Center(
              child: CustomText(
                  text: "Hiện vẫn chưa có yêu cầu",
                  color: CustomColor.black,
                  context: context,
                  fontSize: 16),
            ),
          );
        } else {
          return Flexible(
            child: ListView.separated(
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              controller: scrollController,
              separatorBuilder: (context, index) {
                return CustomSizedBox(
                  context: context,
                  height: 0,
                );
              },
              itemCount: snapshot.data!.length + 1,
              itemBuilder: (context, index) {
                if (index < snapshot.data.length) {
                  return RequestWidget(
                    request: snapshot.data[index],
                  );
                } else if (_model.hasMore!) {
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
                          text: "Đã hết yêu cầu!",
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
  Future<void> refresh() {
    Users user = Provider.of<Users>(context, listen: false);
    _presenter.loadStaffRequest(idToken: user.idToken, clearCachedDate: true);
    return Future.value();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: refresh,
      child: SizedBox(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [requestList()],
          ),
        ),
      ),
    );
  }
}
