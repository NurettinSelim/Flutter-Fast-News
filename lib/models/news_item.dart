import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
part 'news_item.g.dart';

@HiveType(typeId: 1)
class NewsItem {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final String link;

  @HiveField(2)
  final int pubTimestamp;

  @HiveField(3)
  final String imageUrl;

  get pubDate => DateTime.fromMillisecondsSinceEpoch(pubTimestamp, isUtc: true);

  String get prettyDate {
    final f = DateFormat("d MMMM HH:mm");
    return f.format(this.pubDate);
  }

  NewsItem(this.title, this.link, this.pubTimestamp, this.imageUrl);
}
