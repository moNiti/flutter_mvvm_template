import 'package:stacked/stacked.dart';
import 'package:template_app/api/dio/user_actions.dart' as dio_user_action;
import 'package:template_app/api/gql/gql_link.dart';
import 'package:template_app/api/gql/user/user_actions.dart' as gql_user_action;
import 'package:template_app/extension/extension.dart';

class HomeViewModel extends BaseViewModel {
  final String submitButtonBusyKey = 'submit-button';

  Future<void> loadData() async {
    await runBusyFuture(futureStuff(), throwException: true);
  }

  Future<void> futureStuff() async {
    await 4.seconds;
    throw NotFoundException();
  }

  Future<bool> onButtonTap() async {
    await runBusyFuture(3.seconds, busyObject: submitButtonBusyKey);

    // DIO GET USER
    // await runBusyFuture(dio_user_action.UserActions().getUser());
    // GQL GET USER
    // await runBusyFuture(gql_user_action.UserActions().getUser());

    return true;
  }
}
