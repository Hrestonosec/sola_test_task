// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'charging_station.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ChargingStationAdapter extends TypeAdapter<ChargingStation> {
  @override
  final int typeId = 0;

  @override
  ChargingStation read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ChargingStation(
      id: fields[0] as String,
      name: fields[1] as String,
      latitude: fields[2] as double,
      longitude: fields[3] as double,
      address: fields[4] as String,
      power: fields[5] as double,
      connectors: (fields[6] as List).cast<String>(),
      isAvailable: fields[7] as bool,
      price: fields[8] as double,
      operator: fields[9] as String,
      rating: fields[10] as double,
    );
  }

  @override
  void write(BinaryWriter writer, ChargingStation obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.latitude)
      ..writeByte(3)
      ..write(obj.longitude)
      ..writeByte(4)
      ..write(obj.address)
      ..writeByte(5)
      ..write(obj.power)
      ..writeByte(6)
      ..write(obj.connectors)
      ..writeByte(7)
      ..write(obj.isAvailable)
      ..writeByte(8)
      ..write(obj.price)
      ..writeByte(9)
      ..write(obj.operator)
      ..writeByte(10)
      ..write(obj.rating);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChargingStationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
