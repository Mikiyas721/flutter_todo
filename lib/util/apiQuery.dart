import 'package:graphql_flutter/graphql_flutter.dart';
import '../data/models/user.dart';

class ApiQuery {
  GraphQLClient _client;

  ApiQuery()
      : _client = GraphQLClient(
          cache: InMemoryCache(),
          link: HttpLink(
            uri: 'https://todoapi.hasura.app/v1/graphql',
          ),
        );

  Future<QueryResult> _query(String query) async =>
      await _client.query(QueryOptions(
        documentNode: gql(query),
      ));

  Future<QueryResult> _mutate(String query) async =>
      await _client.mutate(MutationOptions(
        documentNode: gql(query),
      ));

  Future<QueryResult> createUser(User user) {
    return _mutate('''
        mutation createAccount {
          insert_users(objects: {full_name: "${user.fullName}",email: "${user.email}",user_name: "${user.userName}",password: "${user.passWord}"}) {
            affected_rows
            returning {
              id
              created_at
            }
          }
        }
        ''');
  }

  Future<QueryResult> checkUser(User user) {
    return _query('''
      query checkUser{
        users(where: {_and: {user_name: {_eq: "${user.userName}"}, password: {_eq: "${user.passWord}"}}}) {
          id
          created_at
        }
      }
      ''');
  }

  Future<QueryResult> getTodoForUser(int userId,String date) {
    return _query('''
      query MyQuery {
        todos(where: {_and: {user_id: {_eq: $userId}, date: {_eq: "$date"}}}) {
          id
          title
          date
          start_time
          end_time
          priority
        }
      }
    ''');
  }
}
