import 'package:fast_news/models/news_source.dart';
import 'package:fast_news/services/auth.dart';
import 'package:fast_news/widgets/news_page/theme_switch.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class NewsDrawer extends StatefulWidget {
  @override
  _NewsDrawerState createState() => _NewsDrawerState();
}

class _NewsDrawerState extends State<NewsDrawer> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(_auth.user.displayName ?? "Kullanıcı Adı"),
            accountEmail: Text(_auth.user.email ?? ""),
          ),
          newsSourceTiles,
          Expanded(
            child: Container(),
          ),
          Row(
            children: [
              Text("Tema Ayarı:", style: Theme.of(context).textTheme.headline5),
              ThemeSwitch(),
            ],
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          ),
          Divider(),
          TextButton.icon(
            onPressed: () {
              _auth.signOut();
            },
            icon: Icon(Icons.logout),
            label: Text("Çıkış Yap", style: Theme.of(context).textTheme.headline6),
          )
        ],
      ),
    );
  }

  Widget get newsSourceTiles => ValueListenableBuilder(
        valueListenable: Hive.box<NewsSource>('Sources').listenable(),
        builder: (BuildContext context, Box<NewsSource> box, widget) {
          List<Widget> listTiles = [];
          box.toMap().forEach((key, value) {
            listTiles.add(
              CheckboxListTile(
                title: Text(value.name),
                value: value.isSelected,
                onChanged: (status) {
                  value.isSelected = status;
                  value.save();
                },
              ),
            );
          });

          return ExpansionTile(
            title: Text("Haber Kaynağı", style: Theme.of(context).textTheme.headline6),
            children: listTiles,
          );
        },
      );
}
