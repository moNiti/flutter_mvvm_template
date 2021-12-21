import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:template_app/pages/home/home_screen.dart';

import 'api/gql/gql_service.dart';

void main() {
  runApp(_buildRootWidget());
}

Widget _buildRootWidget() {
  GQLService gqlService = GQLService();

  return GraphQLProvider(
    client: gqlService.client,
    child: const CacheProvider(child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}
