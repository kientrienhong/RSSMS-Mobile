import 'package:rssms/models/dialog_add_cost_model.dart';
import 'package:rssms/views/dialog%20_add_cost_view.dart';

class DialogAddCostPresenter {
  late DialogAddCostModel model;
  late DialogAddCostView view;
  DialogAddCostPresenter(Map<String, dynamic>? additionCost) {
    model = DialogAddCostModel(additionCost);
  }
}
