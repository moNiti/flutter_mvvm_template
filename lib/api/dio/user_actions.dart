import 'package:template_app/api/dio/dio_service.dart';

class UserActions {
  static final UserActions _userActions = UserActions._internal();
  factory UserActions() => _userActions;
  UserActions._internal();

  Future<void> getUser() async {
    final response = await DIOService().dio.get("/getMe");

    /*
    return User.fromJson(response.data)
     */
  }
}
