import 'package:fast_news/models/news_item.dart';
import 'package:fast_news/models/news_source.dart';
import 'package:fast_news/services/news.dart';
import 'package:fast_news/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  final document = await getApplicationDocumentsDirectory();
  Hive
    ..init(document.path)
    ..registerAdapter(NewsSourceAdapter())
    ..registerAdapter(NewsItemAdapter());

  final settingsBox = await Hive.openBox<bool>("Settings");

  //initialize isDarkTheme value
  settingsBox.put("isDarkTheme", settingsBox.get("isDarkTheme") ?? false);

  await Hive.openBox<List<NewsItem>>("News");

  await Hive.openBox<NewsSource>("Sources");
  NewsService.getSources();

  Intl.defaultLocale = 'tr';
  initializeDateFormatting('tr');

  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box<bool>('Settings').listenable(),
      builder: (BuildContext context, Box<bool> box, widget) {
        return MaterialApp(
          theme: ThemeData(
            textTheme: GoogleFonts.cabinTextTheme(),
            brightness: Brightness.light,
          ),
          darkTheme: ThemeData(
            textTheme: GoogleFonts.cabinTextTheme(ThemeData(brightness: Brightness.dark).textTheme),
            brightness: Brightness.dark,
          ),
          themeMode: box.get('isDarkTheme') ? ThemeMode.dark : ThemeMode.light,
          title: 'Hızlı Haber',
          home: FastNews(),
        );
      },
    );
  }
}

class FastNews extends StatefulWidget {
  @override
  _FastNewsState createState() => _FastNewsState();
}

class _FastNewsState extends State<FastNews> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 3), () async {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Wrapper()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(FontAwesomeIcons.newspaper, size: 45),
          SizedBox(height: 10),
          Text(
            "Hızlı Haber",
            style: GoogleFonts.raleway(fontSize: 45, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          SpinKitThreeBounce(color: Colors.amber, size: 45),
        ],
      ),
    );
  }
}
