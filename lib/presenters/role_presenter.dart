import 'dart:convert';

import 'package:rssms/models/entity/role.dart';
import 'package:rssms/models/role_model.dart';
import 'package:rssms/views/role_view.dart';

class RolePresenter {
  RoleModel? model;
  RoleView? view;

  RolePresenter() {
    model = RoleModel();
  }

  Future<void> loadListRole() async {
    try {
      final response = await model?.loadListRole();
      List<Role> listRole;
      if (response.statusCode == 200) {
        final decodedReponse = jsonDecode(response.body);
        if (decodedReponse['data'].isNotEmpty) {
          listRole = decodedReponse['data']!
              .map<Role>((e) => Role.fromMap(e))
              .toList();
          model!.role =
              listRole.firstWhere((element) => element.name == "Customer");
        }
      } else {
        throw Exception();
      }
    } catch (e) {
      print(e);
    }
  }
}