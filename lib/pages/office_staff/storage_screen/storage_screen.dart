import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/custom_text.dart';
import 'package:rssms/common/store_items_button.dart';
import 'package:rssms/models/entity/user.dart';
import 'package:rssms/models/storage_screen_model.dart';
import 'package:rssms/pages/office_staff/storage_screen/widgets/area_widget.dart';
import 'package:rssms/presenters/storage_screen_presenter.dart';
import 'package:rssms/views/storage_screen_view.dart';

class StorageScreen extends StatefulWidget {
  const StorageScreen({Key? key}) : super(key: key);

  @override
  State<StorageScreen> createState() => _StorageScreenState();
}

class _StorageScreenState extends State<StorageScreen>
    implements StorageScreenView {
  late StorageScreenModel _model;
  late StorageScreenPresenter _presenter;

  @override
  void initState() {
    Users users = Provider.of<Users>(context, listen: false);

    _presenter = StorageScreenPresenter();
    _presenter.view = this;
    _model = _presenter.model;
    _presenter.getListAreas(users.idToken!, users.storageId!);
    super.initState();
  }

  @override
  void updateErrorMsg(String error) {
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
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

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
          : Column(
              children: [
                CustomSizedBox(
                  context: context,
                  height: 48,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(
                      text: 'Trang danh sách khu vực ',
                      color: CustomColor.black,
                      context: context,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    CustomSizedBox(
                      context: context,
                      height: 8,
                    ),
                    const StoreItemsButton()
                  ],
                ),
                CustomSizedBox(
                  context: context,
                  height: 16,
                ),
                Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      itemCount: _model.listArea.length,
                      itemBuilder: (_, index) {
                        return AreaWidget(area: _model.listArea[index]);
                      }),
                )
              ],
            ),
    );
  }
}
