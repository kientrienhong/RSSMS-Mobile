import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rssms/common/custom_app_bar.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/models/choice_storage_screen_model.dart';
import 'package:rssms/models/entity/order_booking.dart';
import 'package:rssms/models/entity/user.dart';
import 'package:rssms/pages/customers/choice_storage/widgets/storage_choice.dart';
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
          : Container(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  CustomSizedBox(
                    context: context,
                    height: 16,
                  ),
                  const CustomAppBar(
                    isHome: false,
                    name: 'Trang chọn kho',
                  ),
                  CustomSizedBox(
                    context: context,
                    height: 8,
                  ),
                  GridView.builder(
                    padding: const EdgeInsets.all(0),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.6,
                      crossAxisSpacing: 16.0,
                    ),
                    itemBuilder: (ctx, i) {
                      return StorageChoiceWidget(
                          storageEntity: _model.listStorage[i],
                          currentIdStorage: _model.indexIdStorage,
                          onChoice: chooseIndex);
                    },
                    itemCount: _model.listStorage.length,
                  ),
                ],
              ),
            ),
    );
  }
}
