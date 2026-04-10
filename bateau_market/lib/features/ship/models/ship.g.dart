// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ship.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ShipAdapter extends TypeAdapter<Ship> {
  @override
  final typeId = 1;

  @override
  Ship read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Ship(
      name: fields[0] as String,
      power: (fields[1] as num).toInt(),
      nbHourOfAutonomy: (fields[2] as num).toInt(),
      nbPeopleMax: (fields[3] as num).toInt(),
      marketPlace: fields[4] as String,
      price: fields[5] as Decimal,
      lat: (fields[6] as num).toDouble(),
      lng: (fields[7] as num).toDouble(),
    );
  }

  @override
  void write(BinaryWriter writer, Ship obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.power)
      ..writeByte(2)
      ..write(obj.nbHourOfAutonomy)
      ..writeByte(3)
      ..write(obj.nbPeopleMax)
      ..writeByte(4)
      ..write(obj.marketPlace)
      ..writeByte(5)
      ..write(obj.price)
      ..writeByte(6)
      ..write(obj.lat)
      ..writeByte(7)
      ..write(obj.lng);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ShipAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
