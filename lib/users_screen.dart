import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class UsersScreen extends StatelessWidget {
  // Define a GraphQL query
  final String fetchUsersQuery = """
    query {
      users {
        id
        username
        email
        role
      }
    }
  """;


final String addUserMutation = """
  mutation AddUser(\$name: String!, \$email: String!) {
    addUser(name: \$name, email: \$email) {
      id
      name
      email
    }
  }
""";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GraphQL Users'),
      ),
      body: Query(
        options: QueryOptions(
          document: gql(fetchUsersQuery),
        ),
        builder: (QueryResult result, {VoidCallback? refetch, FetchMore? fetchMore}) {
          if (result.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (result.hasException) {
            return Center(child: Text(result.exception.toString()));
          }

          final List users = result.data?['users'];

          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              return ListTile(
                title: Text(user['username']),
                subtitle: Text(user['email']),
                trailing: Text(user['role']),
              );
            },
          );
        },
      ),
    );
  }

Widget build2(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GraphQL Users update'),
      ),
      body:Mutation(
  options: MutationOptions(
    document: gql(addUserMutation),
  ),
  builder: (RunMutation runMutation, QueryResult? result) {
    return Column(
      children: [
        TextField(
          onChanged: (value) {
            // Store the value
          },
          decoration: InputDecoration(labelText: 'Name'),
        ),
        TextField(
          onChanged: (value) {
            // Store the value
          },
          decoration: InputDecoration(labelText: 'Email'),
        ),
        ElevatedButton(
          onPressed: () {
            runMutation({
              'name': 'John Doe',
              'email': 'john.doe@example.com',
            });
          },
          child: Text('Add User'),
        ),
      ],
    );
  },
)
    );
}


}
