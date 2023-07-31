import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rankcreditcard/adapters/creditcardmodeladapter.dart';
import 'package:rankcreditcard/models/credit_card_model.dart';
import 'package:rankcreditcard/provider/bannedcountriesprovider.dart';
import 'package:rankcreditcard/ui/listcountries.dart';
import 'package:rankcreditcard/ui/creditcardentry.dart';
import 'package:rankcreditcard/ui/landingpage.dart';
import 'package:rankcreditcard/ui/submitted_cards.dart';
// developed by Ryan Godlonton-Shaw //

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(CreditCardHiveModelAdapter());
  await Hive.openBox<CreditCardHiveModel>('credit_cards');
  runApp(
    ChangeNotifierProvider(
      create: (_) => BannedCountriesProvider(),
      child: CreditCardApp(),
    ),
  );
}

class CreditCardApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: LandingPage(),
          routes: {
            '/addCard': (context) => CreditCardEntry(),
            '/bannedCountries': (context) => CountryListScreen(),
            '/savedCards': (context) => CreditCardListScreen(),
          },
        );
  }
}
