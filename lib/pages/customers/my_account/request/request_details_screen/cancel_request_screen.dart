import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/custom_text.dart';
import 'package:rssms/models/entity/order_detail.dart';
import 'package:rssms/models/entity/request.dart';
import 'package:rssms/models/entity/user.dart';
import 'package:rssms/models/extend_request_model.dart';
import 'package:rssms/presenters/extend_request_presenter.dart';
import 'package:rssms/views/extend_request_view.dart';

class CancelledRequestScreen extends StatefulWidget {
  final Request request;

  const CancelledRequestScreen({Key? key, required this.request})
      : super(key: key);

  @override
  State<CancelledRequestScreen> createState() => _CancelledRequestScreenState();
}

class _CancelledRequestScreenState extends State<CancelledRequestScreen>
    implements ExtendRequestView {
  ExtendRequestPresenter? _presenter;
  ExtendRequestModel? _model;
  List<OrderDetail>? listProduct;
  TextEditingController? noteController;
  @override
  void onPressCancel() {}

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
  }

  @override
  void setChangeView() {
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
    noteController = TextEditingController(text: _model?.request?.note ?? "");
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
                      text: "Chi ti???t ????n h???y",
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                                text: "H???y b???i:",
                                color: Colors.black,
                                context: context,
                                fontWeight: FontWeight.bold,
                                fontSize: 17),
                            CustomText(
                                text: _model!.request!.customerName,
                                color: Colors.black,
                                context: context,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ],
                        ),
                        CustomSizedBox(
                          context: context,
                          height: 24,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                                text: "H???y v??o l??c:",
                                color: Colors.black,
                                context: context,
                                fontWeight: FontWeight.bold,
                                fontSize: 17),
                            CustomText(
                                text: "2022-02-08 15:30",
                                color: Colors.black,
                                context: context,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ],
                        ),
                        CustomSizedBox(
                          context: context,
                          height: 24,
                        ),
                        Column(
                          children: [
                            CustomText(
                                text: "L?? do h???y:",
                                color: Colors.black,
                                context: context,
                                fontWeight: FontWeight.bold,
                                fontSize: 17),
                            CustomSizedBox(
                              context: context,
                              height: 16,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(
                                      color: CustomColor.black[3]!, width: 1)),
                              child: TextFormField(
                                minLines: 6,
                                enabled: false,
                                controller: noteController,
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                              ),
                            ),
                          ],
                        ),
                        CustomSizedBox(
                          context: context,
                          height: 24,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                                text: "S??? ti???n ho??n l???i:",
                                color: Colors.black,
                                context: context,
                                fontWeight: FontWeight.bold,
                                fontSize: 17),
                            CustomText(
                                text: _model!.request!.totalPrice.toString(),
                                color: Colors.black,
                                context: context,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
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
