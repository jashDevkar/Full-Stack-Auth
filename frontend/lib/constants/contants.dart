class Constants {
  static String uri = "http://192.168.0.105:6000";

  final RegExp _nameRegex = RegExp(r"^[a-zA-Z ]{3,}$");
  final RegExp _emailRegex =
      RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");


  RegExp get nameRegex => _nameRegex;
  RegExp get emailRegex => _emailRegex;

}
