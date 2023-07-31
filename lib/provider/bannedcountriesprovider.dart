import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:rankcreditcard/models/country.dart';
import 'dart:convert';

class BannedCountriesProvider extends ChangeNotifier {

  late Box<bool?> _bannedCountriesBox;
  List<Country> countries = [];

  String? _issuingCountry;

  String? get issuingCountry => _issuingCountry;

  setIssuingCountry(String newValue) {
    _issuingCountry = newValue;
    notifyListeners();
  }

  List<String> get unbannedCountries {
    return countries.where((country) => !isCountryBanned(country.code)).map((country) => country.name).toList();
  }

  BannedCountriesProvider() {
    _init();
  }

  Future<void> _init() async {
    _bannedCountriesBox = await Hive.openBox('banned_countries');
    countries = await _loadCountries();
    notifyListeners();
  }

  Future<List<Country>> _loadCountries() async {
    String jsonContent = await rootBundle.loadString('data/country_phone_codes.json');
    List<dynamic> jsonData = jsonDecode(jsonContent);
    List<Country> countries = jsonData.map((item) => Country(
      name: item['name'],
      flag: item['flag'],
      code: item['code'],
      dialCode: item['dial_code'],
      isBanned: false,
    )).toList();

    return countries;
  }

  bool isCountryBanned(String countryCode) {
    return _bannedCountriesBox.get(countryCode) ?? false;
  }

  void setCountryBanned(String countryCode, bool isBanned) {
    _bannedCountriesBox.put(countryCode, isBanned);
    notifyListeners();
  }

  @override
  void dispose() {
    _bannedCountriesBox.close();
    super.dispose();
  }
}
