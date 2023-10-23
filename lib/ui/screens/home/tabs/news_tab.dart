import 'package:flutter/material.dart';
import 'package:news_app1/data/api/api_manager.dart';
import 'package:news_app1/data/model/SourcesResponse.dart';

class NewsTab extends StatefulWidget {
  @override
  State<NewsTab> createState() => _NewsTabState();
}

class _NewsTabState extends State<NewsTab> {
  int currentTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: ApiManager.getSources(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return buildTabs(snapshot.data!);
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
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
          SizedBox(height: 8,),
          TabBar(isScrollable: true,
              indicatorColor: Colors.transparent,
              onTap: (index){
            currentTabIndex = index;
            setState(() {});
              },
              tabs: list.map((source) => buildTabWidget(source.name??"",
                currentTabIndex == list.indexOf(source)
              )).toList()),
          Expanded(child: TabBarView(children: list.map((source) => Container(color: Colors.cyan,)).toList()))
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
        border: Border.all(color: Colors.green)
      ),
        child: Text(name,style: TextStyle(color: isSelected ? Colors.white : Colors.green),));
  }
}
