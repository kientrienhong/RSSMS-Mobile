import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rssms/common/custom_app_bar.dart';
import 'package:rssms/common/custom_button.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/custom_text.dart';
import 'package:rssms/models/choice_storage_screen_model.dart';
import 'package:rssms/models/entity/order_booking.dart';
import 'package:rssms/models/entity/user.dart';
import 'package:rssms/pages/customers/choice_storage/widgets/storage_choice.dart';
import 'package:rssms/pages/customers/payment_method_booking/payment_method_booking_screen.dart';
import 'package:rssms/presenters/choice_storage_screen_presenter.dart';
import 'package:rssms/views/choice_storage_screen_view.dart';

class ChoiceStorageScreen extends StatefulWidget {
  const ChoiceStorageScreen({Key? key}) : super(key: key);

  @override
  State<ChoiceStorageScreen> createState() => _ChoiceStorageScreenState();
}

class _ChoiceStorageScreenState extends State<ChoiceStorageScreen>
    implements ChoiceStorageScreenView {
  late ChoiceStorageScreenPresenter _presenter;
  late ChoiceStorageScreenModel _model;

  @override
  void initState() {
    _presenter = ChoiceStorageScreenPresenter();
    _presenter.view = this;
    _model = _presenter.model;
    OrderBooking orderBooking =
        Provider.of<OrderBooking>(context, listen: false);
    Users user = Provider.of<Users>(context, listen: false);

    _presenter.getListStorage(orderBooking, user);
    super.initState();
  }

  @override
  void updateError(String error) {
    setState(() {
      _model.error = error;
    });
  }

  @override
  void updateLoading() {
    setState(() {
      _model.isLoading = !_model.isLoading;
    });
  }

  @override
  void chooseIndex(String? currentIdStorage) {
    setState(() {
      _model.indexIdStorage = currentIdStorage;
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
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
          : _model.listStorage.length > 0
              ? SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: [
                        CustomSizedBox(
                          context: context,
                          height: 16,
                        ),
                        const CustomAppBar(
                          isHome: false,
                          name: 'Trang ch???n kho',
                        ),
                        CustomSizedBox(
                          context: context,
                          height: 8,
                        ),
                        ListView.builder(
                          padding: const EdgeInsets.all(0),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (ctx, i) {
                            return StorageChoiceWidget(
                                storageEntity: _model.listStorage[i],
                                currentIdStorage: _model.indexIdStorage,
                                onChoice: chooseIndex);
                          },
                          itemCount: _model.listStorage.length,
                        ),
                        CustomSizedBox(
                          context: context,
                          height: 24,
                        ),
                        if (!_model.isChoose)
                          CustomText(
                              text: "Vui l??ng ch???n kho",
                              color: CustomColor.red,
                              context: context,
                              fontSize: 16),
                        CustomSizedBox(
                          context: context,
                          height: 24,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Center(
                            child: CustomButton(
                                height: 24,
                                text: 'Ti???p theo',
                                width: deviceSize.width * 1.2 / 3,
                                onPressFunction: () {
                                  if (_model.indexIdStorage != '') {
                                    setState(() {
                                      _model.isChoose = true;
                                    });
                                    OrderBooking orderBooking =
                                        Provider.of<OrderBooking>(context,
                                            listen: false);
                                    for (var element in _model.listStorage) {
                                      if (element.id == _model.indexIdStorage) {
                                        orderBooking.storageId =
                                            _model.indexIdStorage!;
                                        if (!orderBooking.isCustomerDelivery) {
                                          orderBooking.deliveryFee =
                                              element.deliveryFee;
                                          orderBooking.distants =
                                              element.deliveryDistance;
                                        }
                                      }
                                    }

                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const PaymentMethodBookingScreen()));
                                  } else {
                                    setState(() {
                                      _model.isChoose = false;
                                    });
                                  }
                                },
                                isLoading: false,
                                textColor: CustomColor.white,
                                buttonColor: CustomColor.blue,
                                borderRadius: 6),
                          ),
                        ),
                        CustomSizedBox(
                          context: context,
                          height: 24,
                        ),
                      ],
                    ),
                  ),
                )
              : Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Column(children: [
                    const CustomAppBar(
                      isHome: false,
                      name: '',
                    ),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("assets/images/busy.png",
                              width: deviceSize.height / 11 + 20,
                              color: Colors.grey),
                          CustomText(
                              textAlign: TextAlign.center,
                              text: "Hi???n t???t c??? c??c kho ?????u ??ang b???n",
                              color: Colors.grey,
                              context: context,
                              maxLines: 2,
                              fontSize: 16),
                          CustomText(
                              textAlign: TextAlign.center,
                              text:
                                  "Qu?? kh??ch vui l??ng ch???n khung gi??? kh??c ho???c ng??y kh??c",
                              color: Colors.grey,
                              context: context,
                              maxLines: 2,
                              fontSize: 16),
                        ],
                      ),
                    )
                  ]),
                ),
    );
  }
}
