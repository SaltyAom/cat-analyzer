import 'package:hive/hive.dart';
import 'dart:typed_data';

part 'cat.g.dart';

@HiveType(typeId: 1)
class CatModel {
  @HiveField(0)
  String name = 'Taro';

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
  Uint8List? cover;

  @HiveField(7)
  List<Uint8List> images = [];
}
