import 'dart:io';

import 'package:fast_news/models/news_item.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsDetailPage extends StatefulWidget {
  final NewsItem newsData;

  const NewsDetailPage({Key key, this.newsData}) : super(key: key);
  @override
  _NewsDetailPageState createState() => _NewsDetailPageState(newsData);
}

class _NewsDetailPageState extends State<NewsDetailPage> {
  final NewsItem newsData;

  _NewsDetailPageState(this.newsData);
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(newsData.title ?? "Başlık Bulunamadı!"),
      ),
      body: WebView(initialUrl: newsData.link),
    );
  }
}
