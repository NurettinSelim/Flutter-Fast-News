import 'package:fast_news/models/news_item.dart';
import 'package:fast_news/pages/news_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class NewsSearchDelegate extends SearchDelegate {
  final news = Hive.box<List<NewsItem>>("News").get("lastNews");
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final queriedNews = news.where((i) => i.title.toLowerCase().contains(query)).toList();
    return ListView.builder(
      itemCount: queriedNews.length,
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => NewsDetailPage(newsData: queriedNews[index])));
          },
          title: Text(queriedNews[index].title ?? "Başlık Bulunamadı!"),
          trailing: Icon(Icons.subdirectory_arrow_right),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final queriedNews = news.where((i) => i.title.toLowerCase().contains(query)).toList();
    return ListView.builder(
      itemCount: queriedNews.length,
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => NewsDetailPage(newsData: queriedNews[index])));
          },
          title: Text(queriedNews[index].title ?? "Başlık Bulunamadı!"),
          trailing: Icon(Icons.subdirectory_arrow_right),
        );
      },
    );
  }
}
