import 'package:hive/hive.dart';
part 'credit_card_model.g.dart';

@HiveType(typeId: 0)
class CreditCardHiveModel extends HiveObject {
  @HiveField(0)
  String cardNumber;

  @HiveField(1)
  String expiryDate;

  @HiveField(2)
  String cardHolderName;

  @HiveField(3)
  String cvvCode;

  @HiveField(4)
  String issuingCountry;

  CreditCardHiveModel({
    required this.cardNumber,
    required this.expiryDate,
    required this.cardHolderName,
    required this.cvvCode,
    required this.issuingCountry,
  });
}
