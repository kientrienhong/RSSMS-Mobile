import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rssms/common/custom_app_bar.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/timeline.dart';
import 'package:rssms/models/entity/user.dart';
import 'package:rssms/models/timeline_model.dart';
import 'package:rssms/presenters/timeline_presenter.dart';
import 'package:rssms/views/timeline_view.dart';

class TimeLineScreen extends StatefulWidget {
  String invoiceId;
  TimeLineScreen({Key? key, required this.invoiceId}) : super(key: key);

  @override
  State<TimeLineScreen> createState() => _TimeLineScreenState();
}

class _TimeLineScreenState extends State<TimeLineScreen>
    implements TimelineView {
  late TimelinePresenter _presenter;
  late TimelineModel _model;

  @override
  void initState() {
    _presenter = TimelinePresenter();
    _model = _presenter.model;
    _presenter.view = this;
    Users users = Provider.of<Users>(context, listen: false);

    _presenter.getListTimeline(users.idToken!, widget.invoiceId);
    super.initState();
  }

  @override
  void updateView(TimelineModel model) {
    setState(() {
      _model = model;
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
            : Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
                child: SingleChildScrollView(
                  child: Column(children: [
                    const CustomAppBar(
                        isHome: false, name: 'Thông tin vận chuyển'),
                    TimeLine(listTimeLine: _model.listTimeline)
                  ]),
                ),
              ));
  }
}
