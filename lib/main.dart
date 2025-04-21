import 'package:clean_architecture/injection/injection.dart';
import 'package:clean_architecture/routes/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:realm/realm.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Realm
  Realm(config);

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goRouter = ref.watch(goRouterProvider);

    return MaterialApp.router(
      routerConfig: goRouter,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Posts App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
