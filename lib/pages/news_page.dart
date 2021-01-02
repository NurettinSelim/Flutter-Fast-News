import 'package:fast_news/models/news_item.dart';
import 'package:fast_news/services/news.dart';
import 'package:fast_news/widgets/news_page/info_sheet.dart';
import 'package:fast_news/widgets/news_page/news_drawer.dart';
import 'package:fast_news/widgets/news_page/news_list_tile.dart';
import 'package:fast_news/widgets/news_page/news_search_delegate.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final NewsService _news = NewsService();

  int seciliSayfa = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: NewsDrawer(),
      appBar: AppBar(
        centerTitle: true,
        title: Text("Hızlı Haber"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () => showSearch(context: context, delegate: NewsSearchDelegate()),
          ),
          IconButton(
            icon: Icon(Icons.info_outline_rounded),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) => InfoSheet(),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<List<NewsItem>>(
        future: _news.news(seciliSayfa),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return RefreshIndicator(
              onRefresh: () async {
                setState(() {});
              },
              child: ListView.separated(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) => NewsListTile(newsData: snapshot.data[index]),
                separatorBuilder: (BuildContext context, int index) => Divider(thickness: 1.0),
              ),
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: seciliSayfa,
        onTap: (index) {
          setState(() {
            seciliSayfa = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.newspaper), label: "Gündem"),
          BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.globe), label: "Dünya"),
          BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.atom), label: "Bilim Teknoloji"),
          BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.solidMoneyBillAlt), label: "Ekonomi"),
        ],
      ),
    );
  }
}
