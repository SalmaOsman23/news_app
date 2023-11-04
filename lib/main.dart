import 'package:flutter/material.dart';
import 'package:news_app1/preference/my_preference.dart';
import 'package:news_app1/providers/my_provider.dart';
import 'package:news_app1/ui/screens/home/home_screen.dart';
import 'package:news_app1/ui/screens/home/tabs/news_tab/article_details.dart';
import 'package:news_app1/ui/utilits/app_theme.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MyPreference.pref = await SharedPreferences.getInstance();
  runApp(ChangeNotifierProvider(
      create: (context) => MyProvider(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  late MyProvider provider;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    provider = Provider.of<MyProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        HomeScreen.routeName: (_) => HomeScreen(),
        ArticleDetails.routeName: (_) => ArticleDetails()
      },
      initialRoute: HomeScreen.routeName,
      themeMode: provider.currentTheme,
      theme: AppTheme.lighTheme,
      darkTheme: AppTheme.darkTheme,
    );
  }
}

