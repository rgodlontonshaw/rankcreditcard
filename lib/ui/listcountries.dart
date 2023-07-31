import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rankcreditcard/global/global.dart';
import 'package:rankcreditcard/models/country.dart';

import 'package:rankcreditcard/provider/bannedcountriesprovider.dart';

class CountryListScreen extends StatefulWidget {

  @override
  _CountryScreenState createState() => _CountryScreenState();
}

class _CountryScreenState extends State<CountryListScreen> {

  List<Country> countries = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var bannedCountriesProvider = Provider.of<BannedCountriesProvider>(context);
    var countries = bannedCountriesProvider.countries;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: appRankColor,
        title: Text('Banned Countries', style: TextStyle(color: Colors.black87)),
      ),
      body: ListView.builder(
      itemCount: countries.length,
      itemBuilder: (context, index) {
        Country country = countries[index];
        bool? isBanned = bannedCountriesProvider.isCountryBanned(country.code);

        return ListTile(
          leading: Text(country.flag),
          title: Text(country.name),
          subtitle: Text(country.dialCode),
          trailing: Checkbox(
            value: isBanned,
            onChanged: (value) {
              bannedCountriesProvider.setCountryBanned(country.code, value!);
            },
          ),
        );
        },
      ),
    );
  }
}
