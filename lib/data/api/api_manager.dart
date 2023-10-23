import 'dart:convert';

import 'package:http/http.dart';
import 'package:news_app1/data/model/SourcesResponse.dart';

abstract class ApiManager{
  static const String baseUrl = "newsapi.org";
  static const String apiKey = "71cf061fd71f49e3bc43f004e2bf1624";
  static const String getSourcesEndPoint = "v2/top-headlines/sources";


  static Future<List<Source>> getSources() async{
    Uri url = Uri.parse("https://$baseUrl/$getSourcesEndPoint?apiKey=$apiKey");
    Response response = await get(url);
    Map json = jsonDecode(response.body); // converting a string contains map into map
    SourcesResponse sourcesResponse = SourcesResponse.fromJson(json); //taking the map from api and convert it to an object from class source response to work with it.
    if(response.statusCode >= 200 &&
        response.statusCode <300 &&
        sourcesResponse.sources?.isNotEmpty == true){
      return sourcesResponse.sources!;
    }
    throw Exception(sourcesResponse.message);
  }

  static getArticles(){

  }
}