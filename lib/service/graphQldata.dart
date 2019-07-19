import 'dart:io';
import 'package:args/args.dart';
import 'package:graphql/client.dart';
import '../config/graphqlRepositories.dart';
import '../config/service_url.dart';
import '../config/local.dart';
// to run the example, create a file ../local.dart with the content:
// const String YOUR_PERSONAL_ACCESS_TOKEN =
//    '<YOUR_PERSONAL_ACCESS_TOKEN>';


ArgResults argResults;

// client - create a graphql client
GraphQLClient client() {
  final HttpLink _httpLink = HttpLink(
    uri: servicePath['getPageContentGraphUrl'],
  );

  final AuthLink _authLink = AuthLink(
    getToken: () async => 'Bearer $YOUR_PERSONAL_ACCESS_TOKEN',
  );

  final Link _link = _authLink.concat(_httpLink as Link);//暂时不用token
  return GraphQLClient(
    cache: InMemoryCache(),
    link: _link,
  );
}

// query example - fetch all your github repositories
Future queryCategory() async {
  final GraphQLClient _client = client();

  const String nRepositories = '5d2857cb045aed52137c2e78';

  final QueryOptions options = QueryOptions(
    document: readRepositories,
    variables: <String, dynamic>{
      'nRepositories': nRepositories,
    },
  );

  final QueryResult result = await _client.query(options);

  if (result.hasErrors) {
    stderr.writeln(result.errors);
    exit(2);
  }
  return result.data;
  /*final List<dynamic> repositories =
  result.data['post']['content']['category']['categoryList']['data'] as List<dynamic>;

  repositories.forEach(
          (dynamic f) => {stdout.writeln('mallCategoryId: ${f['mallCategoryId']} mallCategoryName: ${f['mallCategoryName']}')});

  exit(0);*/
}