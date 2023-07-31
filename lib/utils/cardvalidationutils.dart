class CreditCardUtils {
  bool validateCardNumber(String cardNumber) {
    String cleanedCardNumber = cardNumber.replaceAll(RegExp(r'\D'), '');
    if (cleanedCardNumber.length < 13 || cleanedCardNumber.length > 19) {
      return false;
    }
    if (!_luhnAlgorithmCheck(cleanedCardNumber)) {
      return false;
    }
    if (!_isCardTypeSupported(cleanedCardNumber)) {
      return false;
    }
    return true;
  }

  bool validateExpiryDate(String expiryDate) {
    if (!RegExp(r'^\d{2}/\d{2}$').hasMatch(expiryDate)) {
      return false;
    }

    List<String> dateParts = expiryDate.split('/');
    int month = int.tryParse(dateParts[0]) ?? 0;
    int year = int.tryParse(dateParts[1]) ?? 0;

    if (month < 1 || month > 12 || year < 0) {
      return false;
    }

    DateTime now = DateTime.now();

    DateTime lastDayOfMonth = DateTime(now.year + year, month + 1, 0);

    if (lastDayOfMonth.isBefore(now)) {
      return false;
    }

    return true;
  }


  bool validateCardHolderName(String cardHolderName) {
    if (cardHolderName.trim().isEmpty) {
      return false;
    }

    if (!RegExp(r'^[a-zA-Z\s]{3,}$').hasMatch(cardHolderName)) {
      return false;
    }

    return true;
  }


  bool validateCVV(String cvv) {
    if (!RegExp(r'^\d{3,4}$').hasMatch(cvv)) {
      return false;
    }

    return true;
  }


  bool _luhnAlgorithmCheck(String cardNumber) {
    int sum = 0;
    bool isEven = false;

    for (int i = cardNumber.length - 1; i >= 0; i--) {
      int digit = int.parse(cardNumber[i]);

      if (isEven) {
        digit *= 2;
        if (digit > 9) {
          digit -= 9;
        }
      }

      sum += digit;
      isEven = !isEven;
    }

    return sum % 10 == 0;
  }

  bool _isCardTypeSupported(String cardNumber) {
    final Map<String, RegExp> cardTypePatterns = {
      'Mastercard': RegExp(r'^5[1-5][0-9]{14}$'),
      'Visa': RegExp(r'^4[0-9]{15}$'),
      'American Express': RegExp(r'^3[47][0-9]{13}$'),
    };

    for (String cardType in cardTypePatterns.keys) {
      if (cardTypePatterns[cardType]!.hasMatch(cardNumber)) {
        print('Card Type: $cardType');
        return true;
      }
    }

    return false;
  }
}
