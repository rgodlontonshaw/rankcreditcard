import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_brand.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:rankcreditcard/global/global.dart';
import 'package:rankcreditcard/models/country.dart';
import 'package:rankcreditcard/models/credit_card_model.dart';
import 'package:rankcreditcard/provider/bannedcountriesprovider.dart';
import 'package:rankcreditcard/ui/submitted_cards.dart';
import 'package:credit_card_scanner/credit_card_scanner.dart';
import 'package:rankcreditcard/utils/cardvalidationutils.dart';

class CreditCardEntry extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return CreditCardView();
  }
}

class CreditCardView extends State<CreditCardEntry> {

  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  String issuingCountry = '';
  bool isCvvFocused = false;
  OutlineInputBorder? border;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late Box<bool?> bannedCountriesBox;
  List<Country> countries = [];

  @override
  void initState() {
    border = const OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.black,
      ),
    );
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    var bannedCountriesProvider = Provider.of<BannedCountriesProvider>(context);
   return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 0,
          backgroundColor: appRankColor,
          title: Text(
            'Add Card',
            style: TextStyle(color: Colors.black87),
          ),
        ),
        resizeToAvoidBottomInset: true, // Set this to true
        body: SafeArea(
          child: ListView(
            children: <Widget>[
              const SizedBox(
                height: 30,
              ),
              CreditCardWidget(
                cardNumber: cardNumber,
                expiryDate: expiryDate,
                cardHolderName: cardHolderName,
                cvvCode: cvvCode,
                bankName: 'Rank Bank',
                showBackView: isCvvFocused,
                obscureCardNumber: true,
                obscureCardCvv: true,
                isHolderNameVisible: true,
                cardBgColor: Colors.blueGrey.shade700,
                isSwipeGestureEnabled: true,
                onCreditCardWidgetChange: (CreditCardBrand creditCardBrand) {},
              ),
              CreditCardForm(
                formKey: formKey,
                obscureCvv: true,
                obscureNumber: false,
                cardNumber: cardNumber,
                cvvCode: cvvCode,
                isHolderNameVisible: true,
                isCardNumberVisible: true,
                isExpiryDateVisible: true,
                cardHolderName: cardHolderName,
                expiryDate: expiryDate,
                themeColor: Colors.blue,
                textColor: Colors.black,
                cardNumberDecoration: InputDecoration(
                    labelText: 'Number',
                    hintText: 'XXXX XXXX XXXX XXXX',
                    hintStyle: const TextStyle(color: Colors.black),
                    labelStyle: const TextStyle(color: Colors.black),
                    focusedBorder: border,
                    enabledBorder: border,
                    errorBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red,
                      ),
                    )),
                expiryDateDecoration: InputDecoration(
                  hintStyle: const TextStyle(color: Colors.black),
                  labelStyle: const TextStyle(color: Colors.black),
                  focusedBorder: border,
                  enabledBorder: border,
                  errorBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.red,
                    ),
                  ),
                  labelText: 'Expired Date',
                  hintText: 'XX/XX',
                ),
                cvvCodeDecoration: InputDecoration(
                  hintStyle: const TextStyle(color: Colors.black),
                  labelStyle: const TextStyle(color: Colors.black),
                  focusedBorder: border,
                  enabledBorder: border,
                  errorBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.red,
                    ),
                  ),
                  labelText: 'CVV',
                  hintText: 'XXX',
                ),
                cardHolderDecoration: InputDecoration(
                  hintStyle: const TextStyle(color: Colors.black),
                  labelStyle: const TextStyle(color: Colors.black),
                  focusedBorder: border,
                  enabledBorder: border,
                  labelText: 'Card Holder',
                ),
                onCreditCardModelChange: onCreditCardModel,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  width: 200, // Set a fixed width to limit the size
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(labelText: 'Issuing Country'),
                    value: bannedCountriesProvider.issuingCountry,
                    onChanged: (newValue) {
                      if (newValue != null) {
                        bannedCountriesProvider.setIssuingCountry(newValue);
                      }
                    },
                    items: bannedCountriesProvider.unbannedCountries.map((country) {
                      return DropdownMenuItem<String>(
                        value: country, // Use the country name as the value
                        child: Text(country),
                      );
                    }).toList(),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  _scanCard();
                },
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: const Text(
                    'Scan',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'halter',
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  _validateCreditCardDetails();
                },
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: const Text(
                    'Validate',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'halter',
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
  }

  void _validateCreditCardDetails() {
    CreditCardUtils creditCardUtils = CreditCardUtils();
    bool isCardNumberValid = creditCardUtils.validateCardNumber(cardNumber);
    bool isExpiryDateValid = creditCardUtils.validateExpiryDate(expiryDate);
    bool isCardHolderNameValid =
        creditCardUtils.validateCardHolderName(cardHolderName);
    bool isCvvValid = creditCardUtils.validateCVV(cvvCode);

    if (!isCardNumberValid) {
      _showErrorToast('Invalid Card Number');
    } else if (!isExpiryDateValid) {
      _showErrorToast('Invalid Expiry Date');
    } else if (!isCardHolderNameValid) {
      _showErrorToast('Invalid Card Holder Name');
    } else if (!isCvvValid) {
      _showErrorToast('Invalid CVV');
    } else {
      _saveCreditCardToHive();
      print('valid!');
    }
  }

  void _showErrorToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  void _saveCreditCardToHive() async {
    var creditCardBox = await Hive.openBox<CreditCardHiveModel>('credit_cards');
    var creditCard = CreditCardHiveModel(
      cardNumber: cardNumber,
      expiryDate: expiryDate,
      cardHolderName: cardHolderName,
      cvvCode: cvvCode,
      issuingCountry: issuingCountry,
    );

    var duplicateCardIndex = creditCardBox.values.toList().indexWhere(
          (card) =>
              card.cardNumber == creditCard.cardNumber &&
              card.expiryDate == creditCard.expiryDate &&
              card.cardHolderName == creditCard.cardHolderName &&
              card.cvvCode == creditCard.cvvCode &&
              card.issuingCountry == creditCard.issuingCountry,
        );

    if (duplicateCardIndex != -1) {
      _showErrorToast('Error: Credit card already exists.');
      return;
    }

    creditCardBox.add(creditCard);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => CreditCardListScreen()),
    );
  }

  void onCreditCardModel(CreditCardModel? creditCardModel) {
    setState(() {
      cardNumber = creditCardModel!.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }

  Future<void> _scanCard() async {
    try {
      var cardDetails = await CardScanner.scanCard(
        scanOptions: CardScanOptions(
          scanCardHolderName: true,
          scanExpiryDate: true,
        ),
      );

      if (!mounted || cardDetails == null) return;

      setState(() {
        expiryDate = cardDetails.expiryDate;
        cardHolderName = cardDetails.cardHolderName;
        cardNumber = cardDetails.cardNumber;
      });
    } catch (e) {
      _showErrorToast('Error while scanning credit card: $e');
    }
  }
}
