import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rankcreditcard/global/global.dart';
import 'package:rankcreditcard/models/credit_card_model.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

class CreditCardListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: appRankColor,
        title: Text(
          'Saved Credit Cards',
          style: TextStyle(color: Colors.black87),
        ),
      ),
      body: FutureBuilder(
        future: Hive.openBox<CreditCardHiveModel>('credit_cards'),
        builder: (BuildContext context,
            AsyncSnapshot<Box<CreditCardHiveModel>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData && snapshot.data!.length > 0) {
              var creditCardBox = snapshot.data!;
              var creditCards = creditCardBox.values.toList();
              return ListView.builder(
                itemCount: creditCards.length,
                itemBuilder: (context, index) {
                  var creditCard = creditCards[index];
                  return Dismissible(
                    key: Key(creditCard.key.toString()),
                    onDismissed: (direction) {
                      // Delete the card when it is swiped
                      creditCard.delete();
                    },
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(right: 20),
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                    child: CreditCardWidget(
                      cardNumber: creditCard.cardNumber,
                      expiryDate: creditCard.expiryDate,
                      cardHolderName: creditCard.cardHolderName,
                      cvvCode: creditCard.cvvCode,
                      bankName: 'Rank Bank',
                      showBackView: false,
                      obscureCardNumber: false,
                      obscureCardCvv: true,
                      isHolderNameVisible: true,
                      cardBgColor: Colors.blueGrey.shade700,
                      isSwipeGestureEnabled: true,
                      onCreditCardWidgetChange: (CreditCardBrand) {},
                    ),
                  );
                },
              );
            } else {
              return Center(
                child: Text(
                  'No saved credit cards.',
                  style: TextStyle(color: Colors.black87),
                ),
              );
            }
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
