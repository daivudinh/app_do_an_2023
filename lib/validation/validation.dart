class Validation{

  bool validatorEmail(String email){
    String  pattern = r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    RegExp regExp = RegExp(pattern);
    bool emailValid = regExp.hasMatch(email);
    return emailValid;
  }

  /// password mush have
  /// * Uppercase letters: A-Z.
  /// * Lowercase letters: a-z.
  /// * Numbers: 0-9.
  /// * Symbols: ~`!@#$%^&*()_-+={[}]|\:;"'<,>.?/
  /// at least 6 character
  bool validatorPassword(String password){
    String  pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(password);
  }

}