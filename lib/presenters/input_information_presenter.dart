import 'package:rssms/models/entity/user.dart';
import 'package:rssms/models/input_information_model.dart';
import 'package:rssms/views/input_information_view.dart';

class InputInformationPresenter {
  InputInformationModel? model;
  InputInformationView? view;

  InputInformationPresenter(Users user) {
    model = InputInformationModel(user);
  }
}
