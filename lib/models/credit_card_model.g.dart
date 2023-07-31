// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credit_card_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CreditCardModelAdapter extends TypeAdapter<CreditCardHiveModel> {
  @override
  final int typeId = 0;

  @override
  CreditCardHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CreditCardHiveModel(
      cardNumber: fields[0] as String,
      expiryDate: fields[1] as String,
      cardHolderName: fields[2] as String,
      cvvCode: fields[3] as String,
      issuingCountry: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CreditCardHiveModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.cardNumber)
      ..writeByte(1)
      ..write(obj.expiryDate)
      ..writeByte(2)
      ..write(obj.cardHolderName)
      ..writeByte(3)
      ..write(obj.cvvCode)
      ..writeByte(4)
      ..write(obj.issuingCountry);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CreditCardModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
