import 'dart:convert';

import 'package:http/http.dart';
import 'package:news_app1/data/model/ArticleResponse.dart';
import 'package:news_app1/data/model/SourcesResponse.dart';

abstract class ApiManager{
  static const String baseUrl = "newsapi.org";
  static const String apiKey = "71cf061fd71f49e3bc43f004e2bf1624";
  static const String getSourcesEndPoint = "v2/top-headlines/sources";
  static const String getArticleEndPoint = "/v2/everything";

  static Future<List<Source>> getSources(String category) async {
    Uri url = Uri.parse(
        "https://$baseUrl/$getSourcesEndPoint?apiKey=$apiKey&category=$category");
    Response response = await get(url);
    Map json =
        jsonDecode(response.body); // converting a string contains map into map
    SourcesResponse sourcesResponse = SourcesResponse.fromJson(
        json); //taking the map from api and convert it to an object from class source response to work with it.
    if (response.statusCode >= 200 &&
        response.statusCode < 300 &&
        sourcesResponse.sources?.isNotEmpty == true) {
      return sourcesResponse.sources!;
    }
    throw Exception(sourcesResponse.message);
  }

  static Future<List<Article>> getArticles(String sourceId) async {
    Uri url = Uri.https(
        baseUrl, getArticleEndPoint, {"apiKey": apiKey, "sources": sourceId});
    var serverResponse = await get(url);
    Map json = jsonDecode(serverResponse.body);
    ArticleResponse articleResponse = ArticleResponse.fromJson(json);
    if (serverResponse.statusCode >= 200 &&
        serverResponse.statusCode < 300 &&
        articleResponse.articles?.isNotEmpty == true) {
      return articleResponse.articles!;
    }
    throw Exception("Something went wrong please try again later!");
  }
}
