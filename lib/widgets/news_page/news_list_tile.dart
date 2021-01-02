import 'package:cached_network_image/cached_network_image.dart';
import 'package:fast_news/models/news_item.dart';
import 'package:fast_news/pages/news_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NewsListTile extends StatelessWidget {
  final NewsItem newsData;

  const NewsListTile({Key key, this.newsData}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: newsData.imageUrl == null
          ? Icon(FontAwesomeIcons.newspaper)
          : CachedNetworkImage(
              imageUrl: newsData.imageUrl,
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
      title: Text(newsData.title ?? "Başlık Bulunamadı!"),
      subtitle: Text("$newsSourceName  ${newsData.prettyDate}"),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => NewsDetailPage(newsData: newsData)));
      },
    );
  }

  String get newsSourceName {
    if (newsData.link.contains("cnnturk"))
      return "CNN";
    else if (newsData.link.contains("t24")) return "T24";
    return "";
  }
}
