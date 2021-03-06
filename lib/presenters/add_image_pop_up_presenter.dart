import 'package:rssms/models/add_image_pop_up_model.dart';
import 'package:rssms/models/entity/imageEntity.dart';
import 'package:rssms/views/add_image_pop_up_view.dart';

class AddImagePopUpPresenter {
  late AddImagePopUpModel model;
  late AddImagePopUpView view;

  AddImagePopUpPresenter(ImageEntity? imageUpdate) {
    model = AddImagePopUpModel(imageUpdate);
  }
}
