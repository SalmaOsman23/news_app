import 'package:flutter/material.dart';
import 'package:news_app1/data/api/api_manager.dart';
import 'package:news_app1/data/model/ArticleResponse.dart';
import 'package:news_app1/ui/widgets/article_widget/build_article_widget.dart';
import 'package:news_app1/ui/widgets/error_view/error_view_widget.dart';
import 'package:news_app1/ui/widgets/loading_widget/loader.dart';

class NewsArticleList extends StatelessWidget {
  final String sourceId;

  const NewsArticleList({super.key, required this.sourceId});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: ApiManager.getArticles(sourceId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return buildArticlesList(snapshot.data!);
          } else if (snapshot.hasError) {
            return ErrorViewWidget(message: snapshot.error.toString());
          } else {
            return Loader();
          }
        });
  }

  Widget buildArticlesList(List<Article> articles) {
    return ListView.builder(
        itemCount: articles.length,
        itemBuilder: (context, index) {
          return BuildArticleWidget(article: articles[index]);
        });
  }
}
