// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cat.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CatModelAdapter extends TypeAdapter<CatModel> {
  @override
  final int typeId = 1;

  @override
  CatModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CatModel(
      name: fields[0] as String,
      type: fields[1] as String,
      age: fields[2] as int,
      owned: fields[3] as bool,
      note: fields[4] as String,
      allergies: (fields[5] as List).cast<String>(),
      cover: fields[6] as Uint8List,
      images: (fields[7] as List).cast<Uint8List>(),
    );
  }

  @override
  void write(BinaryWriter writer, CatModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.type)
      ..writeByte(2)
      ..write(obj.age)
      ..writeByte(3)
      ..write(obj.owned)
      ..writeByte(4)
      ..write(obj.note)
      ..writeByte(5)
      ..write(obj.allergies)
      ..writeByte(6)
      ..write(obj.cover)
      ..writeByte(7)
      ..write(obj.images);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CatModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
