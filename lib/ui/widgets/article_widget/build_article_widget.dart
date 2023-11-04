import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app1/data/model/ArticleResponse.dart';
import 'package:news_app1/providers/my_provider.dart';
import 'package:news_app1/ui/screens/home/tabs/news_tab/article_details.dart';
import 'package:news_app1/ui/widgets/loading_widget/loader.dart';
import 'package:provider/provider.dart';

class BuildArticleWidget extends StatelessWidget {
  final Article article;

  BuildArticleWidget({super.key, required this.article});

  late MyProvider provider;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of(context);
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, ArticleDetails.routeName,
            arguments: article);
      },
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: provider.isDarkMode() ? Color(0xffD3D3D3) : Colors.white,
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: Colors.grey, // Shadow color
              offset: Offset(0, 2), // Shadow position (horizontal, vertical)
              blurRadius: 4, // Shadow blur radius
              spreadRadius: 0, // Spread radius
            ),
          ],
        ),
        margin: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(22), topLeft: Radius.circular(22)),
              child: CachedNetworkImage(
                imageUrl: article.urlToImage ?? "",
                placeholder: (_, __) => Loader(),
                errorWidget: (_, __, ___) => Image.asset(
                  "assets/images/news.jpg",
                  height: MediaQuery.of(context).size.height * .25,
                ),
                height: MediaQuery.of(context).size.height * .25,
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              article.source?.name ?? "",
              style: GoogleFonts.poppins(color: Colors.grey, fontSize: 12),
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              article.title ?? "",
              style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.normal),
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              DateTime.parse(article.publishedAt ?? "").hour.toString() +
                  " hours ago.",
              textAlign: TextAlign.end,
              style: GoogleFonts.inter(color: Colors.grey, fontSize: 12),
            )
          ],
        ),
      ),
    );
  }
}
