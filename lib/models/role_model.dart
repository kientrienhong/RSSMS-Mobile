import 'package:rssms/api/api_services.dart';
import 'package:rssms/models/entity/role.dart';

class RoleModel {
  Role? role;

  get getRole => role;

  set setRole(role) => role = role;

  Future<dynamic> loadListRole() async {
    return await ApiServices.loadListRole();
  }
}