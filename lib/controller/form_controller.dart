import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import '../model/form.dart';

class FormController {
  final void Function(String) callback;

  static const String URL = "https://script.google.com/macros/s/AKfycbyahc76xgl0lH-mauVAMexauseU_p0Uk8nWkW__T-RJyRSU_WgI/exec";

  //static const String URL = "https://script.google.com/macros/s/AKfycbyAaNh-1JK5pSrUnJ34Scp3889mTMuFI86DkDp42EkWiSOOycE/exec";

  static const STATUS_SUCCESS = 'SUCCESS';

  FormController(this.callback);

  void submitForm(FeedbackForm feedbackForm) async {
    try {
      await http
          .get(
            URL + feedbackForm.toParams(),
          )
          .then((res) {
              callback(convert.jsonDecode(res.body)['status']);
          });
    } catch (error) {
      print(error);
    }
  }
}
