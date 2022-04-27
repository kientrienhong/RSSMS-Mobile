import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rssms/common/custom_button.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/custom_snack_bar.dart';
import 'package:rssms/common/custom_text.dart';
import 'package:rssms/common/import_export_details.dart';
import 'package:rssms/common/import_export_info.dart';
import 'package:rssms/common/import_export_license.dart';
import 'package:rssms/models/entity/account.dart';
import 'package:rssms/models/entity/import.dart';
import 'package:rssms/models/entity/order_detail.dart';
import 'package:rssms/models/entity/placing_items.dart';
import 'package:rssms/models/entity/user.dart';
import 'package:rssms/models/import_screen_model.dart';
import 'package:rssms/presenters/import_screen_presenter.dart';
import 'package:rssms/views/import_screen_view.dart';

class ImportScreen extends StatefulWidget {
  final Import import;
  final List<OrderDetail> orderDetail;
  final Account deliveryStaff;
  const ImportScreen(
      {Key? key,
      required this.deliveryStaff,
      required this.import,
      required this.orderDetail})
      : super(key: key);

  @override
  State<ImportScreen> createState() => _ImportScreenState();
}

class _ImportScreenState extends State<ImportScreen>
    implements ImportScreenView {
  late ImportScreenPresenter _presenter;
  late ImportScreenModel _model;

  @override
  void initState() {
    _presenter = ImportScreenPresenter();
    _model = _presenter.model;
    _presenter.view = this;

    super.initState();
  }

  void onClickAcceptImport() async {
    final placingItems = Provider.of<PlacingItems>(context, listen: false);
    final user = Provider.of<Users>(context, listen: false);
    bool result = true;
    result = await _presenter.onPressConfirmStore(
        user.idToken!, placingItems, widget.deliveryStaff.id);
    if (result) {
      Navigator.pop(context, result);
      CustomSnackBar.buildSnackbar(
          context: context,
          message: 'Thao tác thành công',
          color: CustomColor.green);
      placingItems.emptyPlacing();
    }
  }

  @override
  void updateError(String message) {
    setState(() {
      _model.errorMessage = message;
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
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ImportExportInfo(
                  isView: false,
                  import: widget.import,
                  backButton: false,
                  isExport: false,
                ),
                CustomSizedBox(
                  context: context,
                  height: 16,
                ),
                const SizedBox(
                  height: 0,
                  child: Divider(
                    color: CustomColor.black,
                    thickness: 1,
                  ),
                ),
                const SizedBox(
                  height: 5,
                  child: Divider(
                    color: CustomColor.black,
                    thickness: 0.5,
                  ),
                ),
                ImportExportDetails(orderDetail: widget.orderDetail),
                CustomSizedBox(
                  context: context,
                  height: 16,
                ),
                const ImportExportLicense(),
                CustomSizedBox(
                  context: context,
                  height: 16,
                ),
                if (_model.errorMessage.isNotEmpty)
                  Center(
                    child: CustomText(
                        text: _model.errorMessage,
                        color: CustomColor.red,
                        fontWeight: FontWeight.bold,
                        context: context,
                        fontSize: 14),
                  ),
                CustomSizedBox(
                  context: context,
                  height: 16,
                ),
                Center(
                  child: CustomButton(
                      height: 24,
                      text: 'Chấp nhận',
                      width: deviceSize.width / 2 - 40,
                      onPressFunction: onClickAcceptImport,
                      isLoading: _model.isLoading,
                      textColor: CustomColor.white,
                      buttonColor: CustomColor.blue,
                      borderRadius: 4),
                ),
              ],
            )),
      ),
    );
  }
}
