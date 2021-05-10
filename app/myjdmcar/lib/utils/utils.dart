

bool isEmailValid(String email) {
  String regexEmail = r'^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  if (RegExp(regexEmail).hasMatch(email)) {
    return true;
  }

  return false;
}

bool isPasswordValid(String password) {
    if (password.length < 8) {
      return false;
    } 
    return true;
}

bool isPostalCodeValid(String postalCode) {
  String regexEmail = r'^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  if (RegExp(regexEmail).hasMatch(postalCode)) {
    return true;
  }

  return false;
}

double parseCommaDecimal(String value) {
  String _noComma = value.replaceAll(",", ".");

  double _result = double.tryParse(_noComma);

  return _result;
}


String capitalize(String value) {
  if (value.isNotEmpty)
    return "${value[0].toUpperCase()}${value.substring(1)}";
  return null;
}

/// Retorna una unitat de temps amb dos dígits
String twoDigits(int n) {
  if (n >= 10) return "$n";
  return "0$n";
}

String formatDateToddmmyyyy(dynamic date) {
  print("formatDateToddmmyyyy --> $date");
  if (date.runtimeType == String) {
    //return Jiffy(date).format("dd/MM/yyyy");
  } else if (date.runtimeType == DateTime) {
    //return Jiffy(date).format("dd/MM/yyyy");
  }
  return "";
}

String formatDateTimeTodMy(DateTime dateTime) {
  return "${twoDigits(dateTime.day)}/${twoDigits(dateTime.month)}/${twoDigits(dateTime.year)}";
}

String formatDateTimeToyMd(DateTime dateTime) {
  return "${twoDigits(dateTime.year)}/${twoDigits(dateTime.month)}/${twoDigits(dateTime.day)}";
}

/// Retorna format de server
String formatDateTimeToServerFormat(DateTime dateTime) {
  return "${twoDigits(dateTime.year)}-${twoDigits(dateTime.month)}-${twoDigits(dateTime.day)} ${twoDigits(dateTime.hour)}:${twoDigits(dateTime.minute)}:${twoDigits(dateTime.second)}";
}

String formatDateTimeToServerFormatDate(DateTime dateTime) {
  return "${twoDigits(dateTime.year)}-${twoDigits(dateTime.month)}-${twoDigits(dateTime.day)}";
}

String formatTimeToHourMinutes(String time) {
  List<String> units = time.split(":");

  if (units.isNotEmpty)
    return "${units[0]}:${units[1]}";

  return "";
}

String formatPrice(double toFormat) {
  if (toFormat != null) {
    //print("formatPrice: $toFormat");
    String _format = "${(toFormat * 100).floor() / 100}";

    // Comprovem si falta afegir 0 final
    if (_format.indexOf(".") == _format.length - 2) {
      return "${_format}0";
    }

    return _format;
  }
  return "NAN";
}

String formatDate(String date){
 // return Jiffy(date, "dd/MM/yyyy").format("yyyy-MM-dd");
}

/// Retorna un [double] si [value] conté un valor decimal o numèric.
/// Contempla els casos d'indicar unitats superiors a 999 amb "."
/// En cas de fallar retornarà null.
double getDecimalValue(String value) {
  if (value.indexOf(".") >= 0 && value.indexOf(",") >= 0) {
    // Comprovem si el valor passat té tant punts com comes.
    // En aquest cas els punts els eliminarem i substituirem les comes per punts
    String _modifiedValue = value.replaceAll(".", "");

    print("getDecimalValue _modifiedValue no '.': $_modifiedValue");

    _modifiedValue = _modifiedValue.replaceAll(",", ".");

    print("getDecimalValue _modifiedValue no ',': $_modifiedValue");

    double _doubleValue = double.tryParse(_modifiedValue);

    print("getDecimalValue _doubleValue: $_doubleValue");

    return _doubleValue;
  } else if (value.indexOf(",") >= 0) {
    // Comprovem si el valor passat només té comes
    String _modifiedValue = value.replaceAll(",", ".");

    print("getDecimalValue elif _modifiedValue no ',': $_modifiedValue");

    double _doubleValue = double.tryParse(_modifiedValue);

    print("getDecimalValue elif _doubleValue: $_doubleValue");

    return _doubleValue;
  } else {
    // La resta de casos seràn valors enters o decimals amb punt
    double _doubleValue = double.tryParse(value);

    print("getDecimalValue else _doubleValue: $_doubleValue");

    return _doubleValue;
  }
}
