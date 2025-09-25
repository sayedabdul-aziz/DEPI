class AppRegex {
  static bool isEmailValid(String email) {
    String emailPattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    RegExp regex = RegExp(emailPattern);
    return regex.hasMatch(email);
  }

  static bool isEgyptPhoneValid(String phone) {
    String phonePattern = r'^01[0125][0-9]{8}$'; // r'^[010|011|012|015]{8}$';
    RegExp regex = RegExp(phonePattern);
    return regex.hasMatch(phone);
  }
}
