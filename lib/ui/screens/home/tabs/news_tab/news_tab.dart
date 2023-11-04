import 'package:flutter/material.dart';
import 'package:news_app1/data/api/api_manager.dart';
import 'package:news_app1/data/model/CategoryDM.dart';
import 'package:news_app1/data/model/SourcesResponse.dart';
import 'package:news_app1/providers/my_provider.dart';
import 'package:news_app1/ui/screens/home/tabs/news_tab/newsArticleList.dart';
import 'package:provider/provider.dart';

class NewsTab extends StatefulWidget {
  @override
  State<NewsTab> createState() => _NewsTabState();
  late String categoryId;

  NewsTab(this.categoryId);
}

class _NewsTabState extends State<NewsTab> {
  int currentTabIndex = 0;
  late MyProvider provider;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of(context);
    return FutureBuilder(
        future: ApiManager.getSources(widget.categoryId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return buildTabs(snapshot.data!);
          } else if (snapshot.hasError) {
            return AlertDialog(
              title: Text("Error!"),
              content: Text(snapshot.error.toString()),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Something went wrong, Try again later"))
              ],
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  Widget buildTabs(List<Source> list) {
    return DefaultTabController(
      length: list.length,
      child: Column(
        children: [
          SizedBox(
            height: 8,
          ),
          TabBar(
              isScrollable: true,
              indicatorColor: provider.isDarkMode()
                  ? Colors.transparent
                  : Colors.transparent,
              onTap: (index) {
                currentTabIndex = index;
                setState(() {});
              },
              tabs: list
                  .map((source) => buildTabWidget(source.name ?? "",
                      currentTabIndex == list.indexOf(source)))
                  .toList()),
          Expanded(
              child: TabBarView(
                  children: list
                      .map((source) => NewsArticleList(sourceId: source.id!))
                      .toList()))
        ],
      ),
    );
  }

  Widget buildTabWidget(String name, bool isSelected) {
    return Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: isSelected ? Colors.green : Colors.white,
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: Colors.green)),
        child: Text(
          name,
          style: TextStyle(color: isSelected ? Colors.white : Colors.green),
        ));
  }
}
