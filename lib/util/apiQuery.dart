import 'package:graphql_flutter/graphql_flutter.dart';
import '../data/models/todo.dart';
import '../util/mixin/dateTimeMixin.dart';
import '../data/models/user.dart';
import '../util/enums/priority.dart';

class ApiQuery with DateTimeMixin {
  GraphQLClient _client;
  SocketClient _subscriptionClient;

  ApiQuery()
      : _client = GraphQLClient(
          cache: InMemoryCache(),
          link: HttpLink(
            uri: 'https://todoapi.hasura.app/v1/graphql',
          ),
        ),
  _subscriptionClient = SocketClient('ws://todoapi.hasura.app/v1/graphql');

  Future<QueryResult> _query(String query) async =>
      await _client.query(QueryOptions(
        documentNode: gql(query),
      ));

  Future<QueryResult> _mutate(String query) async =>
      await _client.mutate(MutationOptions(
        documentNode: gql(query),
      ));

  Stream<SubscriptionData> _subscribe(String query) =>
      _subscriptionClient.subscribe(SubscriptionRequest(Operation(documentNode:gql(query))),true);

  Future<QueryResult> createUser(User user) {
    return _mutate('''
        mutation createAccount {
          insert_users(objects: {full_name: "${user.fullName}",email: "${user.email}",
            user_name: "${user.userName}",password: "${user.passWord}"}) {
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

  Future<QueryResult> getTodoForUser(int userId, String date) {
    return _query('''
      query MyQuery {
        todos(where: {_and: {user_id: {_eq: $userId}, date: {_eq: "$date"}}}) {
          id
          title
          date
          start_time
          end_time
          priority
          is_completed
        }
      }
    ''');
  }

  Future<QueryResult> addTodo(Todo todo) {
    return _mutate('''
      mutation addTodo {
        insert_todos_one(object: {title: "${todo.title}", date: "${getDateString(todo.date)}",
         start_time: "${getTimeString(todo.startTime)}", end_time: "${getTimeString(todo.endTime)}",
         priority: "${todo.priority.getString()}", user_id: ${todo.userId}}) {
          id
        }
       }
    ''');
  }

  Future<QueryResult> updateTodo(Todo todo) {
    return _mutate('''
      mutation updateTodo {
        update_todos_by_pk(pk_columns: {id: ${todo.id}}, _set: {date: "${getDateString(todo.date)}",
         end_time: "${getTimeString(todo.endTime)}", start_time: "${getTimeString(todo.startTime)}",
          title: "${todo.title}", priority: "${todo.priority.getString()}"}) {
            id
      }
    }
  ''');
  }

  Future<QueryResult> markAsCompletedTodo(Todo todo) {
    return _mutate('''
      mutation updateTodo {
        update_todos_by_pk(pk_columns: {id: ${todo.id}}, _set: {is_completed: ${todo.isCompleted}}) {
          id
      }
    }
  ''');
  }

  Stream<SubscriptionData> subscribeTodoForUser(int userId, String date) {
    return _subscribe('''
      subscription MyQuery {
        todos(where: {_and: {user_id: {_eq: $userId}, date: {_eq: "$date"}}}) {
          id
          title
          date
          start_time
          end_time
          priority
          is_completed
        }
      }
    ''');
  }
}
