import 'package:flutter/material.dart';
import 'package:fresh_graphql/fresh_graphql.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'package:template_app/config/config.dart';

import 'gql_link.dart';

class GQLService {
  // SINGLETON CLASS
  static final GQLService _gqlService = GQLService._internal();
  factory GQLService() {
    return _gqlService;
  }
  static GQLService get instance => _gqlService;

  // Constructor
  GQLService._internal() {
    _httpLink = HttpLink(
      "${Config.baseUrl}/graphql",
    );
    _freshLink = GqlLink().freshLink;
    _errorLink = GqlLink().errorLink;
    _link = Link.from([_errorLink, _freshLink, _httpLink]);

    _client = ValueNotifier(GraphQLClient(
      cache: GraphQLCache(),
      link: _link,
      defaultPolicies: DefaultPolicies(
        watchQuery: policies,
        query: policies,
      ),
    ));
  }

  // VARIABLES
  late HttpLink _httpLink;
  late FreshLink _freshLink;
  late ErrorLink _errorLink;
  late Link _link;
  late ValueNotifier<GraphQLClient> _client;

  Future<void> setToken(String? token) async {
    await _freshLink.setToken(token);
  }

  Future<void> removeToken() async {
    await _freshLink.clearToken();
  }

  static final Policies policies = Policies(
    fetch: FetchPolicy.noCache,
  );

  GraphQLClient get clientToQuery => _client.value;

  ValueNotifier<GraphQLClient> get client => _client;
}
