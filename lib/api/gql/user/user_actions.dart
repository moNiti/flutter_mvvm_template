import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:template_app/api/gql/gql_service.dart';
import 'package:template_app/api/gql/user/schema/user_schma.dart';

class UserActions {
  static final UserActions _userActions = UserActions._internal();
  factory UserActions() => _userActions;
  UserActions._internal();

  Future<void> getUser() async {
    final response = await GQLService().clientToQuery.query(
          QueryOptions(
            document: gql(queryUserMe),
            // variables: IF NEED ?
          ),
        );
/*
  if(response.data != null) {
    return User.fromJson(response.data['me'])/
  }  
*/
  }
}
