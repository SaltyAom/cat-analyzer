import 'package:hive/hive.dart';
import 'dart:typed_data';

part 'cat.g.dart';

@HiveType(typeId: 1)
class CatModel {
  CatModel({
    required this.name,
    this.type = "unknown",
    this.age = 0,
    this.owned = false,
    this.note = "",
    this.allergies = const [],
    required this.cover,
    this.images = const [],
  });

  @HiveField(0)
  String name;

  @HiveField(1)
  String type = 'unknown';

  @HiveField(2)
  int age = 0;

  @HiveField(3)
  bool owned = false;

  @HiveField(4)
  String note = '';

  @HiveField(5)
  List<String> allergies = [];

  @HiveField(6)
  Uint8List cover;

  @HiveField(7)
  List<Uint8List> images = [];
}
