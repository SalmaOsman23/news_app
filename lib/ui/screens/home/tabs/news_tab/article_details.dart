import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app1/providers/my_provider.dart';
import 'package:provider/provider.dart';

import '../../../../../data/model/ArticleResponse.dart';
import '../../../../widgets/loading_widget/loader.dart';

class ArticleDetails extends StatelessWidget {
  static const String routeName = "Details Screen";
  late MyProvider provider;

  ArticleDetails({super.key});

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<MyProvider>(context);
    var args = ModalRoute.of(context)?.settings.arguments as Article;
    return Scaffold(
      appBar: AppBar(
        title: Text(args.title ?? ""),
        centerTitle: true,
        backgroundColor: provider.appBarColor,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(22))),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: args.urlToImage ?? "",
                placeholder: (_, __) => Loader(),
                errorWidget: (_, __, ___) => Image.asset(
                  "assets/images/news.jpg",
                  height: MediaQuery.of(context).size.height * .25,
                ),
                height: MediaQuery.of(context).size.height * .30,
                fit: BoxFit.fill,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text("*" + (args.source?.name ?? "")),
                  Text(
                    args.title ?? "",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Text(
                    DateTime.parse(args.publishedAt ?? "").day.toString() +
                        " day ago.",
                    textAlign: TextAlign.end,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(22),
                      ),
                      child: Column(
                        children: [
                          Text(
                            args.description ?? "",
                            style: TextStyle(fontSize: 14),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "View full article",
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              Icon(
                                Icons.arrow_forward,
                                color: Colors.black,
                                size: 22,
                              )
                            ],
                          )
                        ],
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
