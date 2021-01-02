import 'package:hive/hive.dart';
part 'news_source.g.dart';

@HiveType(typeId: 0)
class NewsSource extends HiveObject {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final Map<String, String> links;

  @HiveField(2)
  bool isSelected = true;

  @HiveField(3)
  Map<String, String> selectedLinks;

  NewsSource({this.name, this.links});
}
