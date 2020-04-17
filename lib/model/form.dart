class FeedbackForm {
  String _name;
  String _email;
  String _mobileno;

  FeedbackForm(
    this._name,
    this._email,
    this._mobileno,
  );

  String toParams() => "?name=$_name&email=$_email&mobileNo=$_mobileno";
}
