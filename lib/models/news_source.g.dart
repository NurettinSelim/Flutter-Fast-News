// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_source.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NewsSourceAdapter extends TypeAdapter<NewsSource> {
  @override
  final int typeId = 0;

  @override
  NewsSource read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NewsSource(
      name: fields[0] as String,
      links: (fields[1] as Map)?.cast<String, String>(),
    )..isSelected = fields[2] as bool;
  }

  @override
  void write(BinaryWriter writer, NewsSource obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.links)
      ..writeByte(2)
      ..write(obj.isSelected);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NewsSourceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
