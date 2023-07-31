import 'package:hive/hive.dart';
import 'package:rankcreditcard/models/credit_card_model.dart';

class CreditCardHiveModelAdapter extends TypeAdapter<CreditCardHiveModel> {
  @override
  final int typeId = 1;

  @override
  CreditCardHiveModel read(BinaryReader reader) {
    return CreditCardHiveModel(
      cardNumber: reader.readString(),
      expiryDate: reader.readString(),
      cardHolderName: reader.readString(),
      cvvCode: reader.readString(),
      issuingCountry: reader.readString(),
    );
  }

  @override
  void write(BinaryWriter writer, CreditCardHiveModel card) {
    writer.writeString(card.cardNumber);
    writer.writeString(card.expiryDate);
    writer.writeString(card.cardHolderName);
    writer.writeString(card.cvvCode);
    writer.writeString(card.issuingCountry);
  }
}
