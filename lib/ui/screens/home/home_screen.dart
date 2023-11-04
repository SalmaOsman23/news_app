import 'package:flutter/material.dart';
import 'package:news_app1/data/api/api_manager.dart';
import 'package:news_app1/data/model/CategoryDM.dart';
import 'package:news_app1/providers/my_provider.dart';
import 'package:news_app1/ui/screens/home/tabs/categories/categories_tab.dart';
import 'package:news_app1/ui/screens/home/tabs/news_tab/news_tab.dart';
import 'package:news_app1/ui/screens/home/tabs/settings/settings_tab.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "Home Screen";

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Widget currentTab;
  late final CategoriesTab categoriesTab;
  late MyProvider provider;

  @override
  void initState() {
    super.initState();
    categoriesTab = CategoriesTab(onCategoryClick);
    currentTab = categoriesTab;
  }

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<MyProvider>(context);
    return SafeArea(
      //to make the application under the notification bar
      child: WillPopScope(
        onWillPop: () {
          if (currentTab != categoriesTab) {
            currentTab = CategoriesTab(onCategoryClick);
            setState(() {});
            return Future.value(false);
          } else {
            return Future.value(true);
          }
        },
        child: Stack(children: [
          if (provider.isDarkMode())
            Image.asset(
              "assets/images/dark background.png",
              fit: BoxFit.fill,
              width: double.infinity,
            )
          else
            Image.asset(
              "assets/images/light background.png",
              fit: BoxFit.fill,
              width: double.infinity,
            ),
          Scaffold(
            appBar: AppBar(
              title: const Text("News App"),
              centerTitle: true,
              backgroundColor: provider.appBarColor,
              shape: const RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(22))),
            ),
            drawer: buildDrawer(),
            body: currentTab,
          ),
        ]),
      ),
    );
  }

  onCategoryClick(CategoryDM categoryDM) {
    //I want everytime i click on category this function to work
    currentTab = NewsTab(categoryDM.id);
    provider.changeTabColor(categoryDM.backgroundColor);
    setState(() {});
  }

  buildDrawer() => Drawer(
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DrawerHeader(
                decoration: BoxDecoration(
                    color: currentTab != categoriesTab
                        ? provider.appBarColor
                        : Colors.green),
                child: Center(
                  child: Text(
                    "News App",
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                )),
            buildDrawerRow(Icons.list, "Categories", () {
              currentTab = CategoriesTab(onCategoryClick);
              setState(() {});
              Navigator.pop(context);
            }),
            buildDrawerRow(Icons.settings, "Settings", () {
              currentTab = SettingsTab();
              setState(() {});
              Navigator.pop(context);
            })
          ],
        ),
      );

  buildDrawerRow(IconData icon, String title, void Function()? onClick) {
    return InkWell(
      onTap: onClick,
      child: Row(
        children: [
          const SizedBox(
            width: 16,
          ),
          Icon(
            icon,
            color: Colors.black,
            size: 35,
          ),
          const SizedBox(
            width: 16,
          ),
          Text(
            title,
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ],
      ),
    );
  }
}
