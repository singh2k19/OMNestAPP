import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'graphql_config.dart';
import 'users_screen.dart';

void main() async {
  // Ensure all bindings are initialized before using async code
  WidgetsFlutterBinding.ensureInitialized();
  await initHiveForFlutter(); // Initialize Hive for offline caching
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: GraphQLConfig.initializeClient(),
      child: CacheProvider(
        child: MaterialApp(
          title: 'Flutter GraphQL Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: UsersScreen(),
        ),
      ),
    );
  }
}
