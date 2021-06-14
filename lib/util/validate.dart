class Validate{

  static bool isNumeric(String numeric) {
    if (numeric == null) {
      return false;
    }
    return int.tryParse(numeric) != null;
  }

  static bool isDoubleNumeric(String numeric) {
    if (numeric == null) {
      return false;
    }
    return double.tryParse(numeric) != null;
  }

  static bool isValidEmail(String email){
    return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
  }

}