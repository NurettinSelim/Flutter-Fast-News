import 'package:fast_news/models/news_item.dart';
import 'package:fast_news/models/news_source.dart';
import 'package:hive/hive.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show utf8;
import 'package:webfeed/webfeed.dart';

class NewsService {
  Future<List<NewsItem>> news(int index) async {
    // Get selected Sources from Hive
    Box<NewsSource> sourcesBox = Hive.box<NewsSource>('Sources');

    // If Source checked adds in to the requests list
    var requests = sourcesBox.values.map((e) {
      if (e.isSelected) {
        return http.get(e.links.values.toList()[index]);
      }
    }).toList();

    requests.removeWhere((value) => value == null);

    // Makes all requests
    var responses = await Future.wait(requests);

    // Process all responses
    var rssItems = responses.map((e) {
      String utf8Data = utf8.decode(e.bodyBytes);

      String data = HtmlUnescape().convert(utf8Data);
      return RssFeed.parse(data).items;
    }).toList();

    // rssItems is list>list>rssItem
    // This process converts to list in rsssItem(list>rssItem)
    List<RssItem> mergedList = [];
    rssItems.forEach((e) => mergedList.addAll(e));

    //Sorts by pubDate, newer news are top of the list.
    mergedList.sort((a, b) => b.pubDate.compareTo(a.pubDate));

    // Converts rssItem to NewsItem
    // Because we want to save this objects to Hive for making search in news.
    List<NewsItem> newsItems = mergedList.map((e) => NewsItem(e.title, e.link, e.pubDate.millisecondsSinceEpoch + 10800000, e.imageUrl)).toList();

    Hive.box<List<NewsItem>>("News").put("lastNews", newsItems);

    return newsItems;
  }

  static getSources() {
    //TODO get sources from firebase
    final NewsSource cnnNews = NewsSource(
      name: "CNN",
      links: {
        "allNews": "https://www.cnnturk.com/feed/rss/all/news",
        "world": "https://www.cnnturk.com/feed/rss/dunya/news",
        "science": "https://www.cnnturk.com/feed/rss/bilim-teknoloji/news",
        "economy": "https://www.cnnturk.com/feed/rss/ekonomi/news",
      },
    );
    final NewsSource t24News = NewsSource(
      name: "T24",
      links: {
        "allNews": "https://t24.com.tr/rss",
        "world": "https://t24.com.tr/rss/haber/dunya",
        "science": "https://t24.com.tr/rss/haber/bilim-teknoloji",
        "economy": "https://t24.com.tr/rss/haber/ekonomi",
      },
    );

    Hive.box<NewsSource>("Sources").put("cnn", cnnNews);
    Hive.box<NewsSource>("Sources").put("t24", t24News);
  }
}
