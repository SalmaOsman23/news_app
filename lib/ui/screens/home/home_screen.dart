import 'package:flutter/material.dart';
import 'package:news_app1/data/api/api_manager.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "Home Screen";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    ApiManager.getSources();
    return Scaffold(
      appBar: AppBar(
        title: Text("News App"),
      ),
    );
  }
}
