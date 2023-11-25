import 'package:flutter/material.dart';
import 'package:projeto_escribo/routes/app_routes.dart';
import 'package:projeto_escribo/screens/home_screen.dart';
import 'package:projeto_escribo/store/bookmarks.store.dart';
import 'package:projeto_escribo/theme/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final preferences = await SharedPreferences.getInstance();
  runApp(MyApp(preferences));
}

class MyApp extends StatelessWidget {
  final SharedPreferences preferences;

  const MyApp(this.preferences, {super.key});

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => BookmarksStore(preferences),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Projeto Escribo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
          useMaterial3: true,
          fontFamily: 'Basic',
        ),
        routes: {
          AppRoutes.home: (ctx) => const HomeScreen(),
        },
      ),
    );
  }
}
