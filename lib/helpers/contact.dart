import 'package:url_launcher/url_launcher.dart';

class Contact {
  call(String number) async {
    final uri = 'tel:$number';
    if (await canLaunch(uri)) {
      await launch(uri);
    }
  }

  sms(String number, String text) async {
    // Android
    final finalText = Uri.encodeFull(text);
    final uri = 'sms:$number?body=$finalText';
    // final uri = 'sms:$number?body=hello%20there';
    if (await canLaunch(uri)) {
      await launch(uri);
    }
    // else {
    // iOS // I don't think I'd need this
    // const uri = 'sms:0039-222-060-888?body=hello%20there';
    //// const uri = 'sms:98456454&body=text%20message';
    // if (await canLaunch(uri)) {
    //   await launch(uri);
    // } else {
    //   throw 'Could not launch $uri';
    // }
    // }
  }
}
