import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rssms/common/custom_app_bar.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/custom_text.dart';
import 'package:rssms/models/detail_area_screen_model.dart';
import 'package:rssms/models/entity/user.dart';
import 'package:rssms/pages/office_staff/detail_area_screen/widgets/space_widget.dart';
import 'package:rssms/presenters/detail_area_screen_presenter.dart';
import 'package:rssms/views/detail_area_screen_view.dart';

class DetailAreaScreen extends StatefulWidget {
  final String idArea;
  const DetailAreaScreen({Key? key, required this.idArea}) : super(key: key);

  @override
  State<DetailAreaScreen> createState() => _DetailAreaScreenState();
}

class _DetailAreaScreenState extends State<DetailAreaScreen>
    implements DetailAreaScreenView {
  late DetailAreaScreenModel _model;
  late DetailAreaScreenPresenter _presenter;

  @override
  void initState() {
    _presenter = DetailAreaScreenPresenter();
    _model = _presenter.model;
    _presenter.view = this;
    Users users = Provider.of<Users>(context, listen: false);
    _presenter.getListSpace(users.idToken!, widget.idArea);
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
          : Container(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  CustomSizedBox(
                    context: context,
                    height: 32,
                  ),
                  const CustomAppBar(
                      isHome: false, name: 'Trang danh sách không gian'),
                  Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: _model.listSpace.length,
                        itemBuilder: (_, index) {
                          return SpaceWidget(space: _model.listSpace[index]);
                        }),
                  )
                ],
              ),
            ),
    );
  }
}
