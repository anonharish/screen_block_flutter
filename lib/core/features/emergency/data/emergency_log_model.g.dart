// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emergency_log_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EmergencyLogModelAdapter extends TypeAdapter<EmergencyLogModel> {
  @override
  final int typeId = 1;

  @override
  EmergencyLogModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EmergencyLogModel(
      date: fields[0] as DateTime,
      usedDuration: fields[1] as Duration,
    );
  }

  @override
  void write(BinaryWriter writer, EmergencyLogModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.usedDuration);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EmergencyLogModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
